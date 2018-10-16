-- -*- coding:utf-8 -*-
--- 账号服务接口
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")
local class = require("pl.class")

local http_helper = require("upstream.http_helper")

local M = class(http_helper)

function M:send(req)
    ngx.log(ngx.DEBUG, "req:", cjson.encode(req))
    local res, err = self.httpc:request(req)
    if not res then
        ngx.log(ngx.ERR, "failed to get resp:", err)
        return
    end

    if res.status ~= ngx.HTTP_OK then
        ngx.log(ngx.ERR, "resp http status err, status", res.status, " reason:", res.reason)
        return
    end

    local body = res:read_body()
    ngx.log(ngx.DEBUG, "resp body:", body)

    return body
end

-- 将payload上报falcon
function M:report(payload)
    local req = {
        method = "POST",
        path = "/v1/push",
        body = cjson.encode(payload)
    }

    local resp = self:send(req)

    return resp
end


return M
