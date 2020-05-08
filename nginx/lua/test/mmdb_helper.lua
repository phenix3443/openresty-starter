-- -*- coding:utf-8; -*-
--- misc/ip.lua
-- @script ip
-- @author:phenix3443@gmail.com
-- bin/resty --shdict "falcon 20m" --errlog-level debug --http-include nginx/lua/test/test.nginx.conf nginx/lua/test/mmdb_helper.lua

local sp = require("serpent")
local lu = require("luaunit")

local MMH = require("misc.mmdb_helper")
local city_db = ngx.config.prefix() .. "lua/misc/GeoLite2-City.mmdb"
local asn_db = ngx.config.prefix() .. "lua/misc/GeoLite2-ASN.mmdb"
local mmh = MMH(city_db, asn_db)

_G.test_mm_helper = {}

function test_mm_helper:setUp()
end

function test_mm_helper:test_get_city_info_ipv4()
    local ip = "223.255.254.254"
    local info = mmh:get_city_info(ip)
    -- print(sp.block(info))
    lu.assertNotNil(info)
end

function test_mm_helper:test_get_city_info_invalid_ipv4()
    local ip = "127.0.0.1"
    local info = mmh:get_city_info(ip)
    lu.assertNil(info)
end

function test_mm_helper:test_get_city_info_ipv6()
    local ip = "2607:f8b0:4004:801::100e"
    local info = mmh:get_city_info(ip)
    lu.assertNotNil(info)
    -- print(sp.block(info))
end

function test_mm_helper:test_get_isp_info_ipv4()
    local ip = "223.255.254.254"
    local info = mmh:get_isp_info(ip)
    lu.assertNotNil(info)
    -- print(sp.block(info))
end

function test_mm_helper:test_get_isp_info_ipv6()
    local ip = "2607:f8b0:4004:801::100e"
    local info = mmh:get_isp_info(ip)
    lu.assertNotNil(info)
    -- print(sp.block(info))
end

os.exit(lu.LuaUnit.run())
