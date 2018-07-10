#! python3
# -*- coding:utf-8 -*-
# author:pheix3443@gmail.com
"""封装的日志库"""

import logging
from cloghandler import ConcurrentRotatingFileHandler


def get_default_log_fmt():
    """默认的日志格式"""
    fmt = logging.Formatter(
        '[%(asctime)s] [%(levelname)s] [%(module)s:%(lineno)d] %(message)s')
    return fmt


def init_logger(loggers,
                level=logging.DEBUG,
                handler=None,
                fmt=get_default_log_fmt()):
    """loggers 中的定义好的 logger"""
    if not handler:
        handler = logging.StreamHandler()
        handler.setFormatter(fmt)

    handler.setLevel(level)

    for l in loggers:
        l.setLevel(level)
        l.addHandler(handler)


def get_file_handler(logfile, fmt=get_default_log_fmt()):
    """生成默认的日志文件 handler"""
    handler = ConcurrentRotatingFileHandler(logfile, "a", 1024 * 1024 * 1024,
                                            1000)
    handler.setFormatter(fmt)
    return handler


if __name__ == "__main__":
    pass
