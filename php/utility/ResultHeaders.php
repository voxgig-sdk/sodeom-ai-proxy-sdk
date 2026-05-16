<?php
declare(strict_types=1);

// SodeomAiProxy SDK utility: result_headers

class SodeomAiProxyResultHeaders
{
    public static function call(SodeomAiProxyContext $ctx): ?SodeomAiProxyResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
