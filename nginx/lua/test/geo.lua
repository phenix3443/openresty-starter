-- -*- coding:utf-8; -*-
--- misc/ip.lua
-- @script ip
-- @author:phenix3443@gmail.com
-- bin/resty --shdict "falcon 20m" --errlog-level debug --http-include nginx/lua/test/test.nginx.conf nginx/lua/test/geo.lua

local sp = require("serpent")
local lu = require("luaunit")

local GEO = require("misc.geo")

_G.test_suite = {}

function test_suite:setUp()
    local geo_cfg = {
        country = ngx.config.prefix() .. "/lua/misc/country",
        area = ngx.config.prefix() .. "/lua/misc/area",
        prov = ngx.config.prefix() .. "/lua/misc/province",
        city = ngx.config.prefix() .. "/lua/misc/city",
        isp = ngx.config.prefix() .. "/lua/misc/isp"
    }
    local ipdb_cfg = {
        db = ngx.config.prefix() .. "lua/misc/ipdb.mmdb"
    }
    local mmdb_cfg = {
        city_db = ngx.config.prefix() .. "lua/misc/GeoLite2-City.mmdb",
        asn_db = ngx.config.prefix() .. "lua/misc/GeoLite2-ASN.mmdb"
    }

    self.geo = GEO(geo_cfg, ipdb_cfg, mmdb_cfg)
end

function test_suite:test_get_location_info_by_sigapo_ip()
    local ip = "223.255.254.254"
    local info = self.geo:get_location_info_by_ip(ip)
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

function test_suite:test_get_location_info_by_india_ip()
    local ip = "13.232.158.182"
    local info = self.geo:get_location_info_by_ip(ip)
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

function test_suite:test_get_location_info_by_invalid_ipv4()
    local ip = "127.0.0.1"
    local info = self.geo:get_location_info_by_ip(ip)
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

function test_suite:test_get_location_info_by_ip_ipv6()
    local ip = "2607:f8b0:4004:801::100e"
    local info = self.geo:get_location_info_by_ip(ip)
    local expect = {
        area_n = 0,
        coun_n = 230,
        coun_s = "美国",
        isp_n = 15169,
        isp_s = "Google LLC"
    }
    lu.assertEquals(info, expect)
end

function test_suite:test_get_isp_info_ipv4()
    local ip = "223.255.254.254"
    local info = self.geo:get_isp_info(ip)
    lu.assertNotNil(info)
    -- print(sp.block(info))
end

function test_suite:test_get_isp_info_ipv6()
    local ip = "2607:f8b0:4004:801::100e"
    local info = self.geo:get_isp_info(ip)
    lu.assertNotNil(info)
    -- print(sp.block(info))
end

os.exit(lu.LuaUnit.run())
