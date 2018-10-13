#!/usr/bin/env bash
# -*-coding:utf-8-*-
# author:phenix3443+github@gmail.com
# description: nginx http server.
# Settings Nginx
SERVER_NAME="app_config"
SCRIPT_DIR=$(cd $(dirname $0);pwd)
NGINX_DIR=$(cd ${SCRIPT_DIR}/../;pwd)

echo "monitor checking"
num=$(ps -ef | grep ${SERVER_NAME} | grep -vE 'grep' | wc -l)
if [ ${num} -lt 1 ];then
    datetime=`date +'%Y-%m-%dT%H:%M:%S'`
    echo "${datetime}, restart nginx now" >> ${NGINX_DIR}/logs/start.log
    restart
fi
