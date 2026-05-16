
import { Context } from './Context'


class SodeomAiProxyError extends Error {

  isSodeomAiProxyError = true

  sdk = 'SodeomAiProxy'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  SodeomAiProxyError
}

