# -*- coding:utf-8-*-
# author:phenix3443+github@gmail.com
# desc:服务接口
# doc:
import requests
import logging
import json

logger = logging.getLogger(__name__)


class ExampleServer:
    """要测试的服务"""

    def __init__(self, cfg):
        self.uri = cfg["uri"]
        self.headers = {
            "Host": cfg["host"],
            "Accept-Language": "zh-Hans-CN;q=1, zh-Hant-CN;q=0.9, en-CN;q=0.8",
        }

    def __del__(self):
        pass

    def test_utils(self):
        """测试接口"""
        url = "{}/test/utils".format(self.uri)
        params = {}
        data = {}
        r = requests.post(url, headers=self.headers, params=params, data=data)
        resp = r.json()
        return resp

    # 下面是接口


if __name__ == '__main__':
    pass
