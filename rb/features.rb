# SodeomAiProxy SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module SodeomAiProxyFeatures
  def self.make_feature(name)
    case name
    when "base"
      SodeomAiProxyBaseFeature.new
    when "test"
      SodeomAiProxyTestFeature.new
    else
      SodeomAiProxyBaseFeature.new
    end
  end
end
