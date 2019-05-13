-- -*- coding:utf-8; -*-
--- misc/ip.lua
-- @script ip
-- @author:phenix3443+github@gmail.com
local config = require("config")

local sp = require("serpent")
local lu = require("luaunit")

local GEO = require("misc.geo")

local city_db = _G.project_path.."lua/misc/GeoLite2-City.mmdb"
local asn_db = _G.project_path.."lua/misc/GeoLite2-ASN.mmdb"
local geo = GEO(city_db, asn_db)

_G.test_geo = {}

function test_geo:setUp()
end

function test_geo:test_get_city_info_ipv4()
    local ip = "223.255.254.254"
    local info = geo:get_city_info(ip)
    -- print(sp.block(info))
    lu.assertNotNil(info)
end

function test_geo:test_get_city_info_invalid_ipv4()
    local ip = "127.0.0.1"
    local info = geo:get_city_info(ip)
    lu.assertNil(info)
end

function test_geo:test_get_city_info_ipv6()
    local ip = "2607:f8b0:4004:801::100e"
    local info = geo:get_city_info(ip)
    lu.assertNotNil(info)
    -- print(sp.block(info))
end

function test_geo:test_get_isp_info_ipv4()
    local ip = "223.255.254.254"
    local info = geo:get_isp_info(ip)
    lu.assertNotNil(info)
    -- print(sp.block(info))
end

function test_geo:test_get_isp_info_ipv6()
    local ip = "2607:f8b0:4004:801::100e"
    local info = geo:get_isp_info(ip)
    lu.assertNotNil(info)
    -- print(sp.block(info))
end

os.exit(lu.LuaUnit.run())
