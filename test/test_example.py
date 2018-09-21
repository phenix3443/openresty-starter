# python3
# -*- coding:utf-8 -*-
# author:刘尚亮
"""远场IS服务接口测试"""
import logging
import unittest
import json

import config
import dev_env as env
# import pre_env as env
# import online_env as env

import example_server

logger = logging.getLogger(__name__)


class TestExampleServer(unittest.TestCase):
    def setUp(self):
        self.es = example_server.ExampleServer(env.HOST)

    def test_test(self):
        """测试test接口"""
        resp = self.es.test_utils()
        print(json.dumps(resp, indent=4, ensure_ascii=False))


if __name__ == '__main__':
    unittest.main()
