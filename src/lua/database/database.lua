-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc:数据库接口
local cjson = require("cjson.safe")

local main_db_cfg = require("config/main_db")
local MainDB = require("database/main_db")

local export = {}

-- main_db
function export.get_main_db_version()
    local main_db = MainDB.new(main_db_cfg.connect_info)
    if not main_db then
        return
    end
    local version = main_db:get_db_version()
    main_db:close()
    return version
end

return export
