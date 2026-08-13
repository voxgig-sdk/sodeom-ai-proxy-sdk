// Typed models for the SodeomAiProxy SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Ain {
  answer: string
  max_tokens?: number
  messages: any[]
  model?: string
  temperature?: number
}

export interface AinLoadMatch {
  answer?: string
  max_tokens?: number
  messages?: any[]
  model?: string
  temperature?: number
}

export interface AinCreateData {
  answer: string
  max_tokens?: number
  messages: any[]
  model?: string
  temperature?: number
}

