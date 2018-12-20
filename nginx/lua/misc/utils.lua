-- -*- coding:utf-8 -*-
--- 通用工具函数
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")

local M = {}

-- 获取真实的客户端IP
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

function M.concat_k_v(t, pos)
    local f = function(k,v) return string.format("%s=%s", k, v) end
    local t = tablex.pairmap(f, t)
    local str = table.concat(t, pos)
    ngx.log(ngx.DEBUG, "concated str:", str)
    return str
end

function M.send_err_resp(status,body)
    ngx.status = status
    if body then
        ngx.print(body)
    end
    ngx.exit(ngx.HTTP_OK)
end

function M.send_resp(status, body)
    ngx.status = status
    if body then
        local domain = ngx.var.server_name
        local url = ngx.escape_uri(ngx.var.uri)
        local shm_key = retcode.gen_shm_key(domain, url, body.iRet)
        falcon.incr_value(shm_key)

        ngx.header["content-type"] = "text/json"
        local client_resp = cjson.encode(body)
        ngx.log(ngx.INFO, client_resp)
        ngx.print(client_resp)
    end

    ngx.exit(ngx.HTTP_OK)
end

return M
