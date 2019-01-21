-- -*- coding:utf-8; -*-
--- 统计接口 http status.
-- @module status

local stringx = require("pl.stringx")

local cfg = require("conf.config")

local M = {}

--- 统计点名称
M.metric = "status"

--- 生成 status 对应的 shm_key
-- shm_key=status:domain:url:status_code
-- @param domain 统计点对应的域名
-- @param url 统计点对应的 url
-- @param status 响应状态码
function M.gen_shm_key(domain, url, status)
    local shm_key = string.format("%s:%s:%s:%s", M.metric, domain, url, status)
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end


--- 根据 shm_key 解析对应 falcon 信息
-- @param shm_key nginx 共享字典中的 key
-- @treturn {} 返回 falcon 上报的 item
function M.get_falcon_info(shm_key)
    local arr = stringx.split(shm_key,":")
    local item = {
        metric = M.metric,
        step = 60,
        tags = string.format("project=%s,domain=%s,url=%s,code=%s", cfg.project, arr[2], ngx.unescape_uri(arr[3]), arr[4]),
        counterType = "COUNTER"
    }

    return item
end

return M
