package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewAinEntityFunc func(client *SodeomAiProxySDK, entopts map[string]any) SodeomAiProxyEntity

var NewAin2EntityFunc func(client *SodeomAiProxySDK, entopts map[string]any) SodeomAiProxyEntity

