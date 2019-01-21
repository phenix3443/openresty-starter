-- -*- coding:utf-8 -*-
--- mysql 辅助函数.
-- 使用 pl.class 封装了 mysql 数据库的连接和释放。
-- @classmod mysql_helper

local cjson = require("cjson.safe")
local mysql = require("resty.mysql")
local class = require("pl.class")

local M = class()

--- mysql 实例初始化函数.
-- 与 mysql 数据库建立连接，该函数不需要手动调用。
-- @param db_cfg 包含 mysql 数据库的连接信息：
-- host，port，database，user，password
function M:_init(db_cfg)
    local db, err = mysql:new()
    if not db then
        ngx.log(ngx.ERR,"failed to instantiate mysql: ", err)
        return
    end

    local ok, err, errcode, sqlstate = db:connect(db_cfg)

    if not ok then
        ngx.log(ngx.ERR,"failed to connect: ",db_cfg.database," err:", err, " errcode:", errcode, " ", sqlstate)
        return
    end

    ngx.log(ngx.DEBUG,"connected to ", db_cfg.database)

    self.db = db
end

--- 判断 mysql 实例连接是否建立成功.
-- @return 如果成功，返回 mysql 的连接对象。
function M:is_connected()
    return self.db
end

--- 关闭 mysql 连接.
-- 此处使用 keepalive 进行高可用。
function M:close()
    local ok, err = self.db:set_keepalive(10000, 100)
    if not ok then
        ngx.log(ngx.ERR, "failed to set keepalive: ", err)
        return
    end
end

return M
