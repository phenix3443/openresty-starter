-- -*- coding:utf-8; -*-

-------------------------------------------------------------------------------
--- 测试 utils/lang.lua
-- @module test_lang


local lu = require("luaunit")

local config = require("config")
local lang = require("misc.lang")

function test_get_favor_lang()
    local favor = lang.get_favor_lang("fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7, *;q=0.5")
    lu.assertEquals(favor,"fr-CH")

    favor = lang.get_favor_lang("zh")
    lu.assertEquals(favor,"zh")

    favor = lang.get_favor_lang("")
    lu.assertEvalToFalse(favor, nil)
end


lu.LuaUnit.run()
