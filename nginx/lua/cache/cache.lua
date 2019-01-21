-- -*- coding:utf-8 -*-
--- 业务缓存层接口.
-- 该层主要对接业务接口，进一步封装底层的软件实现。
-- @module cache
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")

local conf = require("conf.common")
local ExampleCache = require("cache.example")

local M = {}

--- 示例程序
-- 获取 example_cache 实例的相关信息
function M.get_example_cache_info()
    local example_cache = ExampleCache(conf.example_cache)
    if not example_cache:is_connected() then
        return
    end
    local ok = example_cache:get_info()
    example_cache:close()

    return ok
end

-- 以下是具体的接口 -----------------------------------------------------------


return M
