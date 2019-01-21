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
function M.concat_k_v(t, pos)
    local f = function(k,v) return string.format("%s=%s", k, v) end
    local t = tablex.pairmap(f, t)
    local str = table.concat(t, pos)
    ngx.log(ngx.DEBUG, "concated str:", str)
    return str
end

--- 针对 http 错误返回响应
-- @tparam number status http 标准状态码
-- @tparam string body 返回的响应 body
function M.send_err_resp(status,body)
    ngx.status = status
    if body then
        ngx.print(body)
    end
    ngx.exit(ngx.HTTP_OK)
end

--- 返回正常请求
-- 这种情况下，响应的 http_status=200
-- @param code 错误码
-- @param data 响应数据
function M.send_resp(code, data)
    ngx.status = ngx.HTTP_OK
    ngx.header["Content-Type"] = "application/json"

    local domain = ngx.var.server_name
    local url = ngx.escape_uri(ngx.var.uri)
    local shm_key = retcode.gen_shm_key(domain, url, code)
    shm.incr_value(shm_key)

    local resp  = {}
    resp.iRet = code
    resp.sMsg = err_def.msg[code]
    resp.data = data

    local client_resp = cjson.encode(resp)
    ngx.log(ngx.INFO, "resp:", client_resp)
    ngx.print(client_resp)
    ngx.exit(ngx.HTTP_OK)
end

return M
