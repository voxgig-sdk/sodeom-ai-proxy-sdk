<?php
declare(strict_types=1);

// Typed models for the SodeomAiProxy SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Ain entity data model. */
class Ain
{
    public string $answer;
}

/** Match filter for Ain#load (any subset of Ain fields). */
class AinLoadMatch
{
    public ?string $answer = null;
}

/** Ain2 entity data model. */
class Ain2
{
    public string $answer;
    public ?int $max_token = null;
    public array $message;
    public ?string $model = null;
    public ?float $temperature = null;
}

/** Match filter for Ain2#create (any subset of Ain2 fields). */
class Ain2CreateData
{
    public ?string $answer = null;
    public ?int $max_token = null;
    public ?array $message = null;
    public ?string $model = null;
    public ?float $temperature = null;
}

