-- -*- coding:utf-8 -*-
-- author:phenix3443+github@gmail.com
-- desc:对外接口代码示例

local cjson = require("cjson.safe")
local cookie = require("resty.cookie")

local cfg = require("conf.config")
local upstream_cfg = require("conf.upstream")

local database = require("database.database")
local cache = require("cache.cache")

local upstream = require("upstream.upsteam")

local utils = require("utils.utils")

local function get_req()
    local req = {}
    -- 检查header
    local headers = ngx.req.get_headers()
    ngx.log(ngx.DEBUG, "headers:", cjson.encode(headers))

    -- cookies
    local ck, err = cookie:new()
    if not cookie then
        ngx.log(ngx.ERR, "cookie new err:", err)
        return
    end

    ngx.log(ngx.DEBUG, "cookie:", ck:get_all())

    -- 检查body
    ngx.req.read_body()
    local body = ngx.req.get_body_data()
    if not body then
        ngx.log(ngx.ERR, "invalid body: ", body)
        return
    end

    local json_data = cjson.decode(body)
    if not json_data then
        ngx.log(ngx.WARN, "json decode error, body: ", body)
    end

    for _,k in pairs({'userid','last_ad_id','last_watchtime','appversion'}) do
        local v = json_data[k]
        if nil == v then
            ngx.log(ngx.ERR, "req param invalid, lack: ", k, " req:",post_data)
            return
        end
    end

    ngx.log(ngx.INFO, "req:", cjson.encode(req))

    return req
end

local function get_resp()
    local resp = {}

    ngx.log(ngx.INFO, "resp: ", cjson.encode(resp))
    return resp
end

local function main()
    local req = get_req()
    if not req then
    end

    local resp = get_resp()
end
