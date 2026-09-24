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
                "ratelimit" => [
          'options' => [
            'active' => false,
            'burst' => 5,
            'rate' => 5,
          ],
          'optspec' => [
            'now' => '`$FUNCTION`',
            'sleep' => '`$FUNCTION`',
          ],
          'strict' => false,
          'transport' => 'wrap',
        ],
                "retry" => [
          'options' => [
            'active' => false,
            'factor' => 2,
            'maxDelay' => 2000,
            'minDelay' => 50,
            'retries' => 2,
            'statuses' => [
              408,
              425,
              429,
              500,
              502,
              503,
              504,
            ],
          ],
          'optspec' => [
            'jitter' => '`$BOOLEAN`',
            'sleep' => '`$FUNCTION`',
          ],
          'strict' => false,
          'transport' => 'wrap',
        ],
                "test" => [
          'options' => [
            'active' => false,
          ],
          'optspec' => [
            'entity' => '`$MAP`',
            'net' => '`$MAP`',
          ],
          'strict' => false,
          'transport' => 'base',
        ],
                "timeout" => [
          'options' => [
            'active' => false,
            'ms' => 30000,
          ],
          'optspec' => [
            'clearTimer' => '`$FUNCTION`',
            'setTimer' => '`$FUNCTION`',
          ],
          'strict' => false,
          'transport' => 'wrap',
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
              'title' => 'Answer',
              'type' => '`$STRING`',
              'req' => true,
              'short' => 'Generated text response from the AI model',
            ],
            [
              'name' => 'max_tokens',
              'title' => 'Max Tokens',
              'type' => '`$INTEGER`',
              'short' => 'Maximum tokens for the response',
            ],
            [
              'name' => 'messages',
              'title' => 'Messages',
              'type' => '`$ARRAY`',
              'req' => true,
              'short' => 'Chat history array passed to the model',
            ],
            [
              'name' => 'model',
              'title' => 'Model',
              'type' => '`$STRING`',
              'short' => 'Overrides the default model (gpt-4o-mini)',
            ],
            [
              'name' => 'temperature',
              'title' => 'Temperature',
              'type' => '`$NUMBER`',
              'short' => 'Sampling temperature passed through to the model (0.0 to 2.0)',
            ],
          ],
          'name' => 'ain',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/ai',
                  'segments' => [
                    [
                      'lit' => 'ai',
                    ],
                  ],
                  'parts' => [
                    'ai',
                  ],
                  'rename' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'args' => [],
                  'select' => [],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/ai',
                  'segments' => [
                    [
                      'lit' => 'ai',
                    ],
                  ],
                  'parts' => [
                    'ai',
                  ],
                  'rename' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'args' => [
                    'query' => [
                      [
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                        'kind' => 'query',
                        'reqd' => true,
                        'example' => 'Say hi',
                      ],
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'query',
                    ],
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
