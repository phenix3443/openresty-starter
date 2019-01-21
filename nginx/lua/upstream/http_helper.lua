-- -*- coding:utf-8 -*-
--- lua_http 接口封装示例.
-- 参考 https://github.com/daurnimator/lua-http
-- @classmod http_helper

local cjson = require("cjson.safe")
local http = require("resty.http")
local class = require("pl.class")

local M = class()

--- 初始化函数
-- 初始化相关参数，该函数不需要手动调用。
-- @param cfg http 连接的 host，uri 等参数。
function M:_init(cfg)
    self.host = cfg.host
    self.uri = cfg.uri
    self.httpc = http.new()
end

return M
