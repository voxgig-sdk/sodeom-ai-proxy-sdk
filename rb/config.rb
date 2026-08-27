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
        "test" => {
          "options" => {
            "active" => false,
          },
          "transport" => "base",
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
              "req" => true,
              "short" => "Generated text response from the AI model",
              "type" => "`$STRING`",
            },
            {
              "name" => "max_tokens",
              "short" => "Maximum tokens for the response",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "messages",
              "req" => true,
              "short" => "Chat history array passed to the model",
              "type" => "`$ARRAY`",
            },
            {
              "name" => "model",
              "short" => "Overrides the default model (gpt-4o-mini)",
              "type" => "`$STRING`",
            },
            {
              "name" => "temperature",
              "short" => "Sampling temperature passed through to the model (0.0 to 2.0)",
              "type" => "`$NUMBER`",
            },
          ],
          "name" => "ain",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/ai",
                  "parts" => [
                    "ai",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "example" => "Say hi",
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/ai",
                  "parts" => [
                    "ai",
                  ],
                  "select" => {
                    "exist" => [
                      "query",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
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
