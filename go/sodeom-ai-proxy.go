package voxgigsodeomaiproxysdk

import (
	"github.com/voxgig-sdk/sodeom-ai-proxy-sdk/go/core"
	"github.com/voxgig-sdk/sodeom-ai-proxy-sdk/go/entity"
	"github.com/voxgig-sdk/sodeom-ai-proxy-sdk/go/feature"
	_ "github.com/voxgig-sdk/sodeom-ai-proxy-sdk/go/utility"
)

// Type aliases preserve external API.
type SodeomAiProxySDK = core.SodeomAiProxySDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type SodeomAiProxyEntity = core.SodeomAiProxyEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type SodeomAiProxyError = core.SodeomAiProxyError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewAinEntityFunc = func(client *core.SodeomAiProxySDK, entopts map[string]any) core.SodeomAiProxyEntity {
		return entity.NewAinEntity(client, entopts)
	}
	core.NewAin2EntityFunc = func(client *core.SodeomAiProxySDK, entopts map[string]any) core.SodeomAiProxyEntity {
		return entity.NewAin2Entity(client, entopts)
	}
}

// Constructor re-exports.
var NewSodeomAiProxySDK = core.NewSodeomAiProxySDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
