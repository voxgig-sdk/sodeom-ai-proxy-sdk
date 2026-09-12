import { SodeomAiProxyEntityBase } from '../SodeomAiProxyEntityBase';
import type { SodeomAiProxySDK } from '../SodeomAiProxySDK';
import type { Control } from '../types';
import type { Ain, AinLoadMatch, AinCreateData } from '../SodeomAiProxyTypes';
declare class AinEntity extends SodeomAiProxyEntityBase<Ain> {
    constructor(client: SodeomAiProxySDK, entopts: any);
    make(this: AinEntity): AinEntity;
    load(this: any, reqmatch?: AinLoadMatch, ctrl?: Control): Promise<AinEntity>;
    create(this: any, reqdata?: AinCreateData, ctrl?: Control): Promise<AinEntity>;
}
export { AinEntity };
