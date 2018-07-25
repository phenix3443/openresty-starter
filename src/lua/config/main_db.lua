-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- 记录所用缓存的配置，
-- 该文件应该以缓存名字，例如db_name.lua

local export = {}

export.connect_info = {              -- main_db表示虚拟的数据库
    host = "127.0.0.1",
    port = 3306,
    database = "test",
    user = "root",
    password = "",
    charset = "utf8",
}


return export
