-- -*- coding:utf-8 -*-
--- 接口统计代码
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")
local upstream_cfg = require("conf.upstream")
local falcon = require ("stat.falcon")
local FALCON = require ("upstream.falcon")

-- 将shm_dict中的数据上报falcon
local function report()
    local payload = falcon.gen_payload_from_shm()
    if #payload < 1 then
        ngx.log(ngx.WARN, "empty payload")
        return
    end

    local f = FALCON(upstream_cfg.falcon)
    local resp = f:report(payload)
    ngx.say(cjson.encode(resp))
end

report()
