# SodeomAiProxy SDK utility: feature_add
module SodeomAiProxyUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
