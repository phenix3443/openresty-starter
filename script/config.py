# -*- coding:utf-8 -*-
# author:phenix3443+github@gmail.com

import os
import sys


ScriptPath = os.path.split(os.path.realpath(__file__))[0]
ProjectPath = os.path.normpath("{}/..".format(ScriptPath))

sys.path.insert(0, os.path.join(ProjectPath, "script/"))



# RUN_TIME = "mock"  #当前环境
# RUN_TIME = "develop"  #当前环境
# RUN_TIME = "pre-release"  #当前环境
RUN_TIME = "release"  #当前环境

if __name__ == '__main__':
    pass
