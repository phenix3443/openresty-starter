#!/usr/bin/env bash
# -*- coding:utf-8-*-
# author:phenix3443@gmail.com
# desc: 用来编译openresty

SCRIPT_DIR=$(cd $(dirname $0);pwd)
PROJECT_DIR=${SCRIPT_DIR}
COMPILED_DIR=${PROJECT_DIR}/openresty/
NGINX_BIN=${COMPILED_DIR}/nginx/sbin/nginx

DOWNLOAD_URL="https://openresty.org/download/openresty-1.13.6.2.tar.gz"
ZIPFILE=openresty-1.13.6.2.tar.gz
UNZIP_DIR=openresty-1.13.6.2

function do_compile {
    RELEASE=$(lsb_release -is)
    if [ ${RELEASE} == 'LinuxMint' -o ${RELEASE} == 'Ubuntu' ]; then
        sudo apt-get install libpcre3-dev libssl-dev perl make build-essential curl
    elif [ ${RELEASE} == 'CentOS' ]; then
        sudo yum install -y pcre-devel openssl-devel gcc curl
    else
        exit 1
    fi
    wget ${DOWNLOAD_URL} && tar xzf ${ZIPFILE} && cd ${UNZIP_DIR} && ./configure --prefix=${COMPILED_DIR} && make -j4 && make install && rm -fr ${UNZIP_DIR} ${ZIPFILE}
}


if [ -e ${NGINX_BIN} ]; then
    echo "已经编译过openresty"
else
    echo "尚未编译过openresty"
    do_compile
    echo "openresty编译完成"
fi
