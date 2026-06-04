# Ain2 entity test

require "minitest/autorun"
require "json"
require_relative "../SodeomAiProxy_sdk"
require_relative "runner"

class Ain2EntityTest < Minitest::Test
  def test_create_instance
    testsdk = SodeomAiProxySDK.test(nil, nil)
    ent = testsdk.Ain2(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = ain2_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "ain2." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set SODEOMAIPROXY_TEST_AIN__ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    ain2_ref01_ent = client.Ain2(nil)
    ain2_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.ain2"), "ain2_ref01"))

    ain2_ref01_data_result, err = ain2_ref01_ent.create(ain2_ref01_data, nil)
    assert_nil err
    ain2_ref01_data = Helpers.to_map(ain2_ref01_data_result)
    assert !ain2_ref01_data.nil?

  end
end

def ain2_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "ain2", "Ain2TestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = SodeomAiProxySDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["ain201", "ain202", "ain203"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["SODEOMAIPROXY_TEST_AIN__ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "SODEOMAIPROXY_TEST_AIN__ENTID" => idmap,
    "SODEOMAIPROXY_TEST_LIVE" => "FALSE",
    "SODEOMAIPROXY_TEST_EXPLAIN" => "FALSE",
  })

  idmap_resolved = Helpers.to_map(
    env["SODEOMAIPROXY_TEST_AIN__ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["SODEOMAIPROXY_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
      },
      extra || {},
    ])
    client = SodeomAiProxySDK.new(Helpers.to_map(merged_opts))
  end

  live = env["SODEOMAIPROXY_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["SODEOMAIPROXY_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
