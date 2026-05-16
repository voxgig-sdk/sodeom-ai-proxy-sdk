<?php
declare(strict_types=1);

// SodeomAiProxy SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class SodeomAiProxyMakeContext
{
    public static function call(array $ctxmap, ?SodeomAiProxyContext $basectx): SodeomAiProxyContext
    {
        return new SodeomAiProxyContext($ctxmap, $basectx);
    }
}
