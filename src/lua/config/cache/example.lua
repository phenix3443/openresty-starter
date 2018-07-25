-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- 记录所用缓存的配置，
-- 该文件应该以缓存名字，例如count_cache.lua

local export = {}

export.example_redis = {
    -- 记录采集任务的缓存
    ["host"] = "127.0.0.1",
    ["port"] = "6379",
    ["password"] = "",
    ["db"] = 0,

}

return export
