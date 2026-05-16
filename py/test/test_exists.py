# ProjectName SDK exists test

import pytest
from sodeomaiproxy_sdk import SodeomAiProxySDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = SodeomAiProxySDK.test(None, None)
        assert testsdk is not None
