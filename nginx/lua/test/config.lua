_G.project_path = "../../"
_G.luarocks_path = _G.project_path .. "luarocks/share/lua/5.1/"
package.path = string.format("%slua/?.lua;%s?.lua;%s", _G.project_path, _G.luarocks_path, package.path)
package.cpath = string.format("%s?.so;%slua/?.so;%s", _G.luarocks_path, _G.project_path,package.cpath)
