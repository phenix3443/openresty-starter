-- -*- coding:utf-8; -*-
-- author:liushangliang@xunlei.com
-- desc: tps(task per second) shm key module

local stringx = require("pl.stringx")

local M = {
    metric = "tps"
}

-- 生成shm_key，必备
-- shm_key=tps:url
function M.gen_shm_key()
    local shm_key = string.format("%s:%s", M.metric, ngx.escape_uri(ngx.var.uri))
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end

-- 根据shm_key获取上报falcon的信息，必备
function M.get_falcon_info(shm_key)
    local arr = stringx.split(shm_key,":")
    local item = {
        metric = M.metric,
        step = 60,
        tags = string.format("domain=%s,url=%s", ngx.var.server_name, ngx.unescape_uri(arr[2])),
        counterType = "COUNTER"
    }

    return item
end

return M
