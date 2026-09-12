import { Context } from './Context';
declare class SodeomAiProxyError extends Error {
    isSodeomAiProxyError: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { SodeomAiProxyError };
