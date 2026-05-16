<?php
declare(strict_types=1);

// SodeomAiProxy SDK utility: prepare_body

class SodeomAiProxyPrepareBody
{
    public static function call(SodeomAiProxyContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
