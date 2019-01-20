-- -*- coding:utf-8 -*-

-------------------------------------------------------------------------------
--- http 头部语言相关
-- @module lang

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")
local stringx = require("pl.stringx")

local M = {}

-- 将 Accept_Language 解析为 table
function M.get_lang_options(accept_lang)
    local options = {}

    for _,lq in pairs(stringx.split(accept_lang, ",")) do
        local s = stringx.split(lq, ";")
        local l = s[1]
        local q = 1
        if s[2] and s[2] ~= "" then
            local t = stringx.split(s[2],"=")[2]
            if t and tonumber(t) then
                q = tonumber(t)
            end
        end
        options[l] = q
    end

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

    return favor
end

return M
