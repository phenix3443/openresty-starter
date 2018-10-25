-- -*- coding:utf-8 -*-
-- 对外接口代码示例
-- @author:phenix3443+github@gmail.com


local cjson = require("cjson.safe")

local cfg = require("conf.config")

local upstream_cfg = require("conf.upstream")
local example = require("upstream.example")

local database = require("database.database")
local cache = require("cache.cache")

local utils = require("utils.utils")

local function get_req()
    local req = {}
    local err_msg

    -- 检查header
    local headers = ngx.req.get_headers()
    ngx.log(ngx.DEBUG, "headers:", cjson.encode(headers))

    -- 检查body
    ngx.req.read_body()
    local body = ngx.req.get_body_data()
    if not body then
        return nil, "can not get body data"
    end

    local json_data = cjson.decode(body)
    if not json_data then
        return nil, string.format("json decode failed, body: ", body)
    end

    for _,k in pairs({}) do
        local v = json_data[k]
        if nil == v then
            err_msg = string.format("req lack param: %s, body:%s", k, body)
            return nil, err_msg
        end
    end

    ngx.log(ngx.INFO, "req:", cjson.encode(req))

    return req, nil
end

local function gen_resp(req)
    local resp = {}

    local client_resp = cjson.encode(resp)
    ngx.log(ngx.INFO, "resp: ", client_resp)
    return client_resp
end

local function main()
    local req, err_msg = get_req()
    if not req then
        utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
    end

    local resp = gen_resp(req, ext_infos)

    utils.send_resp(ngx.HTTP_OK, resp)
end

main()
