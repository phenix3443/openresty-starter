-- -*- coding:utf-8 -*-
--- ipdb.
-- @module misc.ip 信息解析.
-- @author:phenix3443+github@gmail.com
local cjson = require("cjson.safe")
local stringx = require("pl.stringx")
local class = require("pl.class")

local IPDB = require("misc.ipdb")
local MMH = require("misc.mmdb_helper")

local M = class()

function M:_init(geo_cfg, ipdb_cfg, mmdb_cfg)
    self.g_cfg = geo_cfg
    self.i_cfg = ipdb_cfg
    self.m_cfg = mmdb_cfg

    self.coun_n_idx, self.coun_s_idx = self:load_coun_info()
    self.area_n_idx, self.area_s_idx = self:load_area_info()
    self.prov_n_idx, self.prov_s_idx = self:load_prov_info()
    self.area_prov_n_idx, self.area_prov_s_idx = self:load_area_prov_info()
    self.prov_city_n_idx, self.prov_city_s_idx = self:load_prov_city_info()
    self.isp_n_idx, self.isp_s_idx = self:load_isp_info()

    self.ipdb = IPDB(self.i_cfg.db)
    self.mmh = MMH(self.m_cfg.city_db, self.m_cfg.asn_db)
end

function M:load_coun_info()
    local n_idx = {}
    local s_idx = {}

    local path = self.g_cfg.country
    local f = io.open(path, "r")
    if not f then
        ngx.log(ngx.ERR, "open area file fail, path:", path)
        return
    end
    for line in f:lines() do
        local a = stringx.split(line)
        local n = tonumber(a[1])
        local s = stringx.strip(a[2])

        n_idx[n] = s
        s_idx[s] = n
    end

    f:close()
    return n_idx, s_idx
end

--- 根据IP库的 coun_num (数值类型), 返回对应的国家名称(异常数据统一显示"未知")
function M:get_coun_str_by_num(coun_num)
    -- 先从 isp_name_cache 中获取
    local s = self.coun_n_idx[tonumber(coun_num)]
    return s
end

--- 根据IP库的 coun_num (数值类型), 返回对应的国家名称(异常数据统一显示"未知")
function M:get_coun_num_by_str(coun_str)
    -- 先从 isp_name_cache 中获取
    local s = self.coun_s_idx[coun_str]
    return s
end

function M:load_area_info()
    local n_idx = {}
    local s_idx = {}

    local path = self.g_cfg.area
    local f = io.open(path, "r")
    if not f then
        ngx.log(ngx.ERR, "open area file fail, path:", path)
        return
    end
    for line in f:lines() do
        local a = stringx.split(line)
        local n = tonumber(a[1])
        local s = stringx.strip(a[2])

        n_idx[n] = s
        s_idx[s] = n
    end

    f:close()
    return n_idx, s_idx
end

--- 根据IP库的 area_num (数值类型), 返回对应大区的名称(异常数据统一显示"未知")
function M:get_area_str_by_num(area_num)
    local s = self.area_n_idx[tonumber(area_num)]
    return s
end


--- 根据 area_num (数值类型), 返回大区归属的国家编号(数值类型)(异常数据统一返回47, 中国)
function M:get_belong_coun_num_by_area_num(area_num)
    local t = {
        ["东北区"] = 47,
        ["华东区"] = 47,
        ["华北区"] = 47,
        ["华南区"] = 47,
        ["西北区"] = 47,
        ["西南区"] = 47
    }

    local area_s = self:get_area_str_by_num(area_num)
    if not area_s then
        return 47
    end

    local s = t[area_s]
    if not s then
        return 47
    end
    return s
end


function M:load_prov_info()
    local n_idx = {}
    local s_idx = {}

    local path = self.g_cfg.prov
    local f = io.open(path, "r")
    if not f then
        ngx.log(ngx.ERR, "open city file fail, path:", path)
        return
    end
    for line in f:lines() do
        local a = stringx.split(line)
        local n = tonumber(a[1])
        local s = stringx.strip(a[2])

        n_idx[n] = s
        s_idx[s] = n
    end

    f:close()
    return n_idx, s_idx
end

--- 判断是否是"特殊的"省份(特殊的省份包括: 香港(33)/澳门(34)/台湾(6))
-- 如果是"特殊的"省份, 则返回 true; 否则, 返回 false
-- 注: 这些"特殊的"省份, 其调度只能按照省一级维度选择机器, 不能使用大区/国家维度
function M.is_special_prov(prov_num)
    if 33 == prov_num or 34 == prov_num or 6 == prov_num then
        return true
    else
        return false
    end
end

--- 根据IP库的 prov_num (数值类型), 返回对应的省份名称(异常数据统一显示"未知")
function M:get_prov_str_by_num(prov_num)
    -- 先从 prov_name_cache 中获取
    local s = self.prov_n_idx[tonumber(prov_num)]
    return s
end

--- 根据 prov_str (字符串类型), 返回对应的省份数字(找不到时, 统一返回0)
function M:get_prov_num_by_str(prov_str)
    local n = self.prov_s_idx[prov_str]
    return n
end

function M:load_area_prov_info()
    local s_idx = {
        ["吉林省"] = 1,
        ["黑龙江省"] = 1,
        ["辽宁省"] = 1,
        ["上海市"] = 2,
        ["安徽省"] = 2,
        ["浙江省"] = 2,
        ["江苏省"] = 2,
        ["江西省"] = 2,
        ["湖北省"] = 2,
        ["北京市"] = 3,
        ["天津市"] = 3,
        ["山东省"] = 3,
        ["山西省"] = 3,
        ["河北省"] = 3,
        ["河南省"] = 3,
        ["内蒙古"] = 3,
        ["广东省"] = 4,
        ["海南省"] = 4,
        ["湖南省"] = 4,
        ["福建省"] = 4,
        ["广西"] = 4,
        ["新疆"] = 5,
        ["宁夏"] = 5,
        ["甘肃省"] = 5,
        ["陕西省"] = 5,
        ["青海省"] = 5,
        ["重庆市"] = 6,
        ["云南省"] = 6,
        ["四川省"] = 6,
        ["贵州省"] = 6,
        ["西藏"] = 6,
        ["香港"] = 4, -- 台湾/香港/澳门暂时归为"华南区"
        ["澳门"] = 4,
        ["台湾"] = 4,
    }


    local n_idx = {}
    for prov_s,area_n in pairs(s_idx) do
        n_idx[area_n] = n_idx[area_n] or {}
        n_idx[area_n][prov_s] = true
    end
    return n_idx, s_idx
end

--- 根据IP库的 prov_num (数值类型), 返回省份归属的大区编号(数值类型)
-- 异常数据统一返回4, 华南区
function M:get_belong_area_num_by_prov_num(prov_num)
    local prov_s = self:get_prov_str_by_num(prov_num)
    local n = self.area_prov_s_idx[prov_s]
    if not n then --如果省份数字异常, 统一返回4("华南区")
        ngx.log(ngx.WARN, "get area_num fail from config with prov_num: ", prov_num)
        return 4
    end
    return n
end

-- 省市层级关系
function M:load_prov_city_info()
    local n_idx = {}
    local s_idx = {}

    local path = self.g_cfg.city
    local f = io.open(path, "r")
    if not f then
        ngx.log(ngx.ERR, "open city file fail, path:", path)
        return
    end
    for line in f:lines() do
        local a = stringx.split(line)
        local prov_s = stringx.strip(a[1])
        local city_s = stringx.strip(a[2])
        local city_n = tonumber(a[3])
        local prov_n = self:get_prov_num_by_str(prov_s)
        if prov_n then
            s_idx[prov_s] = s_idx[prov_s] or {}
            n_idx[prov_n] = n_idx[prov_n] or {}

            s_idx[prov_s][city_s] = city_n
            n_idx[prov_n][city_n] = city_s
        end
    end

    f:close()
    return n_idx, s_idx
end

--- 根据IP库的 prov_num/city_num (数值类型), 返回对应的省份下的城市名称(异常数据统一显示"未知")
function M:get_city_str_by_num(prov_num, city_num)
    local prov_n = tonumber(prov_num)
    if not self.prov_n_idx[prov_n] then
        return
    end

    -- 台湾(6)/香港(33)/澳门(34), 直接返回对应省名
    if self.is_special_prov(prov_n) then
        return self.prov_n_idx[prov_n]
    end

    -- 从 city_name_cache 中获取
    local s = self.prov_city_n_idx[prov_num][tonumber(city_num)]
    return s
end

function M:get_city_num_by_str(prov_s, city_s)
    -- 从 city_name_cache 中获取
    return self.prov_city_s_idx[prov_s][city_s]
end

function M:load_isp_info()
    local n_idx = {}
    local s_idx = {}

    local path = self.g_cfg.isp
    local f = io.open(path, "r")
    if not f then
        ngx.log(ngx.ERR, "open area file fail, path:", path)
        return
    end
    for line in f:lines() do
        local a = stringx.split(line)
        local s = stringx.strip(a[1])
        local n = tonumber(a[2])

        n_idx[n] = s
        s_idx[s] = n
    end

    f:close()
    -- print(cjson.encode(n_idx))
    -- print(cjson.encode(s_idx))
    return n_idx, s_idx
end

--- 根据IP库的 isp_num (数值类型), 返回对应的运营商名称(异常数据统一显示"未知")
function M:get_isp_str_by_num(isp_num)
    -- 先从 isp_name_cache 中获取
    local isp_s = self.isp_n_idx[tonumber(isp_num)]
    return isp_s
end

--- 判断是否是"主要的"运营商(主要的运营商包括: 1(电信) / 2(联通) / 5(移动)
-- 如果是"主要的"运营商, 则返回 true; 否则, 返回 false
-- 注: 这些"主要的"运营商, 是针对国内ip, 国外不予考虑
function M.is_main_isp(isp_num)
    local t = { [1]="tel", [2]="cnc", [5]="mob" }
    if t[isp_num] then
        return true
    else
        return false
    end
end


function M:get_location_info_by_ip(ip)
    local ipdb_info = self.ipdb:get_location_info(ip)
    local mmdb_info = self.mmh:get_location_info(ip)

    local coun_n, area_n, prov_n, city_n, isp_n, coun_iso_code
    local coun_s, area_s, prov_s, city_s, isp_s

    -- 国家信息
    if ipdb_info and ipdb_info.coun_n ~= 0 then
        coun_n = ipdb_info.coun_n
        coun_s = self:get_coun_str_by_num(coun_n)
        -- ngx.log(ngx.INFO, "country hit ipdb")
    else
        coun_s = mmdb_info.coun_s
        coun_n = self:get_coun_num_by_str(coun_s)
        coun_iso_code = mmdb_info.coun_iso_code -- "IN"
        -- ngx.log(ngx.INFO, "country hit mmdb")
    end

    if mmdb_info.coun_s ~= coun_s then
        -- 如果 ipdb 和 mmdb 查找出来国家不一样，以 mmdb 为准
        coun_s = mmdb_info.coun_s
        coun_n = self:get_coun_num_by_str(coun_s)
        coun_iso_code = mmdb_info.coun_iso_code -- "IN"
        -- ngx.log(ngx.INFO, "country differ， hit mmdb")
    end

    -- prov 信息
    if ipdb_info and ipdb_info.prov_n ~= 0 then
        prov_n = ipdb_info.prov_n
        prov_s = self:get_prov_str_by_num(prov_n)
        -- ngx.log(ngx.INFO, "prov hit ipdb")
    else
        prov_s = mmdb_info.prov_s
        if coun_n == 47 then
            -- 只有国内能找到省份的 prov code
            prov_n = self:get_prov_num_by_str(prov_s)
        end
        -- ngx.log(ngx.INFO, "prov hit mmdb")
    end

    -- city 信息
    if ipdb_info and ipdb_info.city_n ~= 0 then
        city_n = ipdb_info.city_n
        city_s = self:get_city_str_by_num(prov_n, city_n)
        -- ngx.log(ngx.INFO, "city hit ipdb")
    else
        city_s = mmdb_info.city_s
        if coun_n == 47 and city_s then
            city_n = self:get_city_num_by_str(prov_s, city_s)
        end
        -- ngx.log(ngx.INFO, "city hit mmdb")
    end

    -- isp info
    if ipdb_info and ipdb_info.isp_n ~= 0 then
        isp_n = ipdb_info.isp_n
        isp_s = self:get_isp_str_by_num(isp_n)
        -- ngx.log(ngx.INFO, "isp hit ipdb")
    else
        isp_s = mmdb_info.isp_s
        isp_n = mmdb_info.isp_n
        -- ngx.log(ngx.INFO, "isp hit mmdb")
    end

    -- area 信息
    if 47 == coun_n and (not self.is_special_prov(prov_n)) then
        -- 如果是中国IP, 非香港/澳门/台湾, 则大区/国家数字根据逻辑关系得到
        area_n = self:get_belong_area_num_by_prov_num(prov_n)
        area_s = self:get_area_str_by_num(area_n)
    else
        area_n = 0
    end

    local location
    if coun_n then
        location = {
            city_n=city_n, city_s=city_s,
            prov_n=prov_n, prov_s=prov_s,
            area_n=area_n, area_s=area_s,
            isp_n=isp_n,   isp_s=isp_s,
            coun_n=coun_n, coun_s=coun_s
        }
    else
        -- ip库异常时, 统一使用: 中国(47), 华南区(4), 广东省(12), 广州市(4), 电信(1)
        -- ngx.log(ngx.WARN, "lookup location fail, ip: ", ip)
        location = {
            city_n=4,  city_s="广州市",
            prov_n=12, prov_s="广东省",
            area_n=4,  area_s="华南区",
            isp_n =1,  isp_s ="电信",
            coun_n=47, coun_s="中国"
        }
    end

    return location
end


--- 对传入的 location 地理位置信息进行校正。
-- 如果是非国内IP, 则不要校正, 跨国调度
-- 修正IP库无法识别的地址, 将 prov 统一重定向到"广东省", isp 统一重定向到"电信"
-- prov: 12(广东省)
-- isp: 1(电信) / 2(联通) / 5(移动)
function M:correct_location_info(location)
    if (47 == location["coun_n"])
        and (not self:get_prov_str_by_num(location.prov_n))
    then
        -- 无法识别的省份, 默认定向到: 12(广东省)|15(深圳市); 非国内IP, 不需要修正
        location["prov_n"] = 12
        location["prov_s"] = self:get_prov_str_by_num(location["prov_n"])

        location["city_n"] = 15
        location["city_s"] = self:get_city_str_by_num(location["prov_n"], location["city_n"])

        -- 根据修正后的省份，重新找出归属的大区和国家
        location["area_n"] = self:get_belong_area_num_by_prov_num(location["prov_n"])
        location["area_s"] = self:get_area_str_by_num(location["area_n"])

        location["coun_n"] = self:get_belong_coun_num_by_area_num(location["area_n"])
        location["coun_s"] = self:get_coun_str_by_num(location["coun_n"])
    end


    local fix_isp = {
        [0] = 1,                  -- 无法识别的运营商及其他小运营商, 默认定向到: 1(电信)
        [4] = 5                   -- 铁通返回移动 isp
    }

    -- 非国内IP 及 香港/澳门/台湾 省份, 不需要修正;
    local isp_num = location["isp_n"]
    if 47 == location["coun_n"]
        and (not self.is_special_prov(location["prov_n"]))
        and (not self.is_main_isp(isp_num))
    then
        local correct_isp = fix_isp[isp_num]
        if not correct_isp then
            correct_isp = 1
        end

        location["isp_n"] = correct_isp
        location["isp_s"] = self:get_isp_str_by_num(correct_isp)
    end

    return
end

return M
