-- -*- coding:utf-8 -*-
--- 接口统计代码
-- @author:phenix3443+github@gmail.com

local falcon_config = require ("config.falcon")
local falcon = require ("falcon.falcon")

-- 将shm_dict中的数据上报falcon
local function interface_static_for_falcon()
    -- static qps,tps
    for _, metric in pairs({"qps","tps",'status','request_time'}) do
        local mod = falcon.get_metric_handler(metric)
        if mod then
            local shm_key = mod.gen_shm_key(metric)
            falcon.store_stat_record(falcon_config.shm_name, shm_key, 1)
        end
    end
end

interface_static_for_falcon()
