# python3
# -*- coding:utf-8 -*-
"""第三方访问设置"""
import config

if config.RUN_TIME == "mock":
    Example = {
        "host": "example.com",
        "uri": "http://127.0.0.1:9000/service/bubble",
    }

elif config.RUN_TIME == "develop":
    Example = {
        "host": "example.com",
        "uri": "http://www.example.com",
    }

elif config.RUN_TIME == "pre-release":
    Example = {
        "host": "example.com",
        "uri": "https://www.example.com",
    }
elif config.RUN_TIME == "release":
    Example = {
        "host": "example.com",
        "uri": "https://www.example.com",
    }
