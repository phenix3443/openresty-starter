-- -*- coding:utf-8 -*-
-- author:liushangliang@xunlei.com
-- desc: 该文件写明falcon采集上报相关配置

local export = {}

export.default_step= 60          -- in second
export.shm_name = ""             -- project.nginx.conf中声明的共享字典的名字


return export
