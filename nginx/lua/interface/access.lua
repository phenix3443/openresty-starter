-- -*- coding:utf-8 -*-
--- 请求公共参数检查.
-- access_by_lua 调用
-- @script access
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local utils = require("misc.utils")

--- 检查 http url 中的 公共 query 参数
local function check_query()
    local args = ngx.req.get_uri_args()
    local required = {}
    for _, k in ipairs(required) do
        if not args[k] then
            local err_msg = string.format("url query lack:%s",k)
            utils.send_err_resp(ngx.HTTP_BAD_REQUEST, err_msg)
        end
    end
end

--- 检查 http 头部的公共参数
local function check_header()
    local hd = ngx.req.get_headers()
    local required = {}
    for _, k in ipairs(required) do
        if not hd[k] then
            local err_msg = string.format("header lack:%s",k)
            utils.send_err_resp(ngx.HTTP_BAD_REQUEST, err_msg)
        end
    end
end

--- 检查 cookie 中的公共参数
local function check_cookie()
    local required = {}
    for _, k in ipairs(required) do
        if not ngx.var["cookie_"..k] then
            local err_msg = string.format("cookie lack:%s",k)
            utils.send_err_resp(ngx.HTTP_BAD_REQUEST, err_msg)
        end
    end
end

--- 检查 body 中的公共参数
local function check_body()

end

local function main()
    check_query()
    check_header()
    check_cookie()
    check_body()
end

main()
