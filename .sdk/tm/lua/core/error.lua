-- SodeomAiProxy SDK error

local SodeomAiProxyError = {}
SodeomAiProxyError.__index = SodeomAiProxyError


function SodeomAiProxyError.new(code, msg, ctx)
  local self = setmetatable({}, SodeomAiProxyError)
  self.is_sdk_error = true
  self.sdk = "SodeomAiProxy"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function SodeomAiProxyError:error()
  return self.msg
end


function SodeomAiProxyError:__tostring()
  return self.msg
end


return SodeomAiProxyError
