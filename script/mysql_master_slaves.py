# python3
# -*- coding:utf-8 -*-
# author:刘尚亮
"""
"""
import logging
import random
import mysql.connector

logger = logging.getLogger(__name__)


class MasterSlaves():
    """主从实例进程"""

    def __init__(self, cfg):
        self.master = mysql.connector.connect(**cfg["master"])
        self.master.autocommit = True

        self.slaves = []
        for slave_cfg in cfg["slaves"]:
            conn = mysql.connector.connect(**slave_cfg)
            self.slaves.append(conn)

    def get_master(self):
        """获取master实例"""
        return self.master

    def get_slave(self):
        """获取slave实例"""
        slave = None
        if self.slaves:
            slave = random.choice(self.slaves)

        return slave

    def __del__(self):
        """析构函数"""
        self.master.close()
        for conn in self.slaves:
            conn.close()


if __name__ == "__main__":
    pass
