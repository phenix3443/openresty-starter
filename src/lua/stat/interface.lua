-- -*- coding:utf-8 -*-
-- @author:phenix3443+github@gmail.com
-- 接口统计代码

local falcon = require ("stat.falcon")

-- 将shm_dict中的数据上报falcon
falcon.stat_all_metrics()
