-- -*- coding:utf-8 -*-
--- 缓存实例.
-- 使用具体的技术（redis，memcache 等）实现一个缓存实例。
-- @classmod example_cache
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local class = require("pl.class")

local redis_helper = require("cache.redis_helper")

local M = class(redis_helper)

--- 示例程序.
-- 获取 example_cache 相关信息。
function M:get_info()
    local info, err = self.red:info()
    if not info then
       ngx.log(ngx.ERR, "failed to get info: ", err)
        return
    end
    ngx.log(ngx.DEBUG, "info:", info)

    return info
end

-- 添加业务代码 ---------------------------------------------------------------


return M
