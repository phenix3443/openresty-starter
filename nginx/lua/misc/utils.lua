-- -*- coding:utf-8 -*-
--- 通用工具函数.
-- @module utils
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")

local M = {}

--- 从字符串转化位时间戳
-- @param datestr 字符串
-- @return 时间戳
function M.make_timestamp(datestr)
    local pattern = "(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)"
    local year, month, day, hour, minute, seconds = datestr:match(pattern)
    local ts =
        os.time(
        {
            year = year,
            month = month,
            day = day,
            hour = hour,
            min = minute,
            sec = seconds
        }
    )
    return ts
end

return M
