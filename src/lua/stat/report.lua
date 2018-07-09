-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- file: 接口统计代码

local falcon_config = require ("config/falcon/falcon")
local falcon = require ("falcon/falcon")

-- 将shm_dict中的数据上报falcon
local function report()
    local payload = falcon.gen_payload_from_shm(falcon_config.shm_name)
    if #payload < 1 then
        ngx.log(ngx.WARN, "empty payload")
        return
    end

    local resp = falcon.report(payload)
    if resp then
        ngx.log(ngx.DEBUG, resp.body)
    end
end

report()
