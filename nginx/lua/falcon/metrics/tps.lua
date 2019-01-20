-- -*- coding:utf-8; -*-

-------------------------------------------------------------------------------
-- tps(task per second) shm key module
-- @module tps


local stringx = require("pl.stringx")

local cfg = require("conf.config")

local M = {
    metric = "tps"
}

-- 生成 shm_key，必备
-- shm_key=tps:domain:url
function M.gen_shm_key(domain, url)
    local shm_key = string.format("%s:%s:%s", M.metric, domain, url)
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end

-- 根据 shm_key 获取上报 falcon 的信息，必备
function M.get_falcon_info(shm_key)
    local arr = stringx.split(shm_key,":")
    local item = {
        metric = M.metric,
        step = 60,
        tags = string.format("project=%s,domain=%s,url=%s", cfg.project, arr[2], ngx.unescape_uri(arr[3])),
        counterType = "COUNTER"
    }

    return item
end

return M
