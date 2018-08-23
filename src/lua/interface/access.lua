-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc:请求公共参数检查

local cjson = require("cjson.safe")

local utils = require("utils.utils")

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
    local required = {}  -- 修改, header必备参数
    for _, k in ipairs(required) do
        if not ngx.var["cookie_"..k] then
            ngx.log(ngx.ERR, "cookie lack:", k)
            return
        end
    end

    return true
end

local function check_body()
    ngx.req.read_body()
    local body = ngx.req.get_post_args()

    ngx.log(ngx.DEBUG,"body:", cjson.encode(body))

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
