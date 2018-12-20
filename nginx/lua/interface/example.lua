-- -*- coding:utf-8 -*-
-- 对外接口代码示例
-- @author:phenix3443+github@gmail.com


local cjson = require("cjson.safe")

local cfg = require("conf.config")
local err_def = require("conf.err_def")
local upstream_cfg = require("conf.upstream")
local example = require("upstream.example")
local database = require("database.database")
local cache = require("cache.cache")
local utils = require("utils.utils")

local function get_req()
    -- header参数
    local headers = ngx.req.get_headers()
    ngx.log(ngx.DEBUG, "headers:", cjson.encode(headers))

    -- url query args
    local query = ngx.req.get_uri_args()
    ngx.log(ngx.DEBUG, "query:", cjson.encode(query))

    -- body
    ngx.req.read_body()
    local body = ngx.req.get_body_data()
    if not body then
        local err_msg = string.format("缺少body")
        utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
    end
    ngx.log(ngx.DEBUG, "body:", body)

    local data = cjson.decode(body)
    if not data then
        local err_msg = string.format("json decode body failed")
        utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
    end

    local required = {}
    for _,k in pairs(required) do
        if data[k] then
            local err_msg = string.format("body lack:%s", k)
            utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
        end
    end

    local req = {}

    ngx.log(ngx.INFO, "req:", cjson.encode(req))

    return req
end

local function gen_resp(req)
    local resp = {}
    resp.code = err_def.code["success"]
    resp.msg = err_def.msg[resp.code]
    resp.data = {}

    local client_resp = cjson.encode(resp)
    ngx.log(ngx.INFO, "resp: ", client_resp)
    return client_resp
end

local function main()
    local req = get_req()

    local resp = gen_resp(req)

    utils.send_resp(ngx.HTTP_OK, resp)
end

main()
