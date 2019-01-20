# python3
# -*- coding:utf-8 -*-
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
    'loggers': {}
}

MODULES = ["example_server"]
TESTS = ["test_example_server"]

for i in [MODULES, TESTS]:
    for k in i:
        SETTINGS["loggers"][k] = {
            'handlers': ['console'],
            'level': 'DEBUG',
        }
