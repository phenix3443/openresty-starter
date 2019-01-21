-- -*- coding:utf-8; -*-
--- 统计接口 request_time.
-- @module metrics.request_time
-- @author:phenix3443@gmail.com

local stringx = require("pl.stringx")

local cfg = require("conf.config")

local M = {}

--- 统计点名称
M.metric = "request_time"

--- 生成 request_time 对应的 shm_key
-- shm_key=request_time:domain:url:request_time
-- @param domain 统计点对应的域名
-- @param url 统计点对应的 url
-- @param request_time 响应时间
function M.gen_shm_key(domain, url, request_time)
    local interval = 50 --milliseconds
    -- 如果 time_range = 50 表示 0-50ms 以内，100 表示 50-100ms
    ngx.log(ngx.DEBUG, "request_time", request_time)
    local time_range = math.ceil(request_time/interval) * interval
    local shm_key = string.format("%s:%s:%s:%s", M.metric, domain, url, time_range)
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
        tags = string.format("project=%s,domain=%s,url=%s,cost=%d", cfg.project, arr[2], ngx.unescape_uri(arr[3]), arr[4]),
        counterType = "COUNTER"
    }

    return item
end

return M
