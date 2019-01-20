-- -*- coding:utf-8; -*-

-------------------------------------------------------------------------------
--- http request_time parser
-- @module request_time

local stringx = require("pl.stringx")

local cfg = require("conf.config")

local M = {
    metric = "request_time"
}

-- 生成 shm_key，必备
-- shm_key=request_time:domain:url:request_time
function M.gen_shm_key(domain, url, request_time)
    local interval = 50 --milliseconds
    -- 如果 time_range = 50 表示 0-50ms 以内，100 表示 50-100ms
    ngx.log(ngx.DEBUG, "request_time", request_time)
    local time_range = math.ceil(request_time/interval) * interval
    local shm_key = string.format("%s:%s:%s:%s", M.metric, domain, url, time_range)
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end

-- 根据 shm_key 获取上报 falcon 的信息，必备
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
