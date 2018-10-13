-- -*- coding:utf-8; -*-
--- qps(query per second) shm key module
-- @author:phenix3443+github@gmail.com

local stringx = require("pl.stringx")

local M = {
    metric = "qps"
}

-- 生成shm_key，必备
-- shm_key=qps:url
function M.gen_shm_key()
    local shm_key = string.format("%s:%s", M.metric, ngx.escape_uri(ngx.var.uri))
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end

-- 修改shm_key对应的value，必备
function M.change_value(shm_key, value)
    local dict = ngx.shared["falcon"]
    if ngx.config.ngx_lua_version < 10006 then
        ngx.log(ngx.ERR, "ngx_lua_version too low")
    else
        local newval, err, forcible = dict:incr(shm_key, value, 0)
        local log_msg = string.format("new value for %s = %s", shm_key, newval)
        ngx.log(ngx.DEBUG, log_msg)
    end
end

-- 根据shm_key获取上报falcon的信息，必备
function M.get_falcon_info(shm_key)
    local counter_type = "COUNTER"
    local arr = stringx.split(shm_key,":")
    if #arr < 1 then
        ngx.log(ngx.ERR, "invalid shm_key,", shm_key)
        return
    end
    local metric = arr[1]
    local tags = {
        domain = ngx.var.server_name,
        url = ngx.unescape_uri(arr[2])
    }
    return metric, counter_type, tags
end


return M
