-- -*- coding:utf-8; -*-
--- 示例 metric mod
-- @author:liushangliang@xunlei.com

local stringx = require("pl.stringx")

local M = {
    metric = "example"
}

-- 生成shm_key，必备
-- shm_key=status:url:status_code
-- todo:
function M.gen_shm_key()
    local shm_key = string.format("%s:%s:%s", M.metric, ngx.escape_uri(ngx.var.uri), ngx.var.status)
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end

-- 根据shm_key获取上报falcon的信息，必备
function M.get_falcon_info(shm_key)
    local arr = stringx.split(shm_key,":")
    local item = {
        metric = M.metric,
        step = 60,
        tags = string.format("domain=%s,url=%s,cost=%d", ngx.var.server_name, ngx.unescape_uri(arr[2]), arr[3]),
        counterType = "COUNTER"
        -- counterType = "GAUGE"
    }

    return item
end

return M
