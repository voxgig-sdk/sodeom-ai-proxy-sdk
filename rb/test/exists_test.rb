# SodeomAiProxy SDK exists test

require "minitest/autorun"
require_relative "../SodeomAiProxy_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = SodeomAiProxySDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
