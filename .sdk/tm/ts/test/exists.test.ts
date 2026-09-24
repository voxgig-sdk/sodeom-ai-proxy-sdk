
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { SodeomAiProxySDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = SodeomAiProxySDK.test()
    equal(testsdk instanceof SodeomAiProxySDK, true,
      'SodeomAiProxySDK.test() must return a client synchronously')
  })

})
