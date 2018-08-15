-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc:main_db数据库接口

local cjson = require("cjson.safe")
local mysql = require("resty.mysql")

local export = {}
local mt = {__index = export}

function export.new(db_cfg)
    local db, err = mysql:new()
    if not db then
        ngx.log(ngx.ERR,"failed to instantiate mysql: ", err)
        return
    end

    local ok, err, errcode, sqlstate = db:connect(db_cfg)

    if not ok then
        ngx.log(ngx.ERR,"failed to connect: ", err, ": ", errcode, " ", sqlstate)
        return
    end

    ngx.log(ngx.DEBUG,"connected to mysql.")

    return setmetatable({db=db},mt)
end

function export.close(self)
    local ok, err = self.db:set_keepalive(10000, 100)
    if not ok then
        ngx.log(ngx.ERR, "failed to set keepalive: ", err)
        return
    end
end

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

function export.get_info(self, cond)
    local values = {}
    for i,v in pairs(cond) do
        if tonumber(v) then
            table.insert(values, string.format("%s=%d",i,tonumber(v)))
        else
            table.insert(values, string.format("%s=%s",i, ngx.quote_sql_str(v)))
        end
    end

    if #values < 1 then
        return
    end

    local stmt = string.format("select * from tb_name where %s;", table.concat(values," and "))
    ngx.log(ngx.DEBUG, stmt)
    local res, err, errcode, sqlstate = self.db:query(stmt)
    if not res then
        ngx.log(ngx.ERR,string.format("%s:%s",errcode, err))
        return
    end
    local resp = res
    ngx.log(ngx.DEBUG, "resp:", resp)
    return resp
end

return export
