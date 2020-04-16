# python3
# -*- coding:utf-8 -*-
# author:phenix3443+github.com
"""日志配置"""
import logging
import logging.config

import config

LogDir = config.ProjectPath + "/logs/"
SETTINGS = {
    "version": 1,
    "formatters": {
        "verbose": {
            "format": "{asctime} {levelname} {name}:{lineno} {message}",
            "style": "{",
        }
    },
    "handlers": {
        "console": {
            "level": "DEBUG",
            "class": "logging.StreamHandler",
            "formatter": "verbose",
        },
        "file": {
            "level": "DEBUG",
            "class": "cloghandler.ConcurrentRotatingFileHandler",
            "formatter": "verbose",
            "filename": LogDir + "tmp.log",
            "maxBytes": 1024 * 1024,
            "backupCount": 10,
        },
    },
    "loggers": {},
}

MODULES = ["example_db", "falcon"]
TESTS = []

for i in [MODULES, TESTS]:
    for k in i:
        SETTINGS["loggers"][k] = {"handlers": ["console"], "level": "DEBUG"}

logging.config.dictConfig(SETTINGS)
