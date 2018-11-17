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

function M:close()
    local ok, err = self.httpc:set_keepalive(10000, 100)
    if not ok then
        ngx.log(ngx.ERR, "set keepalive failed, ", err)
        return
    end
    ngx.log(ngx.DEBUG, "set keepalive successful")
end

return M
