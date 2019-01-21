-- -*- coding:utf-8; -*-
--- 已经注册的 metrics.
-- @module metrics

local M = {}

M.mods = {
    qps = require("falcon.metrics.qps"),
    tps = require("falcon.metrics.tps"),
    status = require("falcon.metrics.status"),
    request_time = require("falcon.metrics.request_time"),
    ret_code = require("falcon.metrics.return_code")
}

return M
