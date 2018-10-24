-- -*- coding:utf-8 -*-
--- 对外接口代码示例
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")
local class = require("pl.class")

local http_helper = require("upstream.http_helper")
local falcon = require ("falcon.falcon")
local status = require("falcon.metrics.status")

local M = class(http_helper)

function M:send(req)
    ngx.log(ngx.INFO, "req:", cjson.encode(req))
    local res, err = self.httpc:request(req)
    if not res then
        ngx.log(ngx.ERR, "failed to get resp:", err)
        return
    end
    local shm_key = status.gen_shm_key(req.headers.Host, req.path, res.status)
    falcon.incr_value(shm_key)

    if res.status ~= ngx.HTTP_OK then
        ngx.log(ngx.ERR, "resp http status err, status", res.status, " reason:", res.reason)
        return
    end

    local body = res:read_body()
    ngx.log(ngx.INFO, "resp body:", body)

    local data = cjson.decode(body)
    if not data then
        ngx.log(ngx.WARN, "resp data json decode error")
        return
    end

    return data
end

-- 添加业务代码
function M:test()
    local req = {
        method = "POST",
        path = "/path",
        headers = {
            ["Content-Type"] = "application/json",
            ["Host"] = self.host,
        },
        body = ""
    }

    local resp = self:send(req)

    return resp
end

return M
