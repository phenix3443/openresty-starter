-- -*- coding:utf-8 -*-

-------------------------------------------------------------------------------
-- 依赖的外部应用访问地址。
-- @module upstream

local conf = require("conf.config")

local M = {}

if conf.mode == "develop" then
    M.falcon = {
        host = "falcon-agent.localhost",
        uri = "http://127.0.0.1:30976",
    }

    M.example_cache = {
        name = "",
        host = "127.0.0.1",
        port = 6379,
        database = 0,
        password = nil
    }

    M.example_db = {
        host = "127.0.0.1",
        port = 3306,
        database = "test",
        user = "root",
        password = "",
        charset = "utf8",
    }
elseif conf.mode == "pre-release" then

    M.falcon = {
        host = "falcon-agent.localhost",
        uri = "http://127.0.0.1:30976",
    }

    M.example_cache = {
        name = "",
        host = "127.0.0.1",
        port = 6379,
        database = 0,
        password = nil
    }

    M.example_db = {
        host = "127.0.0.1",
        port = 3306,
        database = "test",
        user = "root",
        password = "",
        charset = "utf8",
    }
elseif conf.mode == "release" then
    M.falcon = {
        host = "falcon-agent.localhost",
        uri = "http://127.0.0.1:30976",
    }

    M.example_cache = {
        name = "",
        host = "127.0.0.1",
        port = 6379,
        database = 0,
        password = nil
    }

    M.example_db = {
        host = "127.0.0.1",
        port = 3306,
        database = "test",
        user = "root",
        password = "",
        charset = "utf8",
    }
end

return M
