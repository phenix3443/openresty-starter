# -*-coding:utf-8 -*-
# author:phenix3443@gmail.com
# desc: openresty 项目打包脚本

install(
  # 编译后的openresty目录
  DIRECTORY openresty/
  DESTINATION ./
  USE_SOURCE_PERMISSIONS
  )

install(
  # 存放程序运行控制脚本，start,stop,resetart,monitor等
  DIRECTORY src/sbin/
  DESTINATION nginx/sbin
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.sh"
  )

install(
  # 存放项目的nginx配置文件
  DIRECTORY src/conf/
  DESTINATION nginx/conf
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.conf"
  PATTERN "*.cron"
  PATTERN "*.crt"
  PATTERN "*.key"
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