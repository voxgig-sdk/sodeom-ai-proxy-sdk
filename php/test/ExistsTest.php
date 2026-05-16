<?php
declare(strict_types=1);

// SodeomAiProxy SDK exists test

require_once __DIR__ . '/../sodeomaiproxy_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = SodeomAiProxySDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
