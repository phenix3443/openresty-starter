-- -*- coding:utf-8 -*-
--- 账号服务接口
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")
local class = require("pl.class")

local http_helper = require("upstream.http_helper")

local M = class(http_helper)

function M:send(path, params)
    local res, err = self.httpc:request_uri(self.uri .. path, params)
    if not res then
        ngx.log(ngx.ERR, "failed to get resp:", err)
        return
    end

    if res.status ~= ngx.HTTP_OK then
        ngx.log(ngx.ERR, "resp http status err, status", res.status, " reason:", res.reason)
        return
    end

    ngx.log(ngx.DEBUG, "resp body:", res.body)

    local body = res.body
    return body
end

-- 将payload上报falcon
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
