-- -*- coding:utf-8 -*-
---上游服务配置
-- @author:phenix3443+github@gmail.com

local rt = require("conf.runtime")

local M = {}

if rt.mode == "develop" then
    M.falcon = {
        host = "falcon-agent.localhost",
        ip = "127.0.0.1",
        port = 30976
    }
elseif rt.mode == "pre-release" then
    M.falcon = {
        host = "falcon-agent.localhost",
        ip = "127.0.0.1",
        port = 30976
    }
elseif rt.mode == "release" then
    M.falcon = {
        host = "falcon-agent.localhost",
        ip = "127.0.0.1",
        port = 30976
    }
end

return M
