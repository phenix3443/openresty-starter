-- -*- coding:utf-8 -*-
--- nginx 通用工具函数.
-- @module ngx_utils
-- @author:liushangliang@xunlei.com
local cjson = require("cjson.safe")
local stringx = require("pl.stringx")

local err_def = require("conf.err_def")
local shm = require ("misc.shm")
local retcode = require("falcon.metrics.return_code")

local M = {}

--- 获取真实的客户端 IP
function M.get_client_ip()
    local hd = ngx.req.get_headers()
    local client_ip = ngx.var.remote_addr
    local forward = hd.x_forwarded_for
    if forward then
        local ips = stringx.split(forward, ",")
        if #ips > 0 then
            client_ip = stringx.strip(ips[1])
        end
    end
    ngx.log(ngx.DEBUG, "client_ip:", client_ip)
    return client_ip
end

--- 返回响应
-- @param code 错误码
-- @param data 响应数据
function M.send_resp(status, code, msg, data)
    ngx.status = status
    ngx.header["Content-Type"] = "application/json"

    local domain = ngx.var.server_name
    local url = ngx.escape_uri(ngx.var.uri)
    local shm_key = retcode.gen_shm_key(domain, url, code)
    shm.incr_value(shm_key)

    local resp  = {
        code = code,
        msg = msg or err_def.msg[code],
        data = data
    }

    local client_resp = cjson.encode(resp)
    ngx.print(client_resp)
    ngx.exit(ngx.HTTP_OK)
end

return M
