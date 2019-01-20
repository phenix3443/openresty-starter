# python3
# -*- coding:utf-8 -*-
"""远场 IS 服务接口测试"""
import logging
import unittest
import json

import config
import upstream_conf
import example_server

logger = logging.getLogger("test_example")  # 这里不要使用"__main__"


class TestExampleServer(unittest.TestCase):
    es = example_server.ExampleServer(upstream_conf.Example)

    def setUp(self):
        pass

    def test_test(self):
        """测试 test 接口"""
        resp = self.es.test_utils()
        logger.debug(json.dumps(resp, indent=4, ensure_ascii=False))


if __name__ == '__main__':
    unittest.main()
