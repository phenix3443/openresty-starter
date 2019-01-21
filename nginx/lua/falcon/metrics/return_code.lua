-- -*- coding:utf-8; -*-
--- 统计接口返回码.
-- @module metrics.return_code
-- @author:phenix3443@gmail.com

local stringx = require("pl.stringx")

local cfg = require("conf.common")

local M = {}

--- 统计点名称
M.metric = "ret_code"

--- 生成 return_code 对应的 shm_key
-- shm_key=request:domain:url:ret_code
-- @param domain 统计点对应的域名
-- @param url 统计点对应的 url
-- @param ret_code 返回的错误码
function M.gen_shm_key(domain, url, ret_code)
    local shm_key = string.format("%s:%s:%s:%s", M.metric, domain, url, ret_code)
    ngx.log(ngx.DEBUG, "shm_key=", shm_key)
    return shm_key
end

--- 根据 shm_key 解析对应 falcon 信息
-- @param shm_key nginx 共享字典中的 key
-- @treturn {} 返回 falcon 上报的 item
function M.get_falcon_info(shm_key)
    local arr = stringx.split(shm_key,":")
    local item = {
        metric = M.metric,
        step = 60,
        tags = string.format("project=%s,domain=%s,url=%s,ret_code=%s", cfg.project, arr[2], ngx.unescape_uri(arr[3]), arr[4]),
        counterType = "COUNTER"
        -- counterType = "GAUGE"
    }

    return item
end

return M
