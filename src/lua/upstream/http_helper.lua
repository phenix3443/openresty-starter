-- -*- coding:utf-8 -*-
--- http接口封装示例
-- @author:liushangliang@xunlei.com

local cjson = require("cjson.safe")
local http = require("resty.http")
local class = require("pl.class")

local M = class()

function M:_init(cfg)
    local httpc = http.new()
    local ok, err = httpc:connect(cfg.host, cfg.port)

    if not ok then
        ngx.log(ngx.ERR, "connect ", cfg.name, " failed, ", err)
        return
    end

    ngx.log(ngx.DEBUG, "connect ", cfg.name, " successful")

    self.httpc = httpc
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
