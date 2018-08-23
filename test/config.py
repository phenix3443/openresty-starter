# -*- coding:utf-8-*-
# author:liushangliang@xunlei.com

import os
import sys
import time
import logging

SCRIPT_PATH = os.path.split(os.path.realpath(__file__))[0]
PROJECT_PATH = os.path.normpath("{}/..".format(SCRIPT_PATH))

LOGGERS = []


def add_logger(l):
    LOGGERS.append(l)


SUB_MODULES = [
    "example_server",
]

for m in SUB_MODULES:
    l = logging.getLogger(m)
    add_logger(l)
