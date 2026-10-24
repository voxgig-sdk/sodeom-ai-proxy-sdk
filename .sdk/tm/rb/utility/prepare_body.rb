# SodeomAiProxy SDK utility: prepare_body
require_relative 'media'
module SodeomAiProxyUtilities
  PrepareBody = ->(ctx) {
    return nil unless ctx.op.input == "data"
    return SodeomAiProxyUtilities.raw_body(ctx.reqdata) if SodeomAiProxyUtilities.raw_request?(ctx.point)
    ctx.utility.transform_request.call(ctx)
  }
end
