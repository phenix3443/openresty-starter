-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc:缓存
local cjson = require("cjson.safe")
local redis = require("resty.redis")

local export = {}
local mt = {__index = export}


function export.new(redis_cfg)
    local red, err = redis:new()
    if not red then
        ngx.log(ngx.ERR,"failed to instantiate redsi: ", err)
        return
    end

    local ok, err = red:connect(redis_cfg.host, redis_cfg.port)

    if not ok then
        ngx.log(ngx.ERR,"failed to connect: ", err)
        return
    end

    ok, err = red:select(redis_cfg.database)
    if not ok then
        ngx.log(ngx.ERR,"failed to select database: ", err)
        return
    end

    ngx.log(ngx.DEBUG,"connected to redis.")

    return setmetatable({red=red},mt)
end

function export.close(self)
    local ok, err = self.red:set_keepalive(10000, 100)
    if not ok then
        ngx.log(ngx.ERR, "failed to set keepalive: ", err)
        return
    end
end

return export
