-- -*- coding:utf-8; -*-
--- misc/ip.lua
-- @script ip字符串测试
-- @author:phenix3443+github@gmail.com

local config = require("config")

local ip_str = require("misc.ip_str")

local lu = require("luaunit")

_G.test_get_type = {}

function test_get_type:setUp()
end

function test_get_type:test_ip_not_str()
    local ip = 129.10
    lu.assertEquals(ip_str.get_type(ip), 0)
end

function test_get_type:test_ipv4()
    local ip = "128.1.0.1"    -- ipv4
    lu.assertEquals(ip_str.get_type(ip), 1)
    ip = "223.255.254.254"  -- ipv4
    lu.assertEquals(ip_str.get_type(ip), 1)
end

function test_get_type:test_invlid_ipv4_range()
    local ip = "999.12345.0.0001"   -- invalid ipv4
    lu.assertEquals(ip_str.get_type(ip), 0)
end

function test_get_type:test_ipv6()
    local ip = "1050:0:0:0:5:600:300c:326b"         -- ipv6
    lu.assertEquals(ip_str.get_type(ip), 2)
    ip = "1050:0000:0000:0000:0005:0600:300c:326b"  -- ipv6
    lu.assertEquals(ip_str.get_type(ip), 2)
end

function test_get_type:test_invalid_ipv6()
    local ip = "1050!0!0+0-5@600$300c#326b"         -- string
    lu.assertEquals(ip_str.get_type(ip), 3)
    ip = "1050:::600:5:1000::"  -- contracted ipv6 (invalid)
    lu.assertEquals(ip_str.get_type(ip), 3)
    ip = ":"   -- string
    lu.assertEquals(ip_str.get_type(ip), 3)
    ip = "129.garbage.9.1"  -- string
    lu.assertEquals(ip_str.get_type(ip), 3)
end

function test_get_type:test_invlid_ipv4_range()
    local ip = "1050:0:0:0:5:600:300c:326babcdef"     -- string
    lu.assertEquals(ip_str.get_type(ip), 3)
end

function test_get_type:test_shortened_ipv6()
    local ip = "fe80::202:b3ff:fe1e:8329"   -- shortened ipv6
    lu.assertEquals(ip_str.get_type(ip), 2)
    ip = "::1"   -- valid IPv6
    lu.assertEquals(ip_str.get_type(ip), 2)
    ip = "::"  -- valid IPv6
    lu.assertEquals(ip_str.get_type(ip), 2)
end

function test_get_type:test_invalid_shortened_ipv6()
    local ip =  "fe80::202:b3ff::fe1e:8329"  -- shortened ipv6 (invalid)
    lu.assertEquals(ip_str.get_type(ip), 3)
end

function test_get_type:test_invalid_shortened_ipv6()
    local ip = "fe80:0000:0000:0000:0202:b3ff:fe1e:8329:abcd"  -- too many groups
    lu.assertEquals(ip_str.get_type(ip), 3)
end

os.exit(lu.LuaUnit.run())
