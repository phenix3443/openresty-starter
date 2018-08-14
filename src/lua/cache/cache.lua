-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc:数据库接口
local cjson = require("cjson.safe")

local mcc = require("config/main_cache") -- main_cache_cfg
local MainCache = require("cache/main_cache")

local export = {}

function export.get_main_cache_info()
    local main_cache = MainCache.new(mcc.connect_info)
    if not main_cache then
        return
    end
    local ok = main_cache:get_info()
    main_cache:close()

    return ok
end

function export.add_barcode(k, v)
    local main_cache = MainCache.new(mcc.connect_info)
    if not main_cache then
        return
    end
    local ok = main_cache:add_barcode(k, v, mcc.barcode_expire)
    main_cache:close()

    return ok
end


return export
