-- -*- coding:utf-8 -*-
--- 对外接口代码示例
-- @author:liushangliang@xunlei.com

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

    local resp = M:send(req)

    return resp
end

return M
