-- -*- coding:utf-8; -*-
--- 测试utils/utils.lua
-- @author:phenix3443+github@gmail.com
-- doc:
local cjson = require("cjson.safe")
local lu = require("luaunit")
local utils = require("utils.utils")

function test_get_favor_lang()
    local favor = utils.get_favor_lang("fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7, *;q=0.5")
    lu.assertEquals(favor,"fr-CH")

    favor = utils.get_favor_lang("zh")
    lu.assertEquals(favor,"zh")

    favor = utils.get_favor_lang("")
    lu.assertEvalToFalse(favor, nil)
end


local function main()
    lu.LuaUnit.run()
end

main()
