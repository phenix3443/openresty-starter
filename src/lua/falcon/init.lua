-- -*- coding:utf-8; -*-
-- author:liushangliang
-- desc:该文件被lua/init.lua 调用

local function init_falcon_mod()
    require("falcon/shm_key/qps")
    require("falcon/shm_key/tps")
    require("falcon/shm_key/status")
    require("falcon/shm_key/request_time")
end

local function main()
    init_falcon_mod()
end

main()
