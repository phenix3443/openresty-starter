-- -*- coding:utf-8; -*-
-- @author:phenix3443+github@gmail.com
-- desc:
local M = {}

M.mods = {
    qps = require("falcon.metrics.qps"),
    tps = require("falcon.metrics.tps"),
    status = require("falcon.metrics.status"),
    request_time = require("falcon.metrics.request_time"),
    ret_code = require("falcon.metrics.return_code")
}

return M
