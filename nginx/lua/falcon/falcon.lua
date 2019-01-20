-- -*- coding:utf-8; -*-

-------------------------------------------------------------------------------
-- falocn 接口封装
-- doc: http://book.open-falcon.org/zh_0_2/usage/data-push.html
-- @module falcon


local cjson = require("cjson.safe")
local stringx = require("pl.stringx")
local metrics = require("falcon.metrics")

local M = {}

local function get_host_name()
    local f = io.popen ("/bin/hostname")
    local hostname = f:read("*a") or ""
    f:close()
    hostname =string.gsub(hostname, "\n$", "")
    return hostname
end

function M.get_mod(shm_key)
    local arr = stringx.split(shm_key, ":")
    if #arr < 1 then
        ngx.log(ngx.ERR, "invalid shm_key,", shm_key)
        return
    end

    local metric = arr[1]
    local mod = metrics.mods[metric]
    if not mod then
        ngx.log(ngx.ERR, "invalid mod,", shm_key)
        return
    end

    return mod
end

function M.incr_value(shm_key)
    local dict = ngx.shared["falcon"]
    if ngx.config.ngx_lua_version < 10006 then
        ngx.log(ngx.ERR, "ngx_lua_version too low")
    else
        local newval, err, forcible = dict:incr(shm_key, 1, 0)
        local log_msg = string.format("new value for %s = %s", shm_key, newval)
        ngx.log(ngx.DEBUG, log_msg)
    end
end

local host_name = get_host_name()
-- 生成 shm_key 对应的 falcon item
function M.gen_item(shm_key, value)
    local mod = M.get_mod(shm_key)
    local item = mod.get_falcon_info(shm_key)
    item.endpoint = host_name
    item.timestamp = ngx.time()
    item.value = value

    ngx.log(ngx.DEBUG, "shm_key=", shm_key,"value=",value,",item=", cjson.encode(item))
    return item
end

-- 从 shm_dict 生成此次上报的 payload
function M.gen_payload_from_shm()
    local payload = {}
    local dict = ngx.shared["falcon"]
    local keys = dict:get_keys()
    ngx.log(ngx.DEBUG,"all shm keys:", cjson.encode(keys))
    for i,key in pairs(keys) do
        local value = dict:get(key)
        local item = M.gen_item(key, value)
        if item then
            table.insert(payload, item)
        end
    end
    ngx.log(ngx.DEBUG, "payload from shm:",cjson.encode(payload))
    return payload
end

return M
