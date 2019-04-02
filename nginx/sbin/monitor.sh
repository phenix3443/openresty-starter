#!/usr/bin/env bash
# -*-coding:utf-8-*-
# author:phenix3443+github@gmail.com
# description: nginx http server.
# Settings nginx
SERVER_NAME="example-bin"
SCRIPT_DIR=$(cd $(dirname $0);pwd)
PROJECT_DIR=$(cd ${SCRIPT_DIR}/../;pwd)
DT=$(date +'%F %R:%S')

num=$(ps -ef | grep ${SERVER_NAME} | grep -vE 'grep|monitor' | wc -l)

if [ ${num} -lt 1 ];then
    echo "${DT}, restarting" >> ${PROJECT_DIR}/logs/monitor.log
    ${PROJECT_DIR}/sbin/${SERVER_NAME}
else
    echo "${DT}, running" >> ${PROJECT_DIR}/logs/monitor.log
fi
