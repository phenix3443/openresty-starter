-- -*- coding:utf-8 -*-
--- 数据库接口.
-- @module database
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")

local cfg = require("conf.common")
local ucfg = require("conf.upstream")
local ExampleDB = require("database.example")

local M = {}

--- 示例程序
-- 获取 example_db 版本信息
function M.get_db_version()
    local db = ExampleDB(ucfg.db)
    local version = db:get_mysql_version()
    db:close()
    ngx.log(ngx.DEBUG, "mysql version:", version)
end


-- 下面自行编写业务代码 -------------------------------------------------------


return M
