// Typed models for the SodeomAiProxy SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Ain {
  answer: string
}

export interface AinLoadMatch {
  answer?: string
}

export interface Ain2 {
  answer: string
  max_token?: number
  message: any[]
  model?: string
  temperature?: number
}

export interface Ain2CreateData {
  answer: string
  max_token?: number
  message: any[]
  model?: string
  temperature?: number
}

