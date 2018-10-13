-- -*- coding:utf-8 -*-
-- author:phenix3443+github@gmail.com
-- desc:mysql辅助函数

local cjson = require("cjson.safe")
local mysql = require("resty.mysql")
local tablex = require("pl.tablex")
local class = require("pl.class")

local export = class()

function export:_init(db_cfg)
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

    self.db = db
end

function export.close(self)
    local ok, err = self.db:set_keepalive(10000, 100)
    if not ok then
        ngx.log(ngx.ERR, "failed to set keepalive: ", err)
        return
    end
end

function export.query(self, stmt)
    ngx.log(ngx.DEBUG, stmt)

    local res, err, errcode, sqlstate = self.db:query(stmt)
    if not res then
        ngx.log(ngx.ERR,string.format("%s:%s",errcode, err))
        return
    end

    local resp = res

    while err == "again" do
        res, err, errcode, sqlstate = self.db:query(stmt)
        if not res then
            ngx.log(ngx.ERR,string.format("%s:%s",errcode, err))
            return
        end
        tablex.move(resp, res)
    end

    ngx.log(ngx.DEBUG, "resp:", resp)
    return resp
end

return export
