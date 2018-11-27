# -*-coding:utf-8 -*-
# author:phenix3443+github@gmail.com
# desc: openresty 项目打包脚本

install(
  # nginx相关文件
  DIRECTORY nginx/
  DESTINATION nginx
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.conf"
  PATTERN "*.cron"
  PATTERN "*.crt"
  PATTERN "*.key"
  PATTERN "*.lua"
  PATTERN "*.sh"
  PATTERN "*.so*"
  PATTERN "*.pb"
  PATTERN "*.thrift"
  PATTERN "*.mmdb"
  PATTERN "*.py"
  PATTERN "*.pre"
  )

install(
  # 相关脚本
  DIRECTORY script/
  DESTINATION script
  USE_SOURCE_PERMISSIONS
  )
