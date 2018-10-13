#!/usr/bin/env bash
# -*- coding:utf-8-*-
# author:phenix3443+github@gmail.com
# desc: 用来编译openresty

SCRIPT_DIR=$(cd $(dirname $0);pwd)
PROJECT_DIR=${SCRIPT_DIR}

INSTALL_DIR=$1                  # 项目安装目录
NGINX_BIN=${INSTALL_DIR}/nginx/sbin/nginx

OPENRESTY=openresty-1.13.6.2
DOWNLOAD_URL="https://openresty.org/download/${OPENRESTY}.tar.gz"
DOWNLOAD_FILE=${OPENRESTY}.tar.gz

function do_compile {
    RELEASE=$(lsb_release -is)
    if [ ${RELEASE} == 'LinuxMint' -o ${RELEASE} == 'Ubuntu' ]; then
        sudo apt install libpcre3-dev libssl-dev perl make build-essential curl zlib1g-dev liblua5.1-0-dev luarocks
    elif [ ${RELEASE} == 'CentOS' ]; then
        sudo yum install -y pcre-devel openssl-devel gcc curl zlib-devel lua-devel luarocks
    else
        exit 1
    fi

    if [ ! -f ${DOWNLOAD_FILE} ]; then
        wget ${DOWNLOAD_URL}
    fi

    tar xzf ${DOWNLOAD_FILE} && cd ${OPENRESTY} && ./configure --prefix=${INSTALL_DIR} && make -j4 && make install && cd .. && rm -fr ${OPENRESTY} ${DOWNLOAD_FILE}
}


if [ -e ${NGINX_BIN} ]; then
    echo "已经编译过openresty"
else
    echo "尚未编译过openresty"
    do_compile
    echo "openresty编译完成"
fi
