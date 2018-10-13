-- -*- coding:utf-8 -*-
--- 通用工具函数
-- @author:phenix3443+github@gmail.com

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")

local config = require("conf.config")
local err_cfg = require("conf.err")

local M = {}

function M.concat_k_v(t, pos)
    local f = function(k,v) return string.format("%s=%s", k, v) end
    local t = tablex.pairmap(f, t)
    local str = table.concat(t, pos)
    ngx.log(ngx.DEBUG, "concated str:", str)
    return str
end
function M.send_resp(err, data)
    local resp  = {
        iRet = err_cfg.code[err],
        sMsg = err_cfg.msg[err],
    }

    if resp.iRet == err_cfg.code["OK"] then
        resp["data"] = data
    end

    ngx.print(cjson.encode(resp))
    ngx.exit(ngx.HTTP_OK)
end


return M
