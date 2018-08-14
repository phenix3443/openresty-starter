-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc:请求公共参数检查

local cjson = require("cjson.safe")
local cookie = require("resty.cookie")

local utils = require("utils.utils")
local sign = require("utils.sign")

local function check_method()
    return true
end

-- 检查url中的query参数
local function check_query()
    local args = ngx.req.get_uri_args()
    ngx.log(ngx.DEBUG,"query args:", cjson.encode(args))

    local required = {}  -- 修改, url必备参数
    for _, k in ipairs(required) do
        if not args[k] then
            ngx.log(ngx.ERR, "url lack ", k)
            return
        end
    end

    return true
end

local function check_header()
    local hd = ngx.req.get_headers()
    ngx.log(ngx.DEBUG, "headers:", cjson.encode(hd))

    local required = {}  -- 修改, header必备参数
    for _, k in ipairs(required) do
        if not hd[k] then
            ngx.log(ngx.ERR, "header lack ", k)
            return
        end
    end
    return true
end

local function check_cookie()
    ngx.log(ngx.DEBUG, "cookie:", ngx.header.cookie)

    local ck, err = cookie:new()
    if not ck then
        ngx.log(ngx.ERR, "cookie new err:", err)
        return
    end
    local cks = ck:get_all()
    local required = {}  -- 修改, header必备参数
    for _, k in ipairs(required) do
        if not cks[k] then
            ngx.log(ngx.ERR, "cookie lack:", k)
            return
        end
    end

    return true
end

local function check_body()
    ngx.req.read_body()
    local body = ngx.req.get_post_args()
    if not (body and body["sign"]) then
        ngx.log(ngx.ERR, "invalid body: ", body)
        return
    end
    ngx.log(ngx.DEBUG,"body:", cjson.encode(body))

    local ck, _ = cookie:new()
    local cookies = ck:get_all()
    local valid_sign = sign.cal(body, cookies["sessionid"])
    if valid_sign ~= body["sign"] then
        ngx.log(ngx.ERR, "body sign invalid, body sign=", body["sign"], " valid:", valid_sign)
        return
    end
    return true
end

local function main()
    if check_query() and
        check_header() and
        check_cookie() and
        check_body()
    then
        ngx.log(ngx.DEBUG, "check common req params pass")
    else
        utils.send_resp("PARAM_ERR")
    end
end

main()
