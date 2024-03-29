-- -*- coding:utf-8 -*-
--- falcon http 接口封装.
-- doc: http://book.open-falcon.org/zh_0_2/usage/data-push.html
-- @classmod FALCON
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local class = require("pl.class")
local http = require("resty.http")

local shm = require("misc.shm")
local status = require("falcon.metrics.status")

local http_helper = require("upstream.http_helper")

local M = class(http_helper)

--- 发送请求
-- @param path 请求路径
-- @param params 参数
function M:send(path, params)
    ngx.log(ngx.DEBUG, "path:", path, ",params", cjson.encode(params))
    local httpc = http.new()
    local res, err = httpc:request_uri(self.uri .. path, params)
    if not res then
        ngx.log(ngx.ERR, "failed to get resp:", err)
        return
    end

    -- 统计 http 状态码
    local shm_key = status.gen_shm_key(self.host, path, res.status)
    shm.incr_value(shm_key)

    if res.status ~= ngx.HTTP_OK then
        ngx.log(ngx.ERR, "resp http status err, status", res.status, " reason:", res.reason)
        return
    end

    ngx.log(ngx.DEBUG, "resp body:", res.body)

    local body = res.body
    return body
end

--- 将 payload 上报 falcon
-- @param payload 上报 falcon 的数据
-- @return 返回 falcon 接口响应
function M:report(payload)
    local params = {
        ssl_verify = false,
        method = "POST",
        query = {},
        headers = {
            Host = self.host
        },
        body = cjson.encode(payload)
    }

    local resp = self:send("/v1/push", params)

    return resp
end

return M
