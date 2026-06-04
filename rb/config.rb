# SodeomAiProxy SDK configuration

module SodeomAiProxyConfig
  def self.make_config
    {
      "main" => {
        "name" => "SodeomAiProxy",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
        },
      },
      "options" => {
        "base" => "https://sodeom.com",
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "ain" => {},
          "ain2" => {},
        },
      },
      "entity" => {
        "ain" => {
          "fields" => [
            {
              "name" => "answer",
              "req" => true,
              "type" => "`$STRING`",
              "active" => true,
              "index$" => 0,
            },
          ],
          "name" => "ain",
          "op" => {
            "load" => {
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
                        "active" => true,
                      },
                    ],
                  },
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
                  "active" => true,
                  "index$" => 0,
                },
              ],
              "input" => "data",
              "key$" => "load",
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "ain2" => {
          "fields" => [
            {
              "name" => "answer",
              "req" => true,
              "type" => "`$STRING`",
              "active" => true,
              "index$" => 0,
            },
            {
              "name" => "max_token",
              "req" => false,
              "type" => "`$INTEGER`",
              "active" => true,
              "index$" => 1,
            },
            {
              "name" => "message",
              "req" => true,
              "type" => "`$ARRAY`",
              "active" => true,
              "index$" => 2,
            },
            {
              "name" => "model",
              "req" => false,
              "type" => "`$STRING`",
              "active" => true,
              "index$" => 3,
            },
            {
              "name" => "temperature",
              "req" => false,
              "type" => "`$NUMBER`",
              "active" => true,
              "index$" => 4,
            },
          ],
          "name" => "ain2",
          "op" => {
            "create" => {
              "name" => "create",
              "points" => [
                {
                  "method" => "POST",
                  "orig" => "/ai",
                  "parts" => [
                    "ai",
                  ],
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "active" => true,
                  "args" => {},
                  "select" => {},
                  "index$" => 0,
                },
              ],
              "input" => "data",
              "key$" => "create",
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
