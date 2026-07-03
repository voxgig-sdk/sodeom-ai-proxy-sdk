# SodeomAiProxy SDK

Sodeom AI Proxy client, generated from the OpenAPI spec.

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## Try it

**TypeScript**
```bash
npm install sodeom-ai-proxy
```

**Python**
```bash
pip install sodeom-ai-proxy-sdk
```

**PHP**
```bash
composer require voxgig/sodeom-ai-proxy-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/sodeom-ai-proxy-sdk/go
```

**Ruby**
```bash
gem install sodeom-ai-proxy-sdk
```

**Lua**
```bash
luarocks install sodeom-ai-proxy-sdk
```

## Quickstart

### TypeScript

```ts
import { SodeomAiProxySDK } from 'sodeom-ai-proxy'

const client = new SodeomAiProxySDK({
  apikey: process.env.SODEOM-AI-PROXY_APIKEY,
})

// Load ain data
const ain = await client.Ain().load({})
console.log(ain.data)
```

See the [TypeScript README](ts/README.md) for the full guide.

## Surfaces

| Surface | Path |
| --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | `go-cli/` |
| **MCP server** | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o sodeom-ai-proxy-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "sodeom-ai-proxy": {
      "command": "/abs/path/to/sodeom-ai-proxy-mcp"
    }
  }
}
```

## Entities

The API exposes 2 entities:

| Entity | Description | API path |
| --- | --- | --- |
| **Ain** |  | `/ai` |
| **Ain2** |  | `/ai` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
import os
from sodeomaiproxy_sdk import SodeomAiProxySDK

client = SodeomAiProxySDK({
    "apikey": os.environ.get("SODEOM-AI-PROXY_APIKEY"),
})


# Load a specific ain
ain, err = client.Ain().load({"id": "example_id"})
print(ain)
```

### PHP

```php
<?php
require_once 'sodeomaiproxy_sdk.php';

$client = new SodeomAiProxySDK([
    "apikey" => getenv("SODEOM-AI-PROXY_APIKEY"),
]);


// Load a specific ain
[$ain, $err] = $client->Ain()->load(["id" => "example_id"]);
print_r($ain);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/sodeom-ai-proxy-sdk/go"

client := sdk.NewSodeomAiProxySDK(map[string]any{
    "apikey": os.Getenv("SODEOM-AI-PROXY_APIKEY"),
})

// Load ain data
ain, err := client.Ain(nil).Load(map[string]any{}, nil)
fmt.Println(ain)
```

### Ruby

```ruby
require_relative "SodeomAiProxy_sdk"

client = SodeomAiProxySDK.new({
  "apikey" => ENV["SODEOM-AI-PROXY_APIKEY"],
})


# Load a specific ain
ain, err = client.Ain().load({ "id" => "example_id" })
puts ain
```

### Lua

```lua
local sdk = require("sodeom-ai-proxy_sdk")

local client = sdk.new({
  apikey = os.getenv("SODEOM-AI-PROXY_APIKEY"),
})


-- Load a specific ain
local ain, err = client:Ain():load({ id = "example_id" })
print(ain)
```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = SodeomAiProxySDK.test()
const result = await client.Ain().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = SodeomAiProxySDK.test()
result, err = client.Ain().load({"id": "test01"})
```

### PHP

```php
$client = SodeomAiProxySDK::test();
[$result, $err] = $client->Ain()->load(["id" => "test01"]);
```

### Golang

```go
client := sdk.Test()
result, err := client.Ain(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = SodeomAiProxySDK.test
result, err = client.Ain().load({ "id" => "test01" })
```

### Lua

```lua
local client = sdk.test()
local result, err = client:Ain():load({ id = "test01" })
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

---

Generated from the Sodeom AI Proxy OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
