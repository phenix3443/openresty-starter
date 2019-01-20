-- -*- coding:utf-8 -*-

-------------------------------------------------------------------------------
-- 接口统计代码
-- @module stat


local falcon = require ("falcon.falcon")
local qps = require("falcon.metrics.qps")
local tps = require("falcon.metrics.tps")
local status = require("falcon.metrics.status")
local request_time = require("falcon.metrics.request_time")

-- 将 shm_dict 中的数据上报 falcon
local function stat_interface_metrics()
    local domain = ngx.var.server_name
    local url = ngx.escape_uri(ngx.var.uri)
    local status_code = ngx.var.status
    local req_time = ngx.var.request_time
    -- qps
    local shm_key = qps.gen_shm_key(domain, url)
    falcon.incr_value(shm_key)

    -- tps
    shm_key = tps.gen_shm_key(domain, url)
    falcon.incr_value(shm_key)

    -- status
    shm_key = status.gen_shm_key(domain, url, status_code)
    falcon.incr_value(shm_key)

    -- request_time
    shm_key = request_time.gen_shm_key(domain, url, req_time)
    falcon.incr_value(shm_key)

end

stat_interface_metrics()
