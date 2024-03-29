-- -*- coding:utf-8 -*-
--- nginx 通用工具函数.
-- @module ngx_utils
-- @author:phenix3443+github@gmail.com
local cjson = require("cjson.safe")
local stringx = require("pl.stringx")

local M = {}

--- 获取真实的客户端 IP
function M.get_client_ip()
    local hd = ngx.req.get_headers()
    ngx.log(
        ngx.DEBUG,
        "remote_ip=",
        ngx.var.remote_addr,
        ",real_ip=",
        hd.x_real_ip,
        ",x-forward-ip=",
        hd.x_forwarded_for
    )

    local client_ip = ngx.var.remote_addr

    if hd.x_forwarded_for then
        -- 查看转发地址
        local ips = stringx.split(hd.x_forwarded_for, ",")
        if #ips > 0 then
            client_ip = stringx.strip(ips[1])
        end
    else
        -- 查看前段代理设置的 x-real-ip
        if hd.x_real_ip then
            client_ip = hd.x_real_ip
        end
    end

    return client_ip
end

--- 返回响应
-- @param code 错误码
-- @param data 响应数据
function M.send_resp(status, resp)
    ngx.status = status
    ngx.header["Content-Type"] = "application/json"
    ngx.print(client_resp)
    ngx.exit(status)
end

return M
