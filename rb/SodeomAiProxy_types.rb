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
Ain = Struct.new(
  :answer,
  keyword_init: true
)

# Match filter for Ain#load (any subset of Ain fields).
#
# @!attribute [rw] answer
#   @return [String, nil]
AinLoadMatch = Struct.new(
  :answer,
  keyword_init: true
)

# Ain2 entity data model.
#
# @!attribute [rw] answer
#   @return [String]
#
# @!attribute [rw] max_token
#   @return [Integer, nil]
#
# @!attribute [rw] message
#   @return [Array]
#
# @!attribute [rw] model
#   @return [String, nil]
#
# @!attribute [rw] temperature
#   @return [Float, nil]
Ain2 = Struct.new(
  :answer,
  :max_token,
  :message,
  :model,
  :temperature,
  keyword_init: true
)

# Match filter for Ain2#create (any subset of Ain2 fields).
#
# @!attribute [rw] answer
#   @return [String, nil]
#
# @!attribute [rw] max_token
#   @return [Integer, nil]
#
# @!attribute [rw] message
#   @return [Array, nil]
#
# @!attribute [rw] model
#   @return [String, nil]
#
# @!attribute [rw] temperature
#   @return [Float, nil]
Ain2CreateData = Struct.new(
  :answer,
  :max_token,
  :message,
  :model,
  :temperature,
  keyword_init: true
)

