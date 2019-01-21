-- -*- coding:utf-8 -*-
--- 白名单配置.
-- 该文件中的配置应该根据实际情况进行配置。
-- @module conf.white_list

local M = {}

--- 接口对应的白名单.
-- 此处是示例，实际使用时应该将 interface 替换成实际的接口。
M.interface = {
    ["127.0.0.1"] = true,
}

return M
