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

function M.send_resp(status,body)
    ngx.status = status
    ngx.headers["content-type"] = "text/json"
    if body then
        ngx.log(ngx.INFO, body)
        ngx.print(body)
    end
    ngx.exit(ngx.HTTP_OK)
end

return M
