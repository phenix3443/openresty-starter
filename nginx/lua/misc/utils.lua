-- -*- coding:utf-8 -*-
--- 通用工具函数.
-- @module utils
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")

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

--- 将 table 中 key，value 转变为 pos 连接字符串
-- 若 pos 是 & ，最后返回 key1=value1&key2=value2...
-- @param t 待处理的 table
-- @param pos 连接字符
-- @treturn string
function M.concat_kv(t, pos)
    local f = function(k,v) return string.format("%s=%s", k, v) end
    local t = tablex.pairmap(f, t)
    local str = table.concat(t, pos)
    ngx.log(ngx.DEBUG, "concated str:", str)
    return str
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
