-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc: 该文件写明falcon采集上报相关配置

local export = {}

export.default_step= 60          -- in second
export.shm_name = "falcon"
export.metric_handlers = { -- 在此处添加新的统计模块
    qps = require("falcon/metrics/qps"),
    tps = require("falcon/metrics/tps"),
    status = require("falcon/metrics/status"),
    request_time = require("falcon/metrics/request_time"),
}

return export
