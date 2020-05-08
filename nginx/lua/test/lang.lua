-- -*- coding:utf-8; -*-
--- misc/lang.lua 测试用例.
-- @script test_lang
-- @author:phenix3443@gmail.com
-- bin/resty --shdict "falcon 20m" --errlog-level debug --http-include nginx/lua/test/test.nginx.conf nginx/lua/test/geo.lua

local serpent = require("serpent")
local lu = require("luaunit")

local lang = require("misc.lang")

_G.test_suite = {}
function test_suite:setUp()
end

function test_suite:test_multi_lang()
    local t = lang.get_lang_options("fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7, *;q=0.5")
end

function test_suite:test_empty_lang()
    local t = lang.get_lang_options("")
    lu.assertNil(t)
end

function test_suite:test_nil_lang()
    local t = lang.get_lang_options()
    lu.assertNil(t)
end

function test_suite:tearDown()
end

--- 测试 get_favor_lang
_G.test_get_favor_lang = {}
function test_get_favor_lang:test_multi_lang()
    -- 多个带有权重的候选语言
    local favor = lang.get_favor_lang("fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7, *;q=0.5")
    lu.assertEquals(favor, "fr-CH")
end

function test_get_favor_lang:test_one_lang()
    -- 只有一个候选语言
    local favor = lang.get_favor_lang("zh")
    lu.assertEquals(favor, "zh")
end

function test_get_favor_lang:test_no_lang()
    -- 没有候选语言。
    local favor = lang.get_favor_lang("")
    lu.assertEvalToFalse(favor, nil)
end

os.exit(lu.LuaUnit.run())
