-- -*- coding:utf-8 -*-
--- misc.ipdb
-- @module ip 信息解析.
-- @author:phenix3443+github@gmail.com

local mmdb = require("mmdb")
local class = require("pl.class")

local ip_str = require("misc.ip_str")

local M = class()

--- 初始化函数
-- 初始化相关参数，该函数不需要手动调用。
-- @param city_db city 数据库
-- @param asn_db asn 数据库
function M:_init(city_db, asn_db)
    -- Download from http://dev.maxmind.com/geoip/geoip2/geolite2/
    self.geodb = assert(mmdb.read(city_db))
    self.ispdb = assert(mmdb.read(asn_db))
end

--- 获取IP相关的城市信息
-- @param ip
function M:get_city_info(ip)
    local typ = ip_str.get_type(ip)
    local info
    if typ == 1 then
        info = self.geodb:search_ipv4(ip)
    elseif typ == 2 then
        info = self.geodb:search_ipv6(ip)
    end

    return info
end

--- 获取IP相关的 isp 信息
-- @param ip
function M:get_isp_info(ip)
    local typ = ip_str.get_type(ip)
    local info
    if typ == 1 then
        info = self.ispdb:search_ipv4(ip)
    elseif typ == 2 then
        info = self.ispdb:search_ipv6(ip)
    end

    return info
end


return M
