-- -*- coding:utf-8 -*-
-- 示例db配置
-- @author:phenix3443+github@gmail.com

local rt = require("conf.runtime")

local M = {}

if rt.mode == "develop" then
    M.connect_info = {              -- main_db表示虚拟的数据库
        host = "127.0.0.1",
        port = 3306,
        database = "test",
        user = "root",
        password = "",
        charset = "utf8",
    }
elseif rt.mode == "pre-release" then
    M.connect_info = {              -- main_db表示虚拟的数据库
        host = "127.0.0.1",
        port = 3306,
        database = "test",
        user = "root",
        password = "",
        charset = "utf8",
    }
elseif rt.mode == "release" then
    M.connect_info = {              -- main_db表示虚拟的数据库
        host = "127.0.0.1",
        port = 3306,
        database = "test",
        user = "root",
        password = "",
        charset = "utf8",
    }
end

return M
