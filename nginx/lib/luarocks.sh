#!/bin/bash
# desc：安装一些依赖的第三方库
LIBS="lua-cjson penlight version lua-resty-http luaunit"
for lib in ${LIBS}; do
    echo ${lib}
    luarocks install ${lib}
done
