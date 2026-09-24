# SodeomAiProxy SDK configuration

module SodeomAiProxyConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "SodeomAiProxy",
        "slug" => "sodeom-ai-proxy",
        "version" => "0.0.1",
        "target" => "rb",
      },
      "feature" => {
        "ratelimit" => {
          "options" => {
            "active" => false,
            "burst" => 5,
            "rate" => 5,
          },
          "optspec" => {
            "now" => "`$FUNCTION`",
            "sleep" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
        "retry" => {
          "options" => {
            "active" => false,
            "factor" => 2,
            "maxDelay" => 2000,
            "minDelay" => 50,
            "retries" => 2,
            "statuses" => [
              408,
              425,
              429,
              500,
              502,
              503,
              504,
            ],
          },
          "optspec" => {
            "jitter" => "`$BOOLEAN`",
            "sleep" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
        "test" => {
          "options" => {
            "active" => false,
          },
          "optspec" => {
            "entity" => "`$MAP`",
            "net" => "`$MAP`",
          },
          "strict" => false,
          "transport" => "base",
        },
        "timeout" => {
          "options" => {
            "active" => false,
            "ms" => 30000,
          },
          "optspec" => {
            "clearTimer" => "`$FUNCTION`",
            "setTimer" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
      },
      "options" => {
        "base" => "https://sodeom.com",
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "ain" => {},
        },
      },
      "entity" => {
        "ain" => {
          "fields" => [
            {
              "name" => "answer",
              "title" => "Answer",
              "type" => "`$STRING`",
              "req" => true,
              "short" => "Generated text response from the AI model",
            },
            {
              "name" => "max_tokens",
              "title" => "Max Tokens",
              "type" => "`$INTEGER`",
              "short" => "Maximum tokens for the response",
            },
            {
              "name" => "messages",
              "title" => "Messages",
              "type" => "`$ARRAY`",
              "req" => true,
              "short" => "Chat history array passed to the model",
            },
            {
              "name" => "model",
              "title" => "Model",
              "type" => "`$STRING`",
              "short" => "Overrides the default model (gpt-4o-mini)",
            },
            {
              "name" => "temperature",
              "title" => "Temperature",
              "type" => "`$NUMBER`",
              "short" => "Sampling temperature passed through to the model (0.0 to 2.0)",
            },
          ],
          "name" => "ain",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/ai",
                  "segments" => [
                    {
                      "lit" => "ai",
                    },
                  ],
                  "parts" => [
                    "ai",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/ai",
                  "segments" => [
                    {
                      "lit" => "ai",
                    },
                  ],
                  "parts" => [
                    "ai",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {
                    "query" => [
                      {
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                        "kind" => "query",
                        "reqd" => true,
                        "example" => "Say hi",
                      },
                    ],
                  },
                  "select" => {
                    "exist" => [
                      "query",
                    ],
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    SodeomAiProxyFeatures.make_feature(name)
  end
end
