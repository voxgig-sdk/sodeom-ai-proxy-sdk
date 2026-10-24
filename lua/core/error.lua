-- SodeomAiProxy SDK error

local json = require("dkjson")

local SodeomAiProxyError = {}
SodeomAiProxyError.__index = SodeomAiProxyError

-- Reachable for a debugger, absent from the table itself: the context holds
-- the live spec and options, and an error is what gets dumped or encoded.
local CONTEXT = setmetatable({}, { __mode = "k" })


function SodeomAiProxyError.new(code, msg, ctx)
  local self = setmetatable({}, SodeomAiProxyError)
  self.is_sdk_error = true
  self.sdk = "SodeomAiProxy"
  self.code = code or ""
  self.msg = msg or ""
  self.result = nil
  self.spec = nil
  self.status = -1
  CONTEXT[self] = ctx
  return self
end


function SodeomAiProxyError:context()
  return CONTEXT[self]
end


function SodeomAiProxyError:error()
  return self.msg
end


function SodeomAiProxyError:not_found()
  return 404 == self.status
end


-- What make_error attached is already cleaned; the context is not part of
-- the record.
function SodeomAiProxyError:to_table()
  return {
    sdk = self.sdk,
    code = self.code,
    msg = self.msg,
    status = self.status,
    result = self.result,
    spec = self.spec,
  }
end


function SodeomAiProxyError:to_json()
  return json.encode(self:to_table())
end


function SodeomAiProxyError:__tostring()
  return self.msg
end


function SodeomAiProxyError.__tojson(self)
  return self:to_json()
end


return SodeomAiProxyError
