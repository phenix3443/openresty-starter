# -*- coding:utf-8-*-

import os
import sys
import logging
import logging.config

import log_cfg

SCRIPT_PATH = os.path.split(os.path.realpath(__file__))[0]
PROJECT_PATH = os.path.normpath("{}/..".format(SCRIPT_PATH))

sys.path.insert(0, os.path.join(PROJECT_PATH, "test/"))

logging.config.dictConfig(log_cfg.SETTINGS)

RUN_TIME = "pre-release"  #当前环境

if __name__ == '__main__':
    pass
