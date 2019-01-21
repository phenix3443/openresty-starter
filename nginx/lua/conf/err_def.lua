-- -*- coding:utf-8 -*-
--- 错误码配置.
-- @module conf.err_def
-- @author:phenix3443@gmail.com

local M = {}

--- 代码中错误短语与错误码映射
-- @field key 错误短语
-- @field value 错误码
M.code = {}

--- 错误码与对应的客户端描述映射
-- @field key 错误码
-- @field value 返回客户端的描述

M.msg = {}

M.code["SUCCESS"] = 0
M.msg[0] = "success"


return M
