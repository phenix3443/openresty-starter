#!/usr/bin/env bash
# -*-coding:utf-8-*-
# author:phenix3443+github@gmail.com
# description: nginx http server.
# Settings nginx
SERVER_NAME="example-bin"
SCRIPT_DIR=$(cd $(dirname $0);pwd)
NGINX_DIR=$(cd ${SCRIPT_DIR}/../;pwd)
DT=$(date +'%Y-%m-%dT%H:%M:%S')

num=$(ps -ef | grep ${SERVER_NAME} | grep -vE 'grep|monitor' | wc -l)
echo ${num}
if [ ${num} -lt 1 ];then
    echo "${DT}, restart nginx now" >> ${NGINX_DIR}/logs/monitor.log
    ${NGINX_DIR}/sbin/${SERVER_NAME}
else
    echo "${DT}, run normal" >> ${NGINX_DIR}/logs/monitor.log
fi
