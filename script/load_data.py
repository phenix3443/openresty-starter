# python3
# -*- coding:utf-8 -*-
# author:phenix3443+github.com
"""将文件数据载入数据库
"""
import logging
import datetime
import os
from cloghandler import ConcurrentRotatingFileHandler

import log_cfg

logger = logging.getLogger("load_data_to_db")


def handle_small_file():
    "这种办法只适合处理行数比较少的文件"
    data = "data.txt"
    logger.info("start handle {}".format(data))

    cursor = conn.cursor()
    with open(data, "r") as f:
        once = 20000  # 一次处理数据
        uids = [int(line.split()[0]) for line in f]
        count = len(uids)

        stmt = "update exmple set <field>=1 where <field> in ({});"
        for i in range(0, count, once):
            start = i
            end = i + once
            cursor.execute(stmt.format(",".join(uids[start:end])))
        else:
            start = i
            end = count
            cursor.execute(stmt.format(",".join(uids[start:end])))

    logger.info("finish handle {}".format(data))


def handle_big_file():
    data = "data.txt"
    logger.info("start handle {}".format(data))
    cursor = conn.cursor()
    with open(data, "r") as f:
        # 这种方法适合处理大文件
        once = 20000  # 一次处理的行数
        stmt = "update example set not_login_days=%s where user_id=%s;"
        data = []
        for i, line in enumerate(f, 1):
            if i % once == 0:
                logger.info("line:%s", i)
                cursor.executemany(stmt, data)
                data = []
            s = line.split()
            data.append((int(s[1]), int(s[0])))

        if len(data) > 0:
            cursor.executemany(stmt, data)

    logger.info("finish handle {}".format(data))
    pass


if __name__ == "__main__":
    logfile = os.path.join(
        config.PROJECT_DIR,
        "logs/exampe_{}.log".format(datetime.date.today().strftime("%Y%m%d")),
    )

    handler = ConcurrentRotatingFileHandler(logfile, "a", 1024 * 1024 * 1024, 1000)

    fmt = logging.Formatter(
        "[%(asctime)s] [%(levelname)s] [%(module)s:%(lineno)d] %(message)s"
    )

    handler.setFormatter(fmt)

    logger.addHandler(handler)
    logger.setLevel(logging.INFO)

    main()
