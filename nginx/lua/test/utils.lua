-- -*- coding:utf-8; -*-
--- misc/utils.lua 测试用例.
-- @script test-utils
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local lu = require("luaunit")

local utils = require("misc.utils")

--- 测试 concat_kv
local function test_concat_kv()
    local t = {
        a = "b",
        c = 10,
    }
    local str = utils.concat_kv(",", t)
    print(str)
end


lu.LuaUnit.run()
