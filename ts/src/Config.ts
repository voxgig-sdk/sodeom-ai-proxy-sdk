
import { BaseFeature } from './feature/base/BaseFeature'
import { TestFeature } from './feature/test/TestFeature'



const FEATURE_CLASS: Record<string, typeof BaseFeature> = {
   test: TestFeature,

}


class Config {

  makeFeature(this: any, fn: string) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
    // TODO: errors etc
    return fi
  }

  // False for a feature added at runtime via options.extend (station's
  // adopt path) - the constructor uses this to skip makeFeature for names
  // no generated class backs.
  hasFeature(this: any, fn: string) {
    return null != FEATURE_CLASS[fn]
  }


  main = {
    name: 'SodeomAiProxy',
        slug: "sodeom-ai-proxy",
    version: "0.0.1",
    target: "ts",

  }


  feature = {
     test:     {
      "options": {
        "active": false
      }
    },

  }


  options = {
    base: "https://sodeom.com",

    headers: {
      "content-type": "application/json"
    },

    entity: {
      
      ain: {
      },

    }
  }


  entity = {
    "ain": {
      "fields": [
        {
          "name": "answer",
          "req": true,
          "short": "Generated text response from the AI model",
          "type": "`$STRING`"
        },
        {
          "name": "max_tokens",
          "short": "Maximum tokens for the response",
          "type": "`$INTEGER`"
        },
        {
          "name": "messages",
          "req": true,
          "short": "Chat history array passed to the model",
          "type": "`$ARRAY`"
        },
        {
          "name": "model",
          "short": "Overrides the default model (gpt-4o-mini)",
          "type": "`$STRING`"
        },
        {
          "name": "temperature",
          "short": "Sampling temperature passed through to the model (0.0 to 2.0)",
          "type": "`$NUMBER`"
        }
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
                "ai"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
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
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/ai",
              "parts": [
                "ai"
              ],
              "select": {
                "exist": [
                  "query"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}


const config = new Config()

export {
  config
}

