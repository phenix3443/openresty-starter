# python3
# -*- coding:utf-8 -*-
# author:phenix3443@gmail.com
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
        "test_example": {
            'handlers': ['console'],
            'level': 'DEBUG',
        },
        "example_server": {
            'handlers': ['console'],
            'level': 'DEBUG',
        },
    }
}
