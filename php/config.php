<?php
declare(strict_types=1);

// SodeomAiProxy SDK configuration

class SodeomAiProxyConfig
{
    /** @var array<string,mixed>|null */
    private static ?array $shared_config = null;

    /**
     * Return the process-wide config, built once on first use. The SDK reads
     * the config on every request and never writes to it, so one instance is
     * shared by every client rather than rebuilt per client.
     *
     * PHP arrays are copy-on-write, so callers that do mutate the result get
     * their own copy and cannot disturb the shared one.
     */
    public static function shared_config(): array
    {
        if (self::$shared_config === null) {
            self::$shared_config = self::make_config();
        }
        return self::$shared_config;
    }

    /**
     * Build a fresh, fully materialised config array. Every call rebuilds the
     * whole structure, so prefer shared_config unless you need a private copy.
     */
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "SodeomAiProxy",
                "slug" => "sodeom-ai-proxy",
                "version" => "0.0.1",
                "target" => "php",
            ],
            "feature" => [
                "test" => [
          'options' => [
            'active' => false,
          ],
        ],
            ],
            "options" => [
                "base" => "https://sodeom.com",
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "ain" => [],
                ],
            ],
            "entity" => [
        'ain' => [
          'fields' => [
            [
              'name' => 'answer',
              'req' => true,
              'short' => 'Generated text response from the AI model',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'max_tokens',
              'short' => 'Maximum tokens for the response',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'messages',
              'req' => true,
              'short' => 'Chat history array passed to the model',
              'type' => '`$ARRAY`',
            ],
            [
              'name' => 'model',
              'short' => 'Overrides the default model (gpt-4o-mini)',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'temperature',
              'short' => 'Sampling temperature passed through to the model (0.0 to 2.0)',
              'type' => '`$NUMBER`',
            ],
          ],
          'name' => 'ain',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/ai',
                  'parts' => [
                    'ai',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 'Say hi',
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/ai',
                  'parts' => [
                    'ai',
                  ],
                  'select' => [
                    'exist' => [
                      'query',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return SodeomAiProxyFeatures::make_feature($name);
    }
}
