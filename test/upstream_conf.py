# python3
# -*- coding:utf-8 -*-
"""第三方访问设置"""
import config

if config.RUN_TIME == "mock":
    Server = {"host": "example.com", "uri": "http://127.0.0.1:9000"}

elif config.RUN_TIME == "develop":
    Server = {"host": "example.com", "uri": "http://www.example.com"}

elif config.RUN_TIME == "pre-release":
    Server = {"host": "example.com", "uri": "http://www.example.com"}

elif config.RUN_TIME == "release":
    Server = {"host": "example.com", "uri": "http://www.example.com"}
