-- -*- coding:utf-8; -*-
--- 测试utils/utils.lua
-- @author:phenix3443+github@gmail.com
-- doc:
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
