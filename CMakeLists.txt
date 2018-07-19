cmake_minimum_required(VERSION 3.0)
project(ad_server VERSION 0.0.0.1) #应该修改此处的project-name和对应的版本号

install(
  # 拷贝编译好的openresty程序
  DIRECTORY openresty-1.13.6.2/
  DESTINATION .
  USE_SOURCE_PERMISSIONS

  )

install(
  # 存放一些常用的脚本
  DIRECTORY tools/
  DESTINATION tools
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.sh"
  PATTERN "*.py"
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
  DIRECTORY src/conf/
  DESTINATION nginx/conf
  # 存放项目的nginx配置文件
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.conf"
  PATTERN "*.cron"
  PATTERN "*.crt"
  PATTERN "*.key"
  )

install(
  DIRECTORY lualib/
  DESTINATION nginx/lualib
  # 存放第三方依赖库
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.lua"
  PATTERN "*.so"
  )

install(
  DIRECTORY src/lua/
  DESTINATION nginx/lua
  USE_SOURCE_PERMISSIONS
  FILES_MATCHING
  PATTERN "*.lua"
  )

set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_GENERATOR "TGZ")

include(CPack)
