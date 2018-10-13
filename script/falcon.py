#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# author:phenix3443@gmail.com
"""mysql数据库接口"""

import os
import json
import requests

agent = {
    "host": "127.0.0.1",
    "port": 1988,
}


def get_hostname():
    res_command = os.popen('hostname').read().strip()
    return res_command if res_command else 'unknown'


def report(payloads):
    agent_url = "http://{}:{}/v1/push".format(agent["host"], agent["port"])
    r = requests.post(agent_url, data=json.dumps(payloads))
    print(r.text)
