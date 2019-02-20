-- -*- coding:utf-8 -*-
--- nginx 通用工具函数.
-- @module ngx_utils
-- @author:liushangliang@xunlei.com
local cjson = require("cjson.safe")

local err_def = require("conf.err_def")
local shm = require ("misc.shm")
local retcode = require("falcon.metrics.return_code")

local M = {}

--- 获取真实的客户端 IP
function M.get_client_ip()
    local headers = ngx.req.get_headers()
    local client_ip = ngx.var.remote_addr
    if headers.x_real_ip then
        ngx.log(ngx.DEBUG, "来自转发")
        client_ip = headers.x_real_ip
    end
    ngx.log(ngx.DEBUG, "client_ip:", client_ip)
    return client_ip
end

--- 返回响应
-- @param code 错误码
-- @param data 响应数据
function M.send_resp(status, code, data)
    ngx.status = status
    ngx.header["Content-Type"] = "application/json"

    local domain = ngx.var.server_name
    local url = ngx.escape_uri(ngx.var.uri)
    local shm_key = retcode.gen_shm_key(domain, url, code)
    shm.incr_value(shm_key)

    local resp  = {
        code = code,
        msg = err_def.msg[code],
        data = data
    }

    local client_resp = cjson.encode(resp)
    ngx.log(ngx.INFO, "resp:", client_resp)
    ngx.print(client_resp)

    ngx.exit(ngx.HTTP_OK)
end

return M
