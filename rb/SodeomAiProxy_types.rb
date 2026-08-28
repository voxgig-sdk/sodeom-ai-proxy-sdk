# frozen_string_literal: true

# Typed models for the SodeomAiProxy SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Ain entity data model.
#
# @!attribute [rw] answer
#   @return [String]
#
# @!attribute [rw] max_tokens
#   @return [Integer, nil]
#
# @!attribute [rw] messages
#   @return [Array]
#
# @!attribute [rw] model
#   @return [String, nil]
#
# @!attribute [rw] temperature
#   @return [Float, nil]
Ain = Struct.new(
  :answer,
  :max_tokens,
  :messages,
  :model,
  :temperature,
  keyword_init: true
)

# Request payload for Ain#load.
#
# @!attribute [rw] query
#   @return [String]
AinLoadMatch = Struct.new(
  :query,
  keyword_init: true
)

# Request payload for Ain#create.
#
# @!attribute [rw] answer
#   @return [String]
#
# @!attribute [rw] max_tokens
#   @return [Integer, nil]
#
# @!attribute [rw] messages
#   @return [Array]
#
# @!attribute [rw] model
#   @return [String, nil]
#
# @!attribute [rw] temperature
#   @return [Float, nil]
AinCreateData = Struct.new(
  :answer,
  :max_tokens,
  :messages,
  :model,
  :temperature,
  keyword_init: true
)

