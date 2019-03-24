-- -*- coding:utf-8 -*-
--- 解析 HTTP 头部 AcceptLanguage 参数
-- @module lang
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")
local stringx = require("pl.stringx")

local M = {}

--- 将 Accept_Language 解析为 table.
-- @tparam string accept_lang  http 头部中 Accept_Language 字段
-- @treturn {lang:weight...} 语言和权重的对应表
function M.get_lang_options(accept_lang)
    if not (accept_lang and type(accept_lang) == "string" and string.len(accept_lang) > 0) then
        return
    end

    local options = {}
    for _,lq in pairs(stringx.split(accept_lang, ",")) do -- 语言之间是使用逗号分割的
        local s = stringx.split(lq, ";")                  -- 语言和权重之间是使用分号分割的
        local l = s[1]
        local q = 1                 -- 默认权重是 1
        if s[2] and s[2] ~= "" then -- 可能有的语言没有设置权重参数
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
    local options = M.get_lang_options(accept_lang)

    if options and next(options) then
        local iter = tablex.sortv(options, function(x,y) return x>y end )
        favor,_ = iter(1)
    end

    return favor
end

return M
