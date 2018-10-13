# python3
# -*- coding:utf-8 -*-
# author:phenix3443@gmail.com

import os
import sys
import logging

script_path = os.path.split(os.path.realpath(__file__))[0]
project_path = os.path.normpath("{}/..".format(script_path))

sys.path.insert(0, os.path.join(project_path, "scrip/"))

sub_loggers = []


def add_logger(l):
    sub_loggers.append(l)


sub_modules = [
    "main_db",
    "task_db",
    "resource_db",
    "collect_db",
    "database",
    "xllog",
    "block",
]

for m in sub_modules:
    l = logging.getLogger(m)
    add_logger(l)

main_db = {
    "host": "",
    "port": 3306,
    "user": "root",
    "password": "",
    "database": "test",
}
