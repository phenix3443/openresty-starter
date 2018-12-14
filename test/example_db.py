# -*- coding:utf-8-*-
# author:phenix3443+github@gmail.com
# desc: 爬虫数据库接口

import logging
import mysql.connector

logger = logging.getLogger(__name__)


class ExampleDB():
    """实名数据库"""

    def __init__(self, cfg):
        try:
            self.conn = mysql.connector.connect(
                pool_size=32, autocommit=True, **cfg)

        except mysql.connector.Error as err:
            logger.error(err)

    def get_conn(self):
        return self.conn

    def close(self):
        self.conn.close()

    def example(self, video_item):
        """添加video表"""
        """如果该表中ctime=mtime，表明数据是再次采集的"""
        cursor = self.conn.cursor(dictionary=True)
        stmt = "select %s"

        try:
            cursor.execute(stmt, ("example"))
        except mysql.connector.Error as err:
            logger.error(err)
            return
        else:
            resp = cursor.fetchall()
            return resp
        finally:
            logger.debug(cursor.statement)


if __name__ == "__main__":
    cfg = {
        "host": "127.0.0.1",
        "port": 3306,
        "user": "root",
        "password": "password",
        "database": "example_database",
    }
    r = ExampleDB(cfg)
