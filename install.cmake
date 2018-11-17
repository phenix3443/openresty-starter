# -*-coding:utf-8 -*-
# author:phenix3443+github@gmail.com
# desc: openresty 项目打包脚本

# install(CODE "execute_process(COMMAND bash \"-c\" ${PROJECT_SOURCE_DIR}/build_openresty.sh ${CMAKE_INSTALL_PREFIX})")

install(
  # nginx相关文件
  DIRECTORY nginx
  DESTINATION nginx
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.conf"
  PATTERN "*.cron"
  PATTERN "*.crt"
  PATTERN "*.key"
  PATTERN "*.lua"
  PATTERN "*.sh"
  )

install(
  # 存放第三方依赖库
  DIRECTORY lib/
  DESTINATION nginx/lib
  USE_SOURCE_PERMISSIONS
  )

install(
  # lua代码存放目录
  DIRECTORY src/lua/
  DESTINATION nginx/lua
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.lua"
  )
