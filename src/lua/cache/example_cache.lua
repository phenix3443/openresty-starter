-- -*- coding:utf-8 -*-
-- 缓存示例程序
-- @author:liushangliang@xunlei.com

local cjson = require("cjson.safe")
local class = require("pl.class")

local redis_helper = require("cache.redis_helper")


local M = class(redis_helper)

function M.get_info(self)
    local info, err = self.red:info()
    if not info then
       ngx.log(ngx.ERR, "failed to get info: ", err)
        return
    end
    ngx.log(ngx.DEBUG, "info:", info)

    return info
end

-- 添加业务代码

return M
