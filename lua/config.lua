-- SodeomAiProxy SDK configuration

-- Build a fresh, fully materialised config table. Every call rebuilds the
-- whole structure, so prefer require("config_shared") unless you need a
-- private copy you intend to mutate.
local function make_config()
  return {
    main = {
      name = "SodeomAiProxy",
      slug = "sodeom-ai-proxy",
      version = "0.0.1",
      target = "lua",
    },
    feature = {
      ["ratelimit"] = {
        ["options"] = {
          ["active"] = false,
          ["burst"] = 5,
          ["rate"] = 5,
        },
        ["optspec"] = {
          ["now"] = "`$FUNCTION`",
          ["sleep"] = "`$FUNCTION`",
        },
        ["strict"] = false,
        ["transport"] = "wrap",
      },
      ["retry"] = {
        ["options"] = {
          ["active"] = false,
          ["factor"] = 2,
          ["maxDelay"] = 2000,
          ["minDelay"] = 50,
          ["retries"] = 2,
          ["statuses"] = {
            408,
            425,
            429,
            500,
            502,
            503,
            504,
          },
        },
        ["optspec"] = {
          ["jitter"] = "`$BOOLEAN`",
          ["sleep"] = "`$FUNCTION`",
        },
        ["strict"] = false,
        ["transport"] = "wrap",
      },
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
        ["optspec"] = {
          ["entity"] = "`$MAP`",
          ["net"] = "`$MAP`",
        },
        ["strict"] = false,
        ["transport"] = "base",
      },
      ["timeout"] = {
        ["options"] = {
          ["active"] = false,
          ["ms"] = 30000,
        },
        ["optspec"] = {
          ["clearTimer"] = "`$FUNCTION`",
          ["setTimer"] = "`$FUNCTION`",
        },
        ["strict"] = false,
        ["transport"] = "wrap",
      },
    },
    options = {
      base = "https://sodeom.com",
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["ain"] = {},
      },
    },
    entity = {
      ["ain"] = {
        ["fields"] = {
          {
            ["name"] = "answer",
            ["title"] = "Answer",
            ["type"] = "`$STRING`",
            ["req"] = true,
            ["short"] = "Generated text response from the AI model",
          },
          {
            ["name"] = "max_tokens",
            ["title"] = "Max Tokens",
            ["type"] = "`$INTEGER`",
            ["short"] = "Maximum tokens for the response",
          },
          {
            ["name"] = "messages",
            ["title"] = "Messages",
            ["type"] = "`$ARRAY`",
            ["req"] = true,
            ["short"] = "Chat history array passed to the model",
          },
          {
            ["name"] = "model",
            ["title"] = "Model",
            ["type"] = "`$STRING`",
            ["short"] = "Overrides the default model (gpt-4o-mini)",
          },
          {
            ["name"] = "temperature",
            ["title"] = "Temperature",
            ["type"] = "`$NUMBER`",
            ["short"] = "Sampling temperature passed through to the model (0.0 to 2.0)",
          },
        },
        ["name"] = "ain",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/ai",
                ["segments"] = {
                  {
                    ["lit"] = "ai",
                  },
                },
                ["parts"] = {
                  "ai",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {},
                ["select"] = {},
              },
            },
          },
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/ai",
                ["segments"] = {
                  {
                    ["lit"] = "ai",
                  },
                },
                ["parts"] = {
                  "ai",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "query",
                      ["orig"] = "query",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["reqd"] = true,
                      ["example"] = "Say hi",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "query",
                  },
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
