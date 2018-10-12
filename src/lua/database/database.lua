-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc:数据库接口
local cjson = require("cjson.safe")

local example_db_cfg = require("conf.example_db")
local ExampleDB = require("database.example_db")

local export = {}

-- example_db
function export.get_example_db_version()
    local example_db = ExampleDB(example_db_cfg.connect_info)
    if not example_db then
        return
    end
    local version = example_db:get_db_version()
    example_db:close()
    return version
end

return export
