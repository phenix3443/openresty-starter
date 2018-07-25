#!/usr/bin/env bash
# -*-coding:utf-8-*-
# author:liushangliang@xunlei.com
# description: nginx http server.
# Settings Nginx
SERVER_NAME="ad_server"
SCRIPT_DIR=$(cd $(dirname $0);pwd)
wget "http://127.0.0.1:8080/stat/" > /dev/null 2>&1
