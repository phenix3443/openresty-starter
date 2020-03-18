#!/usr/bin/env bash
# -*-coding:utf-8-*-
# author:phenix3443+github@gmail.com
# description: nginx http server.
# Settings Nginx
HOST=inner.local
PORT=8080
curl -H "Host:${HOST}" http://127.0.0.1:${PORT}/stat
