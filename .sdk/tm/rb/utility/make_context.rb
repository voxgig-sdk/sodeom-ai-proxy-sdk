# SodeomAiProxy SDK utility: make_context
require_relative '../core/context'
module SodeomAiProxyUtilities
  MakeContext = ->(ctxmap, basectx) {
    SodeomAiProxyContext.new(ctxmap, basectx)
  }
end
