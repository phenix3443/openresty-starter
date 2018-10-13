-- -*- coding:utf-8 -*-
---上游服务配置
-- @author:phenix3443+github@gmail.com

local rt = require("conf.runtime")

local M = {}

if rt.mode == "develop" then
    M.upstream = {
        host = "domain-name",
        ip = "develop-ip",
        port = 80
    }
elseif rt.mode == "pre-release" then
    M.upstream = {
        host = "domain-name",
        ip = "pre-release-ip",
        port = 80
    }
elseif rt.mode == "release" then
    M.upstream = {
        host = "domain-name",
        ip = "release-ip",
        port = 80
    }
end

return M
