-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc:缓存
local cjson = require("cjson.safe")
local redis_helper = require("cache.redis_helper")

local export = {}
local mt = {__index = redis_helper}

function export.get_info(self)
    local info, err = self.red:info()
    if not info then
       ngx.log(ngx.ERR, "failed to get info: ", err)
        return
    end
    ngx.log(ngx.DEBUG, "info:", info)

    return info
end

-- 添加业务代码

return export
