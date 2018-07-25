-- -*- coding:utf-8; -*-
-- author:liushangliang
-- desc: qps(query per second) shm key module
-- 该模块需要在falcon/init中注册

local stringx = require("pl.stringx")

local export = {
    metric = "qps"
}

-- 生成shm_key，必备
-- shm_key=qps:url
function export.gen_shm_key()
    local shm_key = string.format("%s:%s", export.metric, ngx.escape_uri(ngx.var.uri))
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
        local log_msg = string.format("new value for %s = %s", shm_key, newval)
        ngx.log(ngx.DEBUG, log_msg)
    end
end

-- 根据shm_key获取上报falcon的信息，必备
function export.get_falcon_info(shm_key)
    local counter_type = "COUNTER"
    local arr = stringx.split(shm_key,":")
    local tags = {
        domain = ngx.var.server_name,
        url = ngx.unescape_uri(arr[2])
    }
    return counter_type, tags
end


return export
