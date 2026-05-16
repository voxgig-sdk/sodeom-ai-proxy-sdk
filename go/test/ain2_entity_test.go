package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/sodeom-ai-proxy-sdk"
	"github.com/voxgig-sdk/sodeom-ai-proxy-sdk/core"

	vs "github.com/voxgig/struct"
)

func TestAin2Entity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Ain2(nil)
		if ent == nil {
			t.Fatal("expected non-nil Ain2Entity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := ain2BasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "ain2." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set SODEOMAIPROXY_TEST_AIN__ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		ain2Ref01Ent := client.Ain2(nil)
		ain2Ref01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "ain2"}, setup.data), "ain2_ref01"))

		ain2Ref01DataResult, err := ain2Ref01Ent.Create(ain2Ref01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		ain2Ref01Data = core.ToMapAny(ain2Ref01DataResult)
		if ain2Ref01Data == nil {
			t.Fatal("expected create result to be a map")
		}

	})
}

func ain2BasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "ain2", "Ain2TestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read ain2 test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse ain2 test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"ain201", "ain202", "ain203"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("SODEOMAIPROXY_TEST_AIN__ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"SODEOMAIPROXY_TEST_AIN__ENTID": idmap,
		"SODEOMAIPROXY_TEST_LIVE":      "FALSE",
		"SODEOMAIPROXY_TEST_EXPLAIN":   "FALSE",
		"SODEOMAIPROXY_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["SODEOMAIPROXY_TEST_AIN__ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["SODEOMAIPROXY_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["SODEOMAIPROXY_APIKEY"],
			},
			extra,
		})
		client = sdk.NewSodeomAiProxySDK(core.ToMapAny(mergedOpts))
	}

	live := env["SODEOMAIPROXY_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["SODEOMAIPROXY_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
