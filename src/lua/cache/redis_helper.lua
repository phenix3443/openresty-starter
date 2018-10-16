-- -*- coding:utf-8 -*-
--- redis辅助
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")
local redis = require("resty.redis")
local class = require("pl.class")

local M = class()

function M:_init(redis_cfg)
    local red, err = redis:new()
    if not red then
        ngx.log(ngx.ERR,"failed to instantiate redis: ", err)
        return
    end

    local ok
    ok, err = red:connect(redis_cfg.host, redis_cfg.port)

    if not ok then
        ngx.log(ngx.ERR,"failed to connect: ", err)
        return
    end

    if redis_cfg.password then
        ok, err = red:auth(redis_cfg.password)
        if not ok then
            ngx.log(ngx.ERR,"failed to auth: ", err)
            return
        end
    end

    ok, err = red:select(redis_cfg.database)
    if not ok then
        ngx.log(ngx.ERR,"failed to select database: ", err)
        return
    end

    ngx.log(ngx.DEBUG,"connected to redis.")

    self.red = red
end

function M:is_connected()
    return self.red
end

function M:close()
    local ok, err = self.red:set_keepalive(10000, 100)
    if not ok then
        ngx.log(ngx.ERR, "failed to set keepalive: ", err)
        return
    end
end

return M
