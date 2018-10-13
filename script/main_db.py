#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# author:phenix3443+github@gmail.com
"""mysql数据库接口"""
import logging
import mysql.connector

import config
import xllog

logger = logging.getLogger(__name__)


class MainDB():
    def __init__(self, cfg):
        self.conn = mysql.connector.connect(
            pool_name="main_db_poll", pool_size=32, **cfg)
        self.conn.autocommit = True

    def get_conn(self):
        return self.conn

    def __del__(self):
        self.conn.close()

    def get_version(self):
        """"""
        cursor = self.conn.cursor(dictionary=True)
        stmt = "select version();"
        logger.debug(stmt)
        cursor.execute(stmt)
        row = cursor.fetchone()
        logger.debug(row)
        return row


if __name__ == "__main__":
    config.add_logger(logger)
    xllog.init_logger(config.sub_loggers)

    mdb = MainDB(config.main_db)
    cursor = mdb.get_conn().cursor()
    res = mdb.get_version()
    print(res)
