-- -*- coding:utf-8 -*-
--- http接口封装示例
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local http = require("resty.http")
local class = require("pl.class")

local M = class()

function M:_init(cfg)
    self.host = cfg.host

    local httpc = http.new()
    local ok, err = httpc:connect(cfg.ip, cfg.port)

    if not ok then
        ngx.log(ngx.ERR, "connect ", cfg.host, " failed, ", err)
        return
    end

    ngx.log(ngx.DEBUG, "connect ", cfg.host, " successful")


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
