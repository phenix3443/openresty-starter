-- -*- coding:utf-8 -*-
--- http头部语言相关
-- @author:liushangliang@xunlei.com

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")
local ngx_re = require("ngx.re")

local M = {}

-- 将Accept_Language解析为table
function M.get_lang_options(accept_lang)
    local options = {}

    for _,lq in pairs(ngx_re.split(accept_lang, ",")) do
        local s = ngx_re.split(lq, ";")
        local l = s[1]
        local q = 1
        if s[2] and s[2] ~= "" then
            local t = ngx_re.split(s[2],"=")[2]
            if t and tonumber(t) then
                q = tonumber(t)
            end
        end
        options[l] = q
    end

    ngx.log(ngx.DEBUG, "accept_lang:", accept_lang, " options:", cjson.encode(options))

    return options
end

-- 获取客户端最合适的语言
function M.get_favor_lang(accept_lang)
    local favor
    local options = M.get_lang_options(accept_lang or "")

    if next(options) then
        local iter = tablex.sortv(options, function(x,y) return x>y end )
        favor,_ = iter(1)
    end

    ngx.log(ngx.DEBUG, "accept_lang:", accept_lang, " favor:", favor)

    return favor
end

return M
