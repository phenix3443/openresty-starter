-- -*- coding:utf-8 -*-
-- desc:请求公共参数检查
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")

local utils = require("utils.utils")



-- 检查url中的query参数
local function check_query()
    local args = ngx.req.get_uri_args()
    local required = {}
    for _, k in ipairs(required) do
        if not args[k] then
            local err_msg = string.format("url 缺少参数:%s",k)
            utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
        end
    end
end

local function check_header()
    local hd = ngx.req.get_headers()
    local required = {"cookie"}
    for _, k in ipairs(required) do
        if not hd[k] then
            local err_msg = string.format("header 缺少参数:%s",k)
            utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
        end
    end
end

local function check_cookie()
    local required = {}
    for _, k in ipairs(required) do
        if not ngx.var["cookie_"..k] then
            local err_msg = string.format("cookie 缺少参数:%s",k)
            utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
        end
    end
end

local function check_body()
    ngx.req.read_body()
    local body = ngx.req.get_body_data()
    if not body then
        local err_msg = string.format("缺少body")
        utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
    end

    local decode_body = cjson.decode(body)
    if not decode_body then
        local err_msg = string.format("json decode body failed")
        utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
    end

    local  required = {}
    for _,k in pairs(required) do
        if decode_body[k] then
            local err_msg = string.format("body 缺少参数:%s", k)
            utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
        end
    end
end

local function main()
    check_query()
    check_header()
    check_cookie()
    check_body()
end

main()
