-- -*- coding:utf-8 -*-
--- 数据库实例.
-- 使用具体的技术（mysql 等）实现一个持久化数据库。
-- @classmod example_db
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local class = require("pl.class")

local mysql_helper = require("database.mysql_helper")

local M = class(mysql_helper)

--- 示例程序.
--查询数据库版本信息
function M:get_mysql_version()
    local stmt = string.format("select version() as version;")
    ngx.log(ngx.DEBUG, stmt)
    local res, err, errcode, sqlstate = self.db:query(stmt)
    if not res then
        ngx.log(ngx.ERR,string.format("%s:%s",errcode, err))
        return
    end
    local resp = res[1].version
    ngx.log(ngx.DEBUG, "resp:", resp)
    return resp
end

-- 下面自行编写业务代码 -------------------------------------------------------

return M
