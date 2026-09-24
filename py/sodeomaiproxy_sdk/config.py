# SodeomAiProxy SDK configuration


# The sekreto plugin DEFINITIONS the model selected per feature, imported
# above by name from the modules the catalogue's active `plugin.def`
# entries declare. Handed to each feature (secrets builds its Sekreto
# with them): a provider kind not listed here is unknown to that SDK.
FEATURE_PLUGINS = {
}


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "SodeomAiProxy",
            "slug": "sodeom-ai-proxy",
            "version": "0.0.1",
            "target": "py",
        },
        "feature": {
            "ratelimit": {
        "options": {
          "active": False,
          "burst": 5,
          "rate": 5,
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "retry": {
        "options": {
          "active": False,
          "factor": 2,
          "maxDelay": 2000,
          "minDelay": 50,
          "retries": 2,
          "statuses": [
            408,
            425,
            429,
            500,
            502,
            503,
            504,
          ],
        },
        "optspec": {
          "jitter": "`$BOOLEAN`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "test": {
        "options": {
          "active": False,
        },
        "optspec": {
          "entity": "`$MAP`",
          "net": "`$MAP`",
        },
        "strict": False,
        "transport": "base",
      },
            "timeout": {
        "options": {
          "active": False,
          "ms": 30000,
        },
        "optspec": {
          "clearTimer": "`$FUNCTION`",
          "setTimer": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
        },
        "options": {
            "base": "https://sodeom.com",
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "ain": {},
            },
        },
        "entity": {
      "ain": {
        "fields": [
          {
            "name": "answer",
            "title": "Answer",
            "type": "`$STRING`",
            "req": True,
            "short": "Generated text response from the AI model",
          },
          {
            "name": "max_tokens",
            "title": "Max Tokens",
            "type": "`$INTEGER`",
            "short": "Maximum tokens for the response",
          },
          {
            "name": "messages",
            "title": "Messages",
            "type": "`$ARRAY`",
            "req": True,
            "short": "Chat history array passed to the model",
          },
          {
            "name": "model",
            "title": "Model",
            "type": "`$STRING`",
            "short": "Overrides the default model (gpt-4o-mini)",
          },
          {
            "name": "temperature",
            "title": "Temperature",
            "type": "`$NUMBER`",
            "short": "Sampling temperature passed through to the model (0.0 to 2.0)",
          },
        ],
        "name": "ain",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "kind": "http",
                "method": "POST",
                "orig": "/ai",
                "segments": [
                  {
                    "lit": "ai",
                  },
                ],
                "parts": [
                  "ai",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
              },
            ],
          },
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "kind": "http",
                "method": "GET",
                "orig": "/ai",
                "segments": [
                  {
                    "lit": "ai",
                  },
                ],
                "parts": [
                  "ai",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "query": [
                    {
                      "name": "query",
                      "orig": "query",
                      "type": "`$STRING`",
                      "kind": "query",
                      "reqd": True,
                      "example": "Say hi",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "query",
                  ],
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
