-- -*- coding:utf-8 -*-
--- 依赖的外部应用访问地址配置.
-- @module conf.upstream
-- @author:phenix3443@gmail.com

local conf = require("conf.config")

local M = {}

if conf.mode == "mock" then
    --- falcon 接口
    M.falcon = {
        host = "falcon-agent.mock",
        uri = "http://127.0.0.1",
    }
    --- example_cache 配置
    M.example_cache = {
        name = "example_cache.mock",
        host = "127.0.0.1",
        port = 6379,
        database = 0,
        password = nil
    }
    --- example_db 配置
    M.example_db = {
        host = "127.0.0.1",
        port = 3306,
        database = "test",
        user = "root",
        password = "",
        charset = "utf8",
    }
elseif conf.mode == "develop" then

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
