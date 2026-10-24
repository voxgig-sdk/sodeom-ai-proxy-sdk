import { describe, test } from 'node:test'
import { SDK } from '..'
import { runDefinitionPoint } from './definition-runner'
import { isControlSkipped } from './utility'


// Generated from the API definition, not from the model this SDK was built
// from: the route, the declared query parameters, the credential the security
// scheme names, and the definition's own response example.
const PLAN: any[] = [
  {
    "entity": "ain",
    "accessor": "Ain",
    "op": "create",
    "method": "POST",
    "path": "/ai",
    "args": [],
    "select": {},
    "headers": [],
    "cookies": [],
    "responseMedia": [
      "application/json"
    ],
    "query": [],
    "queryArgs": [],
    "auth": null,
    "status": 200,
    "sample": {
      "answer": "Hello! How can I assist you today?"
    },
    "idField": "id"
  },
  {
    "entity": "ain",
    "accessor": "Ain",
    "op": "load",
    "method": "GET",
    "path": "/ai",
    "args": [],
    "select": {
      "query": "Say hi"
    },
    "headers": [],
    "cookies": [],
    "responseMedia": [
      "application/json"
    ],
    "query": [
      "query"
    ],
    "queryArgs": [
      {
        "name": "query",
        "wire": "query"
      }
    ],
    "auth": null,
    "status": 200,
    "sample": {
      "answer": "Hello! How can I assist you today?"
    },
    "idField": "id"
  }
]


describe('definition', () => {
  for (const point of PLAN) {
    test(point.entity + '.' + point.op + ' ' + point.method + ' ' + point.path, async (t) => {
      const control = isControlSkipped('entityOp', point.entity + '.' + point.op, 'definition')
      if (control.skip) {
        t.skip(control.reason || 'skipped via sdk-test-control.json')
        return
      }
      await runDefinitionPoint(SDK, point)
    })
  }
})
