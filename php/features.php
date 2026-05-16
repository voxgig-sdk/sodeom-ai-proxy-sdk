<?php
declare(strict_types=1);

// SodeomAiProxy SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class SodeomAiProxyFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new SodeomAiProxyBaseFeature();
            case "test":
                return new SodeomAiProxyTestFeature();
            default:
                return new SodeomAiProxyBaseFeature();
        }
    }
}
