-- -*- coding:utf-8 -*-
--- 业务缓存层接口.
-- 该层主要对接业务接口，进一步封装底层的软件实现。
-- @module cache
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")

local cfg = require("conf.common")
local ucfg = require("conf.upstream")
local ExampleCache = require("cache.example")

local M = {}

--- 示例程序
-- 获取 example_cache 实例的相关信息
function M.get_example_cache_info()
    local c = ExampleCache(ucfg.example_cache)
    local info = c:get_info()
    c:close()

    return info
end

-- 以下是具体的接口 -----------------------------------------------------------

return M
