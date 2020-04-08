#!/usr/bin/env bash
# -*-coding:utf-8-*-
# author:phenix3443+github@gmail.com
# description: nginx http server.
# Settings nginx

SCRIPT_DIR=$(cd $(dirname $0);pwd)
PROJECT_DIR=$(cd ${SCRIPT_DIR}/../;pwd)
DT=$(date +'%F %R:%S')
PROJECT=<custom>

num=$(ps -ef | grep ${PROJECT} | grep -vE 'grep|monitor' | wc -l)
if [ ${num} -lt 1 ];then
    echo "${DT}, ${PROJECT} restarting" >> ${PROJECT_DIR}/logs/monitor.log
    ${PROJECT_DIR}/sbin/nginx
else
    echo "${DT}, ${PROJECT} running" >> ${PROJECT_DIR}/logs/monitor.log
fi
