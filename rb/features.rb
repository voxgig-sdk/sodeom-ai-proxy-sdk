# SodeomAiProxy SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module SodeomAiProxyFeatures
  def self.make_feature(name)
    case name
    when "base"
      SodeomAiProxyBaseFeature.new
    when "ratelimit"
      SodeomAiProxyRatelimitFeature.new
    when "retry"
      SodeomAiProxyRetryFeature.new
    when "test"
      SodeomAiProxyTestFeature.new
    when "timeout"
      SodeomAiProxyTimeoutFeature.new
    else
      SodeomAiProxyBaseFeature.new
    end
  end
end
