<?php
declare(strict_types=1);

// SodeomAiProxy SDK base feature

class SodeomAiProxyBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(SodeomAiProxyContext $ctx, array $options): void {}
    public function PostConstruct(SodeomAiProxyContext $ctx): void {}
    public function PostConstructEntity(SodeomAiProxyContext $ctx): void {}
    public function SetData(SodeomAiProxyContext $ctx): void {}
    public function GetData(SodeomAiProxyContext $ctx): void {}
    public function GetMatch(SodeomAiProxyContext $ctx): void {}
    public function SetMatch(SodeomAiProxyContext $ctx): void {}
    public function PrePoint(SodeomAiProxyContext $ctx): void {}
    public function PreSpec(SodeomAiProxyContext $ctx): void {}
    public function PreRequest(SodeomAiProxyContext $ctx): void {}
    public function PreResponse(SodeomAiProxyContext $ctx): void {}
    public function PreResult(SodeomAiProxyContext $ctx): void {}
    public function PreDone(SodeomAiProxyContext $ctx): void {}
    public function PreUnexpected(SodeomAiProxyContext $ctx): void {}
}
