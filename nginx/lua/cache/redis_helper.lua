-- -*- coding:utf-8 -*-
--- redis 辅助函数.
-- 使用 pl.class 简单封装了 redis 数据库的连接和释放
-- @classmod redis_helper
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local redis = require("resty.redis")
local class = require("pl.class")

local M = class()

--- redis 数据库初始化函数
-- 与 redis 实例建立连接，该函数不需要手动调用。
-- @param redis_cfg 包含了 redis 数据库的连接信息：host，port，db，password.
function M:_init(redis_cfg)
    local red, err = redis:new()
    if not red then
        ngx.log(ngx.ERR,"failed to instantiate redis: ", err)
        return
    end

    local ok
    ok, err = red:connect(redis_cfg.host, redis_cfg.port)

    if not ok then
        ngx.log(ngx.ERR,"failed to connect: ", redis_cfg.name, " err:",err)
        return
    end

    if redis_cfg.password then
        ok, err = red:auth(redis_cfg.password)
        if not ok then
            ngx.log(ngx.ERR,"failed to auth: ", err)
            return
        end
    end

    local db = redis_cfg.database or 0
    ok, err = red:select(db)
    if not ok then
        ngx.log(ngx.ERR,"failed to select database: ", err)
        return
    end

    ngx.log(ngx.DEBUG,"connected to redis.")

    self.red = red
end

--- 判断 redis 实例连接是否建立成功
-- @return 如果成功，返回 redis 的连接对象。
function M:is_connected()
    return self.red
end

--- 关闭 redis 连接
-- 此处使用 keepalive 进行高可用。
function M:close()
    local ok, err = self.red:set_keepalive(10000, 100)
    if not ok then
        ngx.log(ngx.ERR, "failed to set keepalive: ", err)
        return
    end
end

return M
