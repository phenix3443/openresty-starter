-- -*- coding:utf-8 -*-
--- 公共配置模块.
-- @module conf.config
-- @author:phenix3443@gmail.com

local M = {}

--- 项目名称.
M.project = "example"

--- 当前运行环境.
-- mock：本地开发环境，必要时外部接口使用 mock 实现。
-- develop：开发环境。
-- pre-release：预发布环境。
-- release：生产环境。
M.mode = "mock"

return M
