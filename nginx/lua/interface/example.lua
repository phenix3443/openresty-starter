-- -*- coding:utf-8 -*-
--- 对外接口代码示例.
-- @script interface
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")

local cfg = require("conf.common")
local err_def = require("conf.err_def")
local ucfg = require("conf.upstream")
local database = require("database.database")
local cache = require("cache.cache")
local utils = require("misc.utils")

--- 获取请求中的所有字段
-- @treturn {key=value...} req 返回所有字段的 table
local function get_req()
    -- header 参数
    local headers = ngx.req.get_headers()
    ngx.log(ngx.DEBUG, "headers:", cjson.encode(headers))

    -- url query args
    local query = ngx.req.get_uri_args()
    ngx.log(ngx.DEBUG, "query:", cjson.encode(query))

    -- body
    -- ngx.req.read_body()
    -- local body = ngx.req.get_body_data()
    -- if not body then
    --     local err_msg = string.format("缺少 body")
    --     utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
    -- end
    -- ngx.log(ngx.DEBUG, "body:", body)

    -- local data = cjson.decode(body)
    -- if not data then
    --     local err_msg = string.format("json decode body failed")
    --     utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
    -- end

    -- local required = {}
    -- for _,k in pairs(required) do
    --     if data[k] then
    --         local err_msg = string.format("body lack:%s", k)
    --         utils.send_resp(ngx.HTTP_BAD_REQUEST, err_msg)
    --     end
    -- end

    local req = {}

    ngx.log(ngx.INFO, "req:", cjson.encode(req))

    return req
end

--- 生成响应的 body
-- @param req 对应的请求字段
local function gen_resp(req)
    local data = {}

    return data
end

--- 请求处理接口
local function main()
    local req = get_req()

    local resp = gen_resp(req)

    utils.send_resp(ngx.HTTP_OK, err_def.code.OK, resp)
end

main()
