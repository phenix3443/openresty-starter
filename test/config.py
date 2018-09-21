# -*- coding:utf-8-*-
# author:liushangliang@xunlei.com

import os
import sys
import logging
import logging.config

SCRIPT_PATH = os.path.split(os.path.realpath(__file__))[0]
PROJECT_PATH = os.path.normpath("{}/..".format(SCRIPT_PATH))

sys.path.insert(0, os.path.join(PROJECT_PATH, "test/"))

logging.config.dictConfig({
    "version": 1,
    "formatters": {
        'verbose': {
            'format': '{asctime} {levelname} {name}:{lineno} {message}',
            'style': '{',
        },
    },
    'handlers': {
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'verbose'
        },
    },
    'loggers': {
        "__main__": {
            'handlers': ['console'],
            'level': 'DEBUG',
        },
        # 下面添加其他模块
    }
})
