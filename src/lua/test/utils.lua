-- -*- coding:utf-8; -*-
-- author:liushangliang
-- desc: 测试utils/utils.lua
-- doc:
local cjson = require("cjson.safe")
local utils = require("utils.utils")

local function test_get_favor_lang()
    local hds = ngx.req.get_headers()
    local accept_lang = hds["Accept-language"]

    if not accept_lang then
        ngx.log(ngx.DEBUG,"not accept language header")
        return
    end

    local favor = utils.get_favor_lang(accept_lang)

end

local function main()
    test_get_favor_lang()
end

main()
