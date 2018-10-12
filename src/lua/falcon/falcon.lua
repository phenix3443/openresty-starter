-- -*- coding:utf-8; -*-
--- falcon接口
-- @author:liushangliang
-- doc: http://book.open-falcon.org/zh_0_2/usage/data-push.html

local cjson = require("cjson.safe")
local stringx = require("pl.stringx")
local falcon_cfg = require("config.falcon")

local M = {}

local function get_host_name()
    local f = io.popen ("/bin/hostname")
    local hostname = f:read("*a") or ""
    f:close()
    hostname =string.gsub(hostname, "\n$", "")
    return hostname
end

-- 检查metric handler是不是编写正确
local function check_metric_handler(metric, handler)
    if type(handler) ~= "table" then
        ngx.log(ngx.ERR, metric, " handler should be table")
        return
    end

    local must_method = {"gen_shm_key","change_value", "get_falcon_info"}

    for _, f in pairs(must_method) do
        local func = handler[f]
        if not(func and type(func) == "function") then
            ngx.log(ngx.ERR, metric, " handler has invalid function:", f)
            return
        end
    end

    return true
end

function M.get_metric_handler(metric)
    local handler = falcon_cfg.metric_handlers[metric]
    if not handler then
        ngx.log(ngx.ERR, "can not find handler for ", metric)
        return
    end
    return handler
end

-- shm_key = metric:...
local function get_metric_from_shm_key(shm_key)
    local arr = stringx.split(shm_key, ":")
    if #arr < 1 then
        ngx.log(ngx.ERR, "invalid shm_key,", shm_key)
        return
    end

    local metric = arr[1]
    ngx.log(ngx.DEBUG, shm_key, " metric is ", metric)
    return metric
end

-- 修改shm_name对应的值
function M.store_stat_record(shm_name, shm_key, value)
    local metric = get_metric_from_shm_key(shm_key)
    if not metric then
        return
    end

    local handler = M.get_metric_handler(metric)
    if not handler then
        return
    end

    handler.change_value(shm_name, shm_key, value)
end

-- shm_key = metric:counter_type:....
local function parse_shm_key(shm_key)
    local metric = get_metric_from_shm_key(shm_key)
    if not metric then
        return
    end

    local handler = M.get_metric_handler(metric)
    if not handler then
        return
    end

    local counter_type, tags = handler.get_falcon_info(shm_key)

    -- 检查counter有效性
    local valid_counter_type = {
        ["COUNTER"] = true,
        ["GAUGE"] = true
    }

    if not valid_counter_type[counter_type]  then
        ngx.log(ngx.ERR, "invalid counter type,shm_key=", shm_key,  " ,counter_type=", counter_type)
        return
    end

    return metric, counter_type, tags
end

local host_name = get_host_name()

-- 生成shm_key对应的falcon item
function M.gen_item(shm_key, value)
    local metric, counter_type, tags= parse_shm_key(shm_key)
    if not metric then
        return
    end

    local t = {}
    for k, v in pairs(tags) do
        table.insert(t, string.format("%s=%s",k,v))
    end
    local report_tags = table.concat(t,",")

    local item = {
        endpoint = host_name,
        metric = metric,
        timestamp = ngx.time(),
        step = falcon_cfg.default_step,
        tags = report_tags,
        value = value,
        counterType = counter_type
    }

    local log_msg = string.format("shm_key=%s, value=%s, item=%s", shm_key, value,cjson.encode(item))
    ngx.log(ngx.DEBUG, log_msg)
    return item
end

-- 从shm_dict生成此次上报的payload
function M.gen_payload_from_shm(shm_name)
    local payload = {}
    local dict = ngx.shared[shm_name]
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

-- 将payload上报falcon
function M.report(payload)
    local resp = ngx.location.capture("/falcon/v1/push",
                                      {
                                          method = ngx.HTTP_POST,
                                          body = cjson.encode(payload)
    })

    if not (resp and resp.status == ngx.HTTP_OK) then
        ngx.log(ngx.ERR, "falcon agent connect failed,status=", resp.status)
        return
    end
    return resp
end

local function init()
    for metric,handler in pairs(falcon_cfg.metric_handlers) do
        local ret = check_metric_handler(metric,handler)
        if not ret then
            ngx.log(ngx.ERR, metric, " handler has error")
        end
    end
end

init()

return M
