-- -*- coding:utf-8 -*-
--- misc.ip_utils
-- @module ip 字符串相关处理函数
-- @author:phenix3443+github@gmail.com

local M = {}

--- 判断输入的IP字符串是否为合法的 IPv4 或者 IPv6
-- @param  ip_str
-- @return 0 长度不对
-- @return 1 IPv4 地址
-- @return 2 IPv6 地址
-- @return 3 IP 地址内容非法
function M.get_type(ip)
    local R = {
        ERROR = 0,
        IPV4 = 1,
        IPV6 = 2,
        STRING = 3
    }

    if type(ip) ~= "string" then
        return R.ERROR
    end

    -- check for format 1.11.111.111 for ipv4
    local chunks = { ip:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$") }
    if (#chunks == 4) then
        for _,v in pairs(chunks) do
            if tonumber(v) > 255 then
                return R.STRING
            end
        end
        return R.IPV4
    end

    -- check for ipv6 format, should be max 8 'chunks' of numbers/letters
    local addr = ip:match("^([a-fA-F0-9:]+)$")
    if addr ~= nil and #addr > 1 then
        -- address part
        local nc, dc = 0, false      -- chunk count, double colon
        for chunk, colons in addr:gmatch("([^:]*)(:*)") do
            if nc > (dc and 7 or 8) then return R.STRING end    -- max allowed chunks
            if #chunk > 0 and tonumber(chunk, 16) > 65535 then
                return R.STRING
            end
            if #colons > 0 then
                -- max consecutive colons allowed: 2
                if #colons > 2 then return R.STRING end
                -- double colon shall appear only once
                if #colons == 2 and dc == true then return R.STRING end
                if #colons == 2 and dc == false then dc = true end
            end
            nc = nc + 1
        end
        return R.IPV6
    end
    return R.STRING
end

return M
