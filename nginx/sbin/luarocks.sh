#!/bin/bash
# desc：安装一些依赖的第三方库
SCRIPT_DIR=$(cd $(dirname $0);pwd)
PROJECT_DIR=$(cd ${SCRIPT_DIR}/../;pwd)
INSTALL_DIR=${PROJECT_DIR}/luarocks

LIBS="lua-cjson penlight version lua-resty-http luaunit ldoc lua-discount serpent luacov cluacov mmdblua snowflake"

for lib in ${LIBS}; do
    echo ${lib}
    luarocks --tree=${INSTALL_DIR} install ${lib}
done
