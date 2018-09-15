-- -*- coding:utf-8 -*-
-- 示例db配置
-- @author:liushangliang@xunlei.com


local M = {}

M.connect_info = {              -- main_db表示虚拟的数据库
    host = "127.0.0.1",
    port = 3306,
    database = "test",
    user = "root",
    password = "",
    charset = "utf8",
}


return M
