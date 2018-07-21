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
