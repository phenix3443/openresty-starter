-- -*- coding:utf-8 -*-

-------------------------------------------------------------------------------
-- mysql 辅助函数
-- @module mysql_helper

local cjson = require("cjson.safe")
local mysql = require("resty.mysql")
local class = require("pl.class")

local M = class()

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

function M:is_connected()
    return self.db
end

function M:close()
    local ok, err = self.db:set_keepalive(10000, 100)
    if not ok then
        ngx.log(ngx.ERR, "failed to set keepalive: ", err)
        return
    end
end

return M
