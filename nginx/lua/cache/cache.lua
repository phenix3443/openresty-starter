-- -*- coding:utf-8 -*-

-------------------------------------------------------------------------------
-- 缓存接口，主要组合 redis 相关请求
-- @module cache

local cjson = require("cjson.safe")

local conf = require("conf.config")
local ExampleCache = require("cache.example")

local M = {}

function M.get_example_cache_info()
    local example_cache = ExampleCache(conf.example_cache)
    if not example_cache:is_connected() then
        return
    end
    local ok = example_cache:get_info()
    example_cache:close()

    return ok
end

return M
