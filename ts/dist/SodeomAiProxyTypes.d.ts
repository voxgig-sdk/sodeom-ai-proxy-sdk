export interface Ain {
    answer: string;
    max_tokens?: number;
    messages: any[];
    model?: string;
    temperature?: number;
}
export interface AinLoadMatch {
    query: string;
}
export interface AinCreateData {
    answer: string;
    max_tokens?: number;
    messages: any[];
    model?: string;
    temperature?: number;
}
