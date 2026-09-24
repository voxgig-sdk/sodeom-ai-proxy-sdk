
import { BaseFeature } from './feature/base/BaseFeature'
import { RatelimitFeature } from './feature/ratelimit/RatelimitFeature'
import { RetryFeature } from './feature/retry/RetryFeature'
import { TestFeature } from './feature/test/TestFeature'
import { TimeoutFeature } from './feature/timeout/TimeoutFeature'



const FEATURE_CLASS: Record<string, typeof BaseFeature> = {
   ratelimit: RatelimitFeature,
 retry: RetryFeature,
 test: TestFeature,
 timeout: TimeoutFeature,

}


const FEATURE_PLUGINS: Record<string, any[]> = {
  
}


class Config {

  makeFeature(this: any, fn: string) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
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
     ratelimit:     {
      "options": {
        "active": false,
        "burst": 5,
        "rate": 5
      },
      "optspec": {
        "now": "`$FUNCTION`",
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
 retry:     {
      "options": {
        "active": false,
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
          504
        ]
      },
      "optspec": {
        "jitter": "`$BOOLEAN`",
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
 test:     {
      "options": {
        "active": false
      },
      "optspec": {
        "entity": "`$MAP`",
        "net": "`$MAP`"
      },
      "strict": false,
      "transport": "base"
    },
 timeout:     {
      "options": {
        "active": false,
        "ms": 30000
      },
      "optspec": {
        "clearTimer": "`$FUNCTION`",
        "setTimer": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
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
          "title": "Answer",
          "type": "`$STRING`",
          "req": true,
          "short": "Generated text response from the AI model"
        },
        {
          "name": "max_tokens",
          "title": "Max Tokens",
          "type": "`$INTEGER`",
          "short": "Maximum tokens for the response"
        },
        {
          "name": "messages",
          "title": "Messages",
          "type": "`$ARRAY`",
          "req": true,
          "short": "Chat history array passed to the model"
        },
        {
          "name": "model",
          "title": "Model",
          "type": "`$STRING`",
          "short": "Overrides the default model (gpt-4o-mini)"
        },
        {
          "name": "temperature",
          "title": "Temperature",
          "type": "`$NUMBER`",
          "short": "Sampling temperature passed through to the model (0.0 to 2.0)"
        }
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
                  "lit": "ai"
                }
              ],
              "parts": [
                "ai"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
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
                  "lit": "ai"
                }
              ],
              "parts": [
                "ai"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "query": [
                  {
                    "name": "query",
                    "orig": "query",
                    "type": "`$STRING`",
                    "kind": "query",
                    "reqd": true,
                    "example": "Say hi"
                  }
                ]
              },
              "select": {
                "exist": [
                  "query"
                ]
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
  config,
  FEATURE_PLUGINS,
}

