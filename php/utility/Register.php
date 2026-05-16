<?php
declare(strict_types=1);

// SodeomAiProxy SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

SodeomAiProxyUtility::setRegistrar(function (SodeomAiProxyUtility $u): void {
    $u->clean = [SodeomAiProxyClean::class, 'call'];
    $u->done = [SodeomAiProxyDone::class, 'call'];
    $u->make_error = [SodeomAiProxyMakeError::class, 'call'];
    $u->feature_add = [SodeomAiProxyFeatureAdd::class, 'call'];
    $u->feature_hook = [SodeomAiProxyFeatureHook::class, 'call'];
    $u->feature_init = [SodeomAiProxyFeatureInit::class, 'call'];
    $u->fetcher = [SodeomAiProxyFetcher::class, 'call'];
    $u->make_fetch_def = [SodeomAiProxyMakeFetchDef::class, 'call'];
    $u->make_context = [SodeomAiProxyMakeContext::class, 'call'];
    $u->make_options = [SodeomAiProxyMakeOptions::class, 'call'];
    $u->make_request = [SodeomAiProxyMakeRequest::class, 'call'];
    $u->make_response = [SodeomAiProxyMakeResponse::class, 'call'];
    $u->make_result = [SodeomAiProxyMakeResult::class, 'call'];
    $u->make_point = [SodeomAiProxyMakePoint::class, 'call'];
    $u->make_spec = [SodeomAiProxyMakeSpec::class, 'call'];
    $u->make_url = [SodeomAiProxyMakeUrl::class, 'call'];
    $u->param = [SodeomAiProxyParam::class, 'call'];
    $u->prepare_auth = [SodeomAiProxyPrepareAuth::class, 'call'];
    $u->prepare_body = [SodeomAiProxyPrepareBody::class, 'call'];
    $u->prepare_headers = [SodeomAiProxyPrepareHeaders::class, 'call'];
    $u->prepare_method = [SodeomAiProxyPrepareMethod::class, 'call'];
    $u->prepare_params = [SodeomAiProxyPrepareParams::class, 'call'];
    $u->prepare_path = [SodeomAiProxyPreparePath::class, 'call'];
    $u->prepare_query = [SodeomAiProxyPrepareQuery::class, 'call'];
    $u->result_basic = [SodeomAiProxyResultBasic::class, 'call'];
    $u->result_body = [SodeomAiProxyResultBody::class, 'call'];
    $u->result_headers = [SodeomAiProxyResultHeaders::class, 'call'];
    $u->transform_request = [SodeomAiProxyTransformRequest::class, 'call'];
    $u->transform_response = [SodeomAiProxyTransformResponse::class, 'call'];
});
