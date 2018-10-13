-- -*- coding:utf-8 -*-
-- 示例cache 配置
-- @author:phenix3443@gmail.com

local rt = require("conf.runtime")

local M = {}

if rt.mode == "develop" then

elseif rt.mode == "pre-release" then

elseif rt.mode == "release" then

end

M.connect_info = {
    host = "127.0.0.1",
    port = 6380,
    database = 2,
}

return M
