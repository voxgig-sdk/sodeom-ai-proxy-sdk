# SodeomAiProxy SDK feature factory

from feature.base_feature import SodeomAiProxyBaseFeature
from feature.test_feature import SodeomAiProxyTestFeature


def _make_feature(name):
    features = {
        "base": lambda: SodeomAiProxyBaseFeature(),
        "test": lambda: SodeomAiProxyTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
