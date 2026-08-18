
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


  main = {
    name: 'SodeomAiProxy',
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
          "type": "`$STRING`"
        },
        {
          "name": "max_tokens",
          "type": "`$INTEGER`"
        },
        {
          "name": "messages",
          "req": true,
          "type": "`$ARRAY`"
        },
        {
          "name": "model",
          "type": "`$STRING`"
        },
        {
          "name": "temperature",
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

