-- -*- coding:utf-8 -*-
---上游服务配置
-- @author:liushangliang@xunlei.com

local rt = require("conf/runtime")

local M = {}

if rt.mode == "develop" then

elseif rt.mode == "pre-release" then

elseif rt.mode == "release" then

end

M.upstream = {
    name = "localhost",
    host = "localhost",
    port = 80
}

return M
