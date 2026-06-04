# SodeomAiProxy SDK

OpenAI-compatible proxy that forwards chat completions to GitHub Models, with no API key required from callers

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About Sodeom AI Proxy

Sodeom AI Proxy is a small public HTTP service operated by [Sodeom](https://sodeom.com) (Abdul Hadi) that exposes an OpenAI-compatible interface in front of [GitHub Models](https://github.com/marketplace/models). It lets you call familiar chat-completion endpoints without managing your own GitHub token, so any OpenAI SDK can be pointed at it by changing only the base URL.

What you get from the API:

- A simple `GET /ai?query=...` endpoint that returns `{"answer": "..."}` for one-shot questions.
- An OpenAI-shaped `POST /v1/chat/completions` endpoint accepting `messages`, `model`, `temperature`, `max_tokens`, `top_p`, `stop`, `frequency_penalty`, `presence_penalty`, `seed`, `n`, and `stream`.
- A `GET /v1/models` endpoint listing the supported models (including `gpt-4o-mini` as the default, `gpt-4o`, `o1-mini`, and Meta Llama variants).
- Server-Sent-Events streaming on chat completions.

Operational notes: CORS is enabled, no caller-side API key is required (the proxy supplies its own GitHub token upstream), and there is no published rate limit. Health monitoring on the community catalogue page reports an average response time around 2.5 seconds and roughly 80% reliability, so the service is suitable for experimentation and demos rather than production workloads.

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

## 30-second quickstart

### TypeScript

```ts
import { SodeomAiProxySDK } from 'sodeom-ai-proxy'

const client = new SodeomAiProxySDK({})

```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

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
| **Ain** | The AI proxy resource — wraps the OpenAI-compatible chat surface exposed at `/ai` and `/v1/chat/completions`, forwarded to GitHub Models. | `/ai` |
| **Ain2** | A secondary grouping for the same AI proxy surface, covering the model-listing endpoint at `/v1/models` alongside the chat-completion operations. | `/ai` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from sodeomaiproxy_sdk import SodeomAiProxySDK

client = SodeomAiProxySDK({})


# Load a specific ain
ain, err = client.Ain(None).load(
    {"id": "example_id"}, None
)
```

### PHP

```php
<?php
require_once 'sodeomaiproxy_sdk.php';

$client = new SodeomAiProxySDK([]);


// Load a specific ain
[$ain, $err] = $client->Ain(null)->load(
    ["id" => "example_id"], null
);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/sodeom-ai-proxy-sdk/go"

client := sdk.NewSodeomAiProxySDK(map[string]any{})

```

### Ruby

```ruby
require_relative "SodeomAiProxy_sdk"

client = SodeomAiProxySDK.new({})


# Load a specific ain
ain, err = client.Ain(nil).load(
  { "id" => "example_id" }, nil
)
```

### Lua

```lua
local sdk = require("sodeom-ai-proxy_sdk")

local client = sdk.new({})


-- Load a specific ain
local ain, err = client:Ain(nil):load(
  { id = "example_id" }, nil
)
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
client = SodeomAiProxySDK.test(None, None)
result, err = client.Ain(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = SodeomAiProxySDK::test(null, null);
[$result, $err] = $client->Ain(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.Ain(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = SodeomAiProxySDK.test(nil, nil)
result, err = client.Ain(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:Ain(nil):load(
  { id = "test01" }, nil
)
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

## Using the Sodeom AI Proxy

- Upstream: [https://sodeom.com](https://sodeom.com)
- API docs: [https://sodeom.com/apis/ai](https://sodeom.com/apis/ai)

- Proprietary service provided by Sodeom (built by Abdul Hadi).
- Free to use as a public proxy; no API key is required ("pass anything").
- GitHub token authentication to the upstream GitHub Models API happens server-side.
- No explicit rate limits or SLA are published; treat the service as best-effort.

---

Generated from the Sodeom AI Proxy OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
