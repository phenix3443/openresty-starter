-- -*- coding:utf-8 -*-
-- 示例cache 配置
-- @author:phenix3443+github@gmail.com

local rt = require("conf.runtime")

local M = {}

if rt.mode == "develop" then
    M.connect_info = {
        host = "127.0.0.1",
        port = 6379,
        database = 0,
        password = nil
    }
elseif rt.mode == "pre-release" then
    M.connect_info = {
        host = "127.0.0.1",
        port = 6379,
        database = 0,
        password = nil
    }
elseif rt.mode == "release" then
    M.connect_info = {
        host = "127.0.0.1",
        port = 6379,
        database = 0,
        password = nil
    }
end



return M
