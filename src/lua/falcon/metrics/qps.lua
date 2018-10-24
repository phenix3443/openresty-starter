-- -*- coding:utf-8; -*-
--- qps(query per second) shm key module
-- @author:liushangliang@xunlei.com

local stringx = require("pl.stringx")

local M = {
    metric = "qps"
}

-- 生成shm_key，必备
-- shm_key=qps:domain:url
function M.gen_shm_key(domain, url)
    local shm_key = string.format("%s:%s:%s", M.metric, domain, url)
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end


-- 根据shm_key获取上报falcon的信息，必备
function M.get_falcon_info(shm_key)
    local arr = stringx.split(shm_key,":")
    local item = {
        metric = M.metric,
        step = 60,
        tags = string.format("domain=%s,url=%s", arr[2], ngx.unescape_uri(arr[3])),
        counterType = "COUNTER"
    }

    return item
end


return M
