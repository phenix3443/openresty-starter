-- -*- coding:utf-8; -*-
-- author:liushangliang
-- desc: http request_time parser

local stringx = require("pl.stringx")

local export = {
    metric = "request_time"
}

-- 生成shm_key，必备
-- shm_key=qps:url:request_time
function export.gen_shm_key()
    local interval = 50 --milliseconds
    -- 如果time_range = 50表示0-50ms以内， 100 表示 50-100ms
    ngx.log(ngx.DEBUG, "request_time", ngx.var.request_time)
    local time_range = math.ceil(ngx.var.request_time/interval) * interval
    local shm_key = string.format("%s:%s:%s", export.metric, ngx.escape_uri(ngx.var.uri), time_range)
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end

-- 修改shm_key对应的value，必备
function export.change_value(shm_name, shm_key, value)
    local dict = ngx.shared[shm_name]
    if ngx.config.ngx_lua_version < 10006 then
        ngx.log(ngx.ERR, "ngx_lua_version too low")
    else
        local newval, err, forcible = dict:incr(shm_key, value, 0)
        local log_msg = string.format("new value for %s=%s", shm_key, newval)
        ngx.log(ngx.DEBUG, log_msg)
    end
end

-- 根据shm_key获取上报falcon的信息，必备
function export.get_falcon_info(shm_key)
    local counter_type = "COUNTER"
    local arr = stringx.split(shm_key,":")
    local tags = {
        domain = ngx.var.server_name,
        url = ngx.unescape_uri(arr[2]),
        cost = tonumber(arr[3])
    }
    return counter_type, tags
end

return export
