# python3
# -*- coding:utf-8 -*-
# author:phenix3443+github@gmail.com

import config

if config.RUN_TIME == "develop":
    EXAMPLE_DB = {
        "host": "127.0.0.1",
        "port": 3306,
        "user": "root",
        "password": "",
        "database": "example_database",
    }

    FALCON = {
        "host": "",
        "uri": "http://127.0.0.1:30976",
    }

elif config.RUN_TIME == "pre-release":
    EXAMPLE_DB = {
        "host": "127.0.0.1",
        "port": 3306,
        "user": "root",
        "password": "",
        "database": "example_database",
    }

    FALCON = {
        "host": "",
        "uri": "http://127.0.0.1:30976",
    }

elif config.RUN_TIME == "release":
    EXAMPLE_DB = {
        "host": "127.0.0.1",
        "port": 3306,
        "user": "root",
        "password": "",
        "database": "example_database",
    }

    FALCON = {
        "host": "",
        "uri": "http://127.0.0.1:30976",
    }
