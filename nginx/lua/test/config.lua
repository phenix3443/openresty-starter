local project_path = "../../"
local luarocks_path = project_path .. "luarocks/share/lua/5.1/"
package.path=project_path .. "lua/?.lua;" .. luarocks_path .."?.lua;".. package.path
package.cpath=luarocks_path .."?.so;"..package.cpath
