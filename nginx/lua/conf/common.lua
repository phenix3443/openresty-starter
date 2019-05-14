-- -*- coding:utf-8 -*-
--- 公共配置模块.
-- @module conf.common
-- @author:phenix3443@gmail.com

local M = {}

--- 项目名称.
M.project = "example"

--- 当前运行环境.
-- M.mode = "mock"                 -- 本地开发环境，必要时外部接口使用 mock 实现。
-- M.mode = "develop"              -- develop：开发环境。
-- M.mode = "pre-release"          -- 预发布环境。
M.mode = "release"              -- 生产环境

M.ipdb = {
    db = ngx.config.prefix() .. "lua/misc/ipdb.mmdb"
}

M.mmdb = {
    city_db = ngx.config.prefix() .. "lua/misc/GeoLite2-City.mmdb",
    asn_db = ngx.config.prefix() .. "lua/misc/GeoLite2-ASN.mmdb"
}

M.geo = {
    country = ngx.config.prefix()..'/lua/misc/country',
    area = ngx.config.prefix()..'/lua/misc/area',
    prov = ngx.config.prefix()..'/lua/misc/province',
    city = ngx.config.prefix()..'/lua/misc/city',
    isp = ngx.config.prefix()..'/lua/misc/isp',
}

return M
