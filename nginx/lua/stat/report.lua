-- -*- coding:utf-8 -*-
--- 上报统计结果到 falcon.
-- @module report

local cjson = require("cjson.safe")
local upstream_cfg = require("conf.upstream")
local falcon = require ("falcon.falcon")
local FALCON = require ("upstream.falcon")

--- 上报 nginx 共享字典中的数据
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
