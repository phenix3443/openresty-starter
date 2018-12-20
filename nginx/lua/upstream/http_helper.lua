-- -*- coding:utf-8 -*-
--- http接口封装示例
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")
local http = require("resty.http")
local class = require("pl.class")

local M = class()

function M:_init(cfg)
    self.host = cfg.host
    self.uri = cfg.uri
    self.httpc = http.new()
end

return M
