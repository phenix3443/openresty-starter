-- -*- coding:utf-8; -*-
-- author:liushangliang
-- desc: 测试接口
-- doc:
local cjson = require("cjson.safe")
local falcon = require("falcon/falcon")
local database = require("database/database")
local function main()
    -- local dict = ngx.shared["xl_lixian_download_vip_interface_server"]
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
