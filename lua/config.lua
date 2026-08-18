-- SodeomAiProxy SDK configuration

-- Build a fresh, fully materialised config table. Every call rebuilds the
-- whole structure, so prefer require("config_shared") unless you need a
-- private copy you intend to mutate.
local function make_config()
  return {
    main = {
      name = "SodeomAiProxy",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
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
            ["req"] = true,
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "max_tokens",
            ["type"] = "`$INTEGER`",
          },
          {
            ["name"] = "messages",
            ["req"] = true,
            ["type"] = "`$ARRAY`",
          },
          {
            ["name"] = "model",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "temperature",
            ["type"] = "`$NUMBER`",
          },
        },
        ["name"] = "ain",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/ai",
                ["parts"] = {
                  "ai",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["args"] = {
                  ["query"] = {
                    {
                      ["example"] = "Say hi",
                      ["kind"] = "query",
                      ["name"] = "query",
                      ["orig"] = "query",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/ai",
                ["parts"] = {
                  "ai",
                },
                ["select"] = {
                  ["exist"] = {
                    "query",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
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
