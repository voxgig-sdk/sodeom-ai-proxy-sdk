
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { SodeomAiProxySDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await SodeomAiProxySDK.test()
    equal(null !== testsdk, true)
  })

})
