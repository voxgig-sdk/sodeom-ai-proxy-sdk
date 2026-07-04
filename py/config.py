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
            "active": True,
            "name": "answer",
            "req": True,
            "type": "`$STRING`",
            "index$": 0,
          },
        ],
        "name": "ain",
        "op": {
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "example": "Say hi",
                      "kind": "query",
                      "name": "query",
                      "orig": "query",
                      "reqd": True,
                      "type": "`$STRING`",
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
                "index$": 0,
              },
            ],
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
            "active": True,
            "name": "answer",
            "req": True,
            "type": "`$STRING`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "max_token",
            "req": False,
            "type": "`$INTEGER`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "message",
            "req": True,
            "type": "`$ARRAY`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "model",
            "req": False,
            "type": "`$STRING`",
            "index$": 3,
          },
          {
            "active": True,
            "name": "temperature",
            "req": False,
            "type": "`$NUMBER`",
            "index$": 4,
          },
        ],
        "name": "ain2",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
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
                "index$": 0,
              },
            ],
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
