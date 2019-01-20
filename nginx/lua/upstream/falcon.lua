-- -*- coding:utf-8 -*-

-------------------------------------------------------------------------------
--- falcon http 接口封装
-- @module falcon

local cjson = require("cjson.safe")
local class = require("pl.class")

local http_helper = require("upstream.http_helper")

local falcon = require ("falcon.falcon")
local status = require("falcon.metrics.status")

local M = class(http_helper)

function M:send(path, params)
    local res, err = self.httpc:request_uri(self.uri .. path, params)
    if not res then
        ngx.log(ngx.ERR, "failed to get resp:", err)
        return
    end

    -- 统计 http 状态码
    local shm_key = status.gen_shm_key(self.host, path, res.status)
    falcon.incr_value(shm_key)

    if res.status ~= ngx.HTTP_OK then
        ngx.log(ngx.ERR, "resp http status err, status", res.status, " reason:", res.reason)
        return
    end

    ngx.log(ngx.DEBUG, "resp body:", res.body)

    local body = res.body
    return body
end

-- 将 payload 上报 falcon
function M:report(payload)
    local params = {
        ssl_verify = false,
        method = "POST",
        query = {
        },
        headers = {
            Host = self.host,
        },
        body = cjson.encode(payload)
    }

    local resp = self:send("/v1/push", params)

    return resp
end

return M
