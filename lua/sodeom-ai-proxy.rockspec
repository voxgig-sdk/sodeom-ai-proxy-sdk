package = "voxgig-sdk-sodeom-ai-proxy"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/sodeom-ai-proxy-sdk.git"
}
description = {
  summary = "SodeomAiProxy SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["sodeom-ai-proxy_sdk"] = "sodeom-ai-proxy_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
