#!/bin/bash
# desc：安装一些依赖的第三方库
LIBS="lua-cjson penlight version lua-resty-http luaunit ldoc lua-discount serpent luacov cluacov"
INSTALL_DIR=../luarocks
for lib in ${LIBS}; do
    echo ${lib}
    luarocks --tree ${INSTALL_DIR} install ${lib}
done
