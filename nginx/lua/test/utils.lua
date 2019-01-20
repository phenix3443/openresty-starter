-- -*- coding:utf-8; -*-

-------------------------------------------------------------------------------
--- 测试 utils/utils.lua
-- @module test-utils

local cjson = require("cjson.safe")
local lu = require("luaunit")

local utils = require("misc.utils")

local function test_concat_k_v()
    local t = {
        a = "b",
        c = 10,
    }
    local str = utils.concat_k_v(",", t)
    print(str)
end


lu.LuaUnit.run()
