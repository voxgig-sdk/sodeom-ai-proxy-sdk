# SodeomAiProxy SDK configuration


def make_config():
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
                "ain2": {},
            },
        },
        "entity": {
      "ain": {
        "fields": [
          {
            "name": "answer",
            "req": True,
            "type": "`$STRING`",
            "active": True,
            "index$": 0,
          },
        ],
        "name": "ain",
        "op": {
          "load": {
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
                      "active": True,
                    },
                  ],
                },
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
                "active": True,
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "load",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "ain2": {
        "fields": [
          {
            "name": "answer",
            "req": True,
            "type": "`$STRING`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "max_token",
            "req": False,
            "type": "`$INTEGER`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "message",
            "req": True,
            "type": "`$ARRAY`",
            "active": True,
            "index$": 2,
          },
          {
            "name": "model",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 3,
          },
          {
            "name": "temperature",
            "req": False,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 4,
          },
        ],
        "name": "ain2",
        "op": {
          "create": {
            "name": "create",
            "points": [
              {
                "method": "POST",
                "orig": "/ai",
                "parts": [
                  "ai",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
