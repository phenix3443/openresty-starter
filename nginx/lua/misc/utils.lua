-- -*- coding:utf-8 -*-
--- 通用工具函数.
-- @module utils
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")

local M = {}

--- 将 table 中 key，value 转变为 pos 连接字符串
-- 若 pos 是 & ，最后返回 key1=value1&key2=value2...
-- @param t 待处理的 table
-- @param pos 连接字符
-- @treturn string
function M.concat_kv(t, pos)
    local f = function(k,v) return string.format("%s=%s", k, v) end
    local t = tablex.pairmap(f, t)
    local str = table.concat(t, pos)
    ngx.log(ngx.DEBUG, "concated str:", str)
    return str
end

return M
