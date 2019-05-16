# -*- coding:utf-8 -*-
# author:phenix3443+github@gmail.com

import os
import logging
import logging.config

import log_cfg

SCRIPT_PATH = os.path.split(os.path.realpath(__file__))[0]
PROJECT_PATH = os.path.normpath("{}/script/".format(SCRIPT_PATH))

# sys.path.insert(0, os.path.join(PROJECT_PATH, ""))

logging.config.dictConfig(log_cfg.SETTINGS)

# RUN_TIME = "mock"  #当前环境
# RUN_TIME = "develop"  #当前环境
# RUN_TIME = "pre-release"  #当前环境
RUN_TIME = "release"  #当前环境

if __name__ == '__main__':
    pass
