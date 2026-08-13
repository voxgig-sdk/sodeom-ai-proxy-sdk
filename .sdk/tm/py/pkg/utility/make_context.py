# SodeomAiProxy SDK utility: make_context

from projectname_sdk.core.context import SodeomAiProxyContext


def make_context_util(ctxmap, basectx):
    return SodeomAiProxyContext(ctxmap, basectx)
