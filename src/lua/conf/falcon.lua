-- -*- coding:utf-8 -*-
--- 该文件写明falcon采集上报相关配置
-- @author:phenix3443@gmail.com

local M = {}

M.default_step= 60          -- in second
M.shm_name = "falcon"
M.metric_handlers = { -- 在此处添加新的统计模块
    qps = require("falcon.metrics.qps"),
    tps = require("falcon.metrics.tps"),
    status = require("falcon.metrics.status"),
    request_time = require("falcon.metrics.request_time"),
}

return M
