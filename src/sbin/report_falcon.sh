#!/usr/bin/env bash
# -*-coding:utf-8-*-
# author:phenix3443@gmail.com
# description: nginx http server.
# Settings Nginx
SERVER_PORT=1235                # 修改为项目监听端口
SCRIPT_DIR=$(cd $(dirname $0);pwd)

wget "http://127.0.0.1:${SERVER_PORT}/stat/" > /dev/null 2>&1
