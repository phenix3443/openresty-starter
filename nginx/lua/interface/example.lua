-- -*- coding:utf-8 -*-
--- 对外接口代码示例.
-- @script interface
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")

local cfg = require("conf.common")
local ucfg = require("conf.upstream")
local err_def = require("conf.err_def")

local shm = require("misc.shm")
local retcode = require("falcon.metrics.return_code")

local database = require("database.database")
local cache = require("cache.cache")

local utils = require("misc.utils")
local ngx_utils = require("misc.ngx")

--- 生成响应的 body
-- @param req 对应的请求字段
local function gen_resp(req, code, msg, data)
    -- 统计错误码
    local domain = ngx.var.server_name
    local url = ngx.escape_uri(ngx.var.uri)
    local shm_key = retcode.gen_shm_key(domain, url, code)
    shm.incr_value(shm_key)

    -- 构造响应
    local resp = {
        code = code,
        msg = msg or err_def.msg[code],
        data = data
    }

    return cjson.encode(resp)
end

--- 获取请求中的所有字段
-- @treturn {key=value...} req 返回所有字段的 table
local function get_req()
    local req = {}

    -- http header
    local headers = ngx.req.get_headers()
    ngx.log(ngx.DEBUG, "headers:", cjson.encode(headers))

    -- url query args
    local query = ngx.req.get_uri_args()
    ngx.log(ngx.DEBUG, "query:", cjson.encode(query))

    -- body
    ngx.req.read_body()
    local body = ngx.req.get_body_data()
    if not body then
        local err_msg = string.format()
        local resp = gen_resp(req, err_def.code.ERR_PARAM, "缺少 body")
        ngx_utils.send_resp(ngx.HTTP_BAD_REQUEST, resp)
    end
    ngx.log(ngx.DEBUG, "body:", body)

    local data = cjson.decode(body)
    if not data then
        local resp = gen_resp(req, err_def.code.ERR_PARAM, "json decode body failed")
        ngx_utils.send_resp(ngx.HTTP_BAD_REQUEST, resp)
    end

    ngx.log(ngx.DEBUG, "req:", cjson.encode(req))

    return req
end

local function check_req(req)
    -- 必备的参数
    local required = {}
    for _, k in pairs(required) do
        if data[k] then
            local err_msg = string.format("body lack:%s", k)
            return err_def.code.ERR_PARAM, err_msg
        end
    end
    return err_def.code.OK
end

--- 请求处理接口
local function main()
    local req = get_req()
    local code, msg = check_req(req)
    if code ~= err_def.code.OK then
        local resp = gen_resp(req, code, msg)
        ngx_utils.send_resp(ngx.HTTP_OK, resp)
    end
    local resp = gen_resp(req, err_def.code.OK)
    ngx_utils.send_resp(ngx.HTTP_OK, resp)
end

main()
