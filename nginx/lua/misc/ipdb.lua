-- -*- coding:utf-8 -*-
--- ipdb.
-- @module misc.ip 信息解析.
-- @author:phenix3443+github@gmail.com

local class = require("pl.class")
local mm = require("maxminddb")

local M = class()

function M:_init(db_path)
    self.ipdb = mm.open(db_path)
    if not self.ipdb then
        ngx.log(ngx.WARN, "ip db not open, path: ", db_path)
        return
    end
end


--- 根据 ip_str, 返回 ip 所在的地理位置信息
function M:get_location_info(ip_str)
    local ok, res = pcall(self.ipdb.lookup, self.ipdb, ip_str)
    if not ok then
        return
    end

    local t = {
        coun_n = res:get("country"),
        prov_n = res:get("prov"),
        city_n = res:get("city"),
        isp_n  = res:get("isp"),
    }
    return t
end

return  M
