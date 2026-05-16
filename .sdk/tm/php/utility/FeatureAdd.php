<?php
declare(strict_types=1);

// SodeomAiProxy SDK utility: feature_add

class SodeomAiProxyFeatureAdd
{
    public static function call(SodeomAiProxyContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
