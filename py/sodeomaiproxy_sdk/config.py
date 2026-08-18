# SodeomAiProxy SDK configuration


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
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
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
            "req": True,
            "type": "`$STRING`",
          },
          {
            "name": "max_tokens",
            "type": "`$INTEGER`",
          },
          {
            "name": "messages",
            "req": True,
            "type": "`$ARRAY`",
          },
          {
            "name": "model",
            "type": "`$STRING`",
          },
          {
            "name": "temperature",
            "type": "`$NUMBER`",
          },
        ],
        "name": "ain",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/ai",
                "parts": [
                  "ai",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
              },
            ],
          },
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "args": {
                  "query": [
                    {
                      "example": "Say hi",
                      "kind": "query",
                      "name": "query",
                      "orig": "query",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/ai",
                "parts": [
                  "ai",
                ],
                "select": {
                  "exist": [
                    "query",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
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
