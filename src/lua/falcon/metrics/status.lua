-- -*- coding:utf-8; -*-
--- http status parser
-- @author:phenix3443+github@gmail.com

local stringx = require("pl.stringx")

local cfg = require("conf.config")

local M = {
    metric = "status"
}

-- shm_key=status:domain:url:status_code
function M.gen_shm_key(domain, url, status)
    local shm_key = string.format("%s:%s:%s:%s", M.metric, domain, url, status)
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end

-- 根据shm_key获取上报falcon的信息，必备
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
