-- Typed models for the SodeomAiProxy SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Ain
---@field answer string

---@class AinLoadMatch
---@field answer? string

---@class Ain2
---@field answer string
---@field max_token? number
---@field message table
---@field model? string
---@field temperature? number

---@class Ain2CreateData
---@field answer string
---@field max_token? number
---@field message table
---@field model? string
---@field temperature? number

local M = {}

return M
