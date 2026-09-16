

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { SodeomAiProxySDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
loadEnvLocal(__dirname + '/../../../.env.local')


describe('AinEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SODEOM_AI_PROXY_TEST_LIVE=TRUE.
  afterEach(liveDelay('SODEOM_AI_PROXY_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SodeomAiProxySDK.test()
    const ent = testsdk.Ain()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SODEOM_AI_PROXY_TEST_LIVE
    for (const op of ['create', 'load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'ain.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"answer","req":true,"short":"Generated text response from the AI model","type":"`$STRING`","index$":0},{"active":true,"name":"max_tokens","req":false,"short":"Maximum tokens for the response","type":"`$INTEGER`","index$":1},{"active":true,"name":"messages","req":true,"short":"Chat history array passed to the model","type":"`$ARRAY`","index$":2},{"active":true,"name":"model","req":false,"short":"Overrides the default model (gpt-4o-mini)","type":"`$STRING`","index$":3},{"active":true,"name":"temperature","req":false,"short":"Sampling temperature passed through to the model (0.0 to 2.0)","type":"`$NUMBER`","index$":4}],"name":"ain","op":{"create":{"input":"data","name":"create","points":[{"active":true,"args":{},"contract":{"id":"POST /ai","json":"{\"operationId\":\"postAiResponse\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"example\":{\"messages\":[{\"content\":\"Say hi\",\"role\":\"user\"}],\"model\":\"gpt-4o-mini\",\"temperature\":0.7},\"schema\":{\"properties\":{\"max_tokens\":{\"description\":\"Maximum tokens for the response\",\"example\":2048,\"minimum\":1,\"type\":\"integer\"},\"messages\":{\"description\":\"Chat history array passed to the model\",\"items\":{\"properties\":{\"content\":{\"description\":\"The content of the message\",\"example\":\"Say hi\",\"type\":\"string\"},\"role\":{\"description\":\"The role of the message sender\",\"enum\":[\"system\",\"user\",\"assistant\"],\"example\":\"user\",\"type\":\"string\"}},\"required\":[\"role\",\"content\"],\"type\":\"object\"},\"minItems\":1,\"type\":\"array\"},\"model\":{\"description\":\"Overrides the default model (gpt-4o-mini)\",\"example\":\"gpt-4o-mini\",\"type\":\"string\"},\"temperature\":{\"description\":\"Sampling temperature passed through to the model (0.0 to 2.0)\",\"example\":0.7,\"maximum\":2,\"minimum\":0,\"type\":\"number\"}},\"required\":[\"messages\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"example\":{\"answer\":\"Hello! How can I assist you today?\"},\"schema\":{\"properties\":{\"answer\":{\"description\":\"Generated text response from the AI model\",\"example\":\"Hello! How can I assist you today?\",\"type\":\"string\"}},\"required\":[\"answer\"],\"type\":\"object\"}}},\"description\":\"Successful response with generated text\"},\"400\":{\"content\":{\"application/json\":{\"example\":{\"error\":\"Missing query and messages\"},\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message describing what went wrong\",\"example\":\"Missing query and messages\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request - Missing messages array\"},\"500\":{\"content\":{\"application/json\":{\"example\":{\"error\":\"Upstream API error\"},\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message describing what went wrong\",\"example\":\"Missing query and messages\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Internal server error - Upstream API error\"}},\"securitySource\":\"unspecified\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/ai","segments":[{"lit":"ai"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"load":{"input":"data","name":"load","points":[{"active":true,"args":{"query":[{"active":true,"example":"Say hi","kind":"query","name":"query","orig":"query","reqd":true,"type":"`$STRING`","index$":0}]},"contract":{"id":"GET /ai","json":"{\"operationId\":\"getAiResponse\",\"parameters\":[{\"description\":\"Simple prompt text used to build messages\",\"example\":\"Say hi\",\"in\":\"query\",\"name\":\"query\",\"required\":true,\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"example\":{\"answer\":\"Hello! How can I assist you today?\"},\"schema\":{\"properties\":{\"answer\":{\"description\":\"Generated text response from the AI model\",\"example\":\"Hello! How can I assist you today?\",\"type\":\"string\"}},\"required\":[\"answer\"],\"type\":\"object\"}}},\"description\":\"Successful response with generated text\"},\"400\":{\"content\":{\"application/json\":{\"example\":{\"error\":\"Missing query and messages\"},\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message describing what went wrong\",\"example\":\"Missing query and messages\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request - Missing query parameter\"},\"500\":{\"content\":{\"application/json\":{\"example\":{\"error\":\"Upstream API error\"},\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message describing what went wrong\",\"example\":\"Missing query and messages\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Internal server error - Upstream API error\"}},\"securitySource\":\"unspecified\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/ai","segments":[{"lit":"ai"}],"select":{"exist":["query"]},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"ain","name__orig":"ain","Name":"Ain","name_":"ain","name-":"ain","NAME":"AIN","index$":0}, {"active":true,"entity":"ain","key$":"BasicAinFlow","kind":"basic","name":"BasicAinFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"ain_ref01"},"match":{},"op":"create","spec":[],"valid":[],"index$":0},{"active":true,"data":{},"input":{"ref":"ain_ref01","srcdatavar":"ain_ref01_data","suffix":"_dt0"},"match":{},"op":"load","spec":[],"valid":[{"apply":"TextFieldMark","def":{"mark":"Mark01-ain_ref01"}}],"index$":1}]}, 'Ain')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const ain_ref01_ent = client.Ain()
    let ain_ref01_data = setup.data.new.ain['ain_ref01']

    ain_ref01_data = (await ain_ref01_ent.create(ain_ref01_data)).data()
    assert(null != ain_ref01_data)


    // LOAD
    const ain_ref01_match_dt0: any = {}
    const ain_ref01_data_dt0 = (await ain_ref01_ent.load(ain_ref01_match_dt0)).data()
    assert(null != ain_ref01_data_dt0)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/ain/AinTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = SodeomAiProxySDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['ain01','ain02','ain03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SODEOM_AI_PROXY_TEST_AIN_ENTID': idmap,
    'SODEOM_AI_PROXY_TEST_LIVE': 'FALSE',
    'SODEOM_AI_PROXY_TEST_EXPLAIN': 'FALSE',
  })

  idmap = env['SODEOM_AI_PROXY_TEST_AIN_ENTID']

  const live = 'TRUE' === env.SODEOM_AI_PROXY_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SODEOM_AI_PROXY_TEST_AIN_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new SodeomAiProxySDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.SODEOM_AI_PROXY_TEST_EXPLAIN,
    live,
    transport,
    now: Date.now(),
  }

  return setup
}
  
