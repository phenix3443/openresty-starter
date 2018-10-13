-- -*- coding:utf-8 -*-
-- author:phenix3443+github@gmail.com
-- desc:mysql辅助函数

local cjson = require("cjson.safe")
local class = require("pl.class")

local mysql_helper = require("database.mysql_helper")

local export = class(mysql_helper)

-- 下面自行编写业务代码
function export.get_db_version(self)
    -- 查询用户下载信息
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

return export
