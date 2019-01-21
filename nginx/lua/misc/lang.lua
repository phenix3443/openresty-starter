-- -*- coding:utf-8 -*-
--- http 头部语言相关.
-- @module lang

local M = {}

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")
local stringx = require("pl.stringx")

--- 将 Accept_Language 解析为 table.
-- @tparam string accept_lang  http 头部中 Accept_Language 字段
-- @treturn {lang:weight...} 语言和权重的对应表
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

--- 获取客户端最合适的语言.
-- @tparam string accept_lang http 头部中 Accept_Language 字段
-- @treturn string 返回权重最大的语言
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
