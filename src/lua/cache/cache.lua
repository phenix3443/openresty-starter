-- -*- coding:utf-8 -*-
--- 缓存接口，主要组合redis相关请求
-- @author:liushangliang@xunlei.com

local cjson = require("cjson.safe")

local mcc = require("config/example_cache") -- example_cache_cfg
local ExampleCache = require("cache/example_cache")

local M = {}

function M.get_example_cache_info()
    local example_cache = ExampleCache(mcc.connect_info)
    if not example_cache then
        return
    end
    local ok = example_cache:get_info()
    example_cache:close()

    return ok
end

return M
