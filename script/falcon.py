#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# author:phenix3443+github@gmail.com
"""falcon上报接口"""

import json
import socket
import time
import logging
import requests

HOSTNAME = socket.gethostname()

logger = logging.getLogger(__name__)


class Falcon():
    def __init__(self, cfg):
        self.url = "{}/v1/push".format(cfg["uri"])

    def report_example(self, count):
        payloads = [{
            "endpoint": HOSTNAME,
            "metric": "example_metric",
            "timestamp": int(time.time()),
            "step": 60,
            "value": count,
            "counterType": "GAUGE",
            "tags": "project=example-project"
        }]
        logger.debug(payloads)
        r = requests.post(self.url, data=json.dumps(payloads))
        if r.status_code != 200:
            logger.debug(r.text)


if __name__ == '__main__':
    pass
