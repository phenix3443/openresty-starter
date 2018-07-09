-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- 记录所用缓存的配置，
-- 该文件应该以缓存名字，例如count_cache.lua

local export = {}

export.collect_redis = {
    -- 记录采集任务的缓存
    ["host"] = "",
    ["port"] = "6379",
    ["password"] = "",
    ["db"] = 0,

}

return export
