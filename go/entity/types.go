// Typed models for the SodeomAiProxy SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Ain is the typed data model for the ain entity.
type Ain struct {
	Answer string `json:"answer"`
}

// AinLoadMatch mirrors the ain fields as an all-optional match
// filter (Go analog of Partial<Ain>).
type AinLoadMatch struct {
	Answer *string `json:"answer,omitempty"`
}

// Ain2 is the typed data model for the ain2 entity.
type Ain2 struct {
	Answer string `json:"answer"`
	MaxToken *int `json:"max_token,omitempty"`
	Message []any `json:"message"`
	Model *string `json:"model,omitempty"`
	Temperature *float64 `json:"temperature,omitempty"`
}

// Ain2CreateData mirrors the ain2 fields as an all-optional match
// filter (Go analog of Partial<Ain2>).
type Ain2CreateData struct {
	Answer *string `json:"answer,omitempty"`
	MaxToken *int `json:"max_token,omitempty"`
	Message *[]any `json:"message,omitempty"`
	Model *string `json:"model,omitempty"`
	Temperature *float64 `json:"temperature,omitempty"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
