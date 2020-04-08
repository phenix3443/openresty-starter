# python3
# -*- coding:utf-8 -*-
"""远场 IS 服务接口测试
python3 -m unittest
"""
import logging
import unittest
import json

import config
import upstream_conf
import server

logger = logging.getLogger("test")  # 这里不要使用"__main__"


class TestServer(unittest.TestCase):
    srv = server.Server(upstream_conf.Example)

    def setUp(self):
        pass

    def test_test(self):
        """测试 test 接口"""
        resp = self.srv.test_utils()
        logger.debug(json.dumps(resp, indent=4, ensure_ascii=False))


if __name__ == "__main__":
    unittest.main()
