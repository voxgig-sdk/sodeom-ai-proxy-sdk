package core

type SodeomAiProxyError struct {
	IsSodeomAiProxyError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewSodeomAiProxyError(code string, msg string, ctx *Context) *SodeomAiProxyError {
	return &SodeomAiProxyError{
		IsSodeomAiProxyError: true,
		Sdk:              "SodeomAiProxy",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *SodeomAiProxyError) Error() string {
	return e.Msg
}
