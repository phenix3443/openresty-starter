-- -*- coding:utf-8; -*-
--- 测试接口.
-- @script test
-- @author:phenix3443@gmail.com

local cjson = require("cjson.safe")
local shm = require("misc.shm")
local database = require("database.database")

--- 测试主函数
local function main()
    ngx.say("hello,world")
    -- local dict = ngx.shared[""]
    -- dict:flush_all()

    -- local item = "dog"
    -- local newval, err, forcible = dict:incr(item, 1, 0)
    -- if newval == 1 then
    --     local success, err = dict:expire(item, 30)
    --     if not success then
    --         ngx.log(ngx.WARN, "set item expire failed, item:", item)
    --     end
    -- end

    -- ngx.say(dict:get(item))

    -- local version = database.get_main_db_version()
    -- ngx.say(version)
end

main()
