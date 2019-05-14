-- -*- coding:utf-8; -*-
--- misc/ip.lua
-- @script ip
-- @author:phenix3443@gmail.com
local config = require("config")

local sp = require("serpent")
local lu = require("luaunit")

local cfg = {
    geo = {
        country = _G.project_path..'/lua/misc/country',
        area = _G.project_path..'/lua/misc/area',
        prov = _G.project_path..'/lua/misc/province',
        city = _G.project_path..'/lua/misc/city',
        isp = _G.project_path..'/lua/misc/isp',
    },
    ipdb = {
        db = _G.project_path .. "lua/misc/ipdb.mmdb"
    },
    mmdb = {
        city_db = _G.project_path .. "lua/misc/GeoLite2-City.mmdb",
        asn_db = _G.project_path .. "lua/misc/GeoLite2-ASN.mmdb"
    }
}

local GEO = require("misc.geo")
local geo = GEO(cfg.geo, cfg.ipdb, cfg.mmdb)

_G.test_geo = {}

function test_geo:setUp()
end

function test_geo:test_get_location_info_by_sigapo_ip()
    local ip = "223.255.254.254"
    local info = geo:get_location_info_by_ip(ip)
    local expect = {
        area_n = 0,
        city_s = "新加坡",
        coun_n = 196,
        coun_s = "新加坡",
        isp_n = 55415,
        isp_s = "MARINA BAY SANDS PTE LTD"
    }
    lu.assertEquals(info, expect)
end

function test_geo:test_get_location_info_by_india_ip()
    local ip = "13.232.158.182"
    local info = geo:get_location_info_by_ip(ip)
    local expect = {
        area_n = 0,
        city_s = "孟买",
        coun_n = 104,
        coun_s = "印度",
        isp_n = 280,
        isp_s = "amazon.com",
        prov_s = "马哈拉施特拉邦"
    }

    lu.assertEquals(info, expect)
end


function test_geo:test_get_location_info_by_invalid_ipv4()
    local ip = "127.0.0.1"
    local info = geo:get_location_info_by_ip(ip)
    local expect = {
        area_n = 4,
        area_s = "华南区",
        city_n = 4,
        city_s = "广州市",
        coun_n = 47,
        coun_s = "中国",
        isp_n = 1,
        isp_s = "电信",
        prov_n = 12,
        prov_s = "广东省"
    }
    lu.assertEquals(info, expect)
end

function test_geo:test_get_location_info_by_ip_ipv6()
    local ip = "2607:f8b0:4004:801::100e"
    local info = geo:get_location_info_by_ip(ip)
    local expect =     {
        area_n = 0,
        coun_n = 230,
        coun_s = "美国",
        isp_n = 15169,
        isp_s = "Google LLC"
    }
    lu.assertEquals(info, expect)
end

-- function test_geo:test_get_isp_info_ipv4()
--     local ip = "223.255.254.254"
--     local info = geo:get_isp_info(ip)
--     lu.assertNotNil(info)
--     -- print(sp.block(info))
-- end

-- function test_geo:test_get_isp_info_ipv6()
--     local ip = "2607:f8b0:4004:801::100e"
--     local info = geo:get_isp_info(ip)
--     lu.assertNotNil(info)
--     -- print(sp.block(info))
-- end

os.exit(lu.LuaUnit.run())
