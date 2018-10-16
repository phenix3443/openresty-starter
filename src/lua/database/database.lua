-- -*- coding:utf-8 -*-
-- 数据库接口
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")

local example_db_cfg = require("conf.example_db")
local ExampleDB = require("database.example_db")

local M = {}

function M.get_example_db_version()
    local example_db = ExampleDB(example_db_cfg.connect_info)
    if not example_db:is_connected() then
        return
    end
    local version = example_db:get_mysql_version()

    example_db:close()

    ngx.log(ngx.DEBUG, "mysql version:", version)
end

-- 下面自行编写业务代码 -------------------------------------------------------


return M
