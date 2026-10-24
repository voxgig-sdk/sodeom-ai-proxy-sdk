"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const node_test_1 = require("node:test");
const __1 = require("..");
const definition_runner_1 = require("./definition-runner");
const utility_1 = require("./utility");
// Generated from the API definition, not from the model this SDK was built
// from: the route, the declared query parameters, the credential the security
// scheme names, and the definition's own response example.
const PLAN = [
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
];
(0, node_test_1.describe)('definition', () => {
    for (const point of PLAN) {
        (0, node_test_1.test)(point.entity + '.' + point.op + ' ' + point.method + ' ' + point.path, async (t) => {
            const control = (0, utility_1.isControlSkipped)('entityOp', point.entity + '.' + point.op, 'definition');
            if (control.skip) {
                t.skip(control.reason || 'skipped via sdk-test-control.json');
                return;
            }
            await (0, definition_runner_1.runDefinitionPoint)(__1.SDK, point);
        });
    }
});
//# sourceMappingURL=definition.test.js.map