<?php
declare(strict_types=1);

// SodeomAiProxy SDK utility: result_body

class SodeomAiProxyResultBody
{
    public static function call(SodeomAiProxyContext $ctx): ?SodeomAiProxyResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
