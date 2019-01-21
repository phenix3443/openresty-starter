-- -*- coding:utf-8; -*-
--- 已经注册的 metrics.
-- @module metrics

local M = {}

--- 开启的 metrics.
-- 所有开启的统计点（metric）以及对应的处理模块都应该在此处注册。
M.mods = {
    qps = require("falcon.metrics.qps"), -- qps
    tps = require("falcon.metrics.tps"), -- tps
    status = require("falcon.metrics.status"), -- http 状态码
    request_time = require("falcon.metrics.request_time"), -- 响应时间
    ret_code = require("falcon.metrics.return_code")       -- 返回码
}

return M
