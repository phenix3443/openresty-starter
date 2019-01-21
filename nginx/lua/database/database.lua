-- -*- coding:utf-8 -*-
--- 数据库接口.
-- @module database

local cjson = require("cjson.safe")

local conf = require("conf.config")
local ExampleDB = require("database.example_db")

local M = {}


--- 示例程序
-- 获取 example_db 版本信息
function M.get_example_db_version()
    local example_db = ExampleDB(conf.example_db)
    if not example_db:is_connected() then
        return
    end
    local version = example_db:get_mysql_version()

    example_db:close()

    ngx.log(ngx.DEBUG, "mysql version:", version)
end

-- 下面自行编写业务代码 -------------------------------------------------------


return M
