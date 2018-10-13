# python3
# -*- coding:utf-8 -*-
# author:phenix3443+github@gmail.com

import os
import logging
import logging.config

import log_cfg

SCRIPT_PATH = os.path.split(os.path.realpath(__file__))[0]
PROJECT_PATH = os.path.normpath("{}/script/".format(SCRIPT_PATH))

logging.config.dictConfig(log_cfg.SETTINGS)

if __name__ == '__main__':
    pass
