# python3
# -*- coding:utf-8 -*-
# author:phenix3443+github.com
"""日志配置"""

SETTINGS = {
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
        "main_db": {
            'handlers': ['console'],
            'level': 'DEBUG',
        },
    }
}
