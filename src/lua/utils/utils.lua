-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc:通用工具函数

local cjson = require("cjson.safe")
local tablex = require("pl.tablex")
local ngx_re = require("ngx.re")

local config = require("config.config")
local err_cfg = require("config.err")

local export = {}

function export.concat_k_v(t, pos)
    local f = function(k,v) return string.format("%s=%s", k, v) end
    local t = tablex.pairmap(f, t)
    local str = table.concat(t, pos)
    ngx.log(ngx.DEBUG, "concated str:", str)
    return str
end

-- 将Accept_Language解析为table
function export.get_lang_options(accept_lang)
    local options = {}

    for _,lq in pairs(ngx_re.split(accept_lang, ",")) do
        local s = ngx_re.split(lq, ";")
        local l = s[1]
        local q = 1
        if s[2] and s[2] ~= "" then
            local t = ngx_re.split(s[2],"=")[2]
            if t and tonumber(t) then
                q = tonumber(t)
            end
        end
        options[l] = q
    end

    ngx.log(ngx.DEBUG, "accept_lang:", accept_lang, " options:", cjson.encode(options))

    return options
end

-- 获取客户端最合适的语言
function export.get_favor_lang(accept_lang)
    local favor = "en"
    local options = export.get_lang_options(accept_lang or "")

    if next(options) then
        local iter = tablex.sortv(options, function(x,y) return x>y end )
        favor,_ = iter(1)
    end

    ngx.log(ngx.DEBUG, "accept_lang:", accept_lang, " favor:", favor)

    return favor
end


function export.send_resp(err, data)
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


return export
