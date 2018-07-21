# 获得发行版的名字
function(get_distribution_name rtn)
  find_program(LSB_RELEASE_EXEC lsb_release)
  execute_process(COMMAND ${LSB_RELEASE_EXEC} -is
    OUTPUT_VARIABLE release_name
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  set(${rtn} ${release_name} PARENT_SCOPE)
endfunction()

# 安装openresty
function(doinstall src_file)
  get_distribution_name(osr)
  if((osr STREQUAL "LinuxMint") OR (osr STREQUAL "LinuxUbuntu"))
    message(STATUS "当前操作系统是：mint")
    execute_process(COMMAND sudo apt-get install libpcre3-dev libssl-dev perl make build-essential curl)

  elseif(osr STREQUAL "CentOS")
    message(STATUS "当前操作系统是 centos")
    execute_process(COMMAND sudo yum install -y pcre-devel openssl-devel gcc curl)

  else()
    message(FATAL_ERROR "does not support:${osr}")
  endif()

  message(STATUS "+++${src_file}")
  execute_process(COMMAND tar zxf ${src_file})
  execute_process(COMMAND cd openresty-1.13.6.2)
  execute_process(COMMAND pwd)

endfunction()

# 判断openresty是否安装
function(is_install rtn)
  if(EXISTS "${CMAKE_INSTALL_PREFIX}/nginx")
    message(STATUS "openresty已经安装")
    set(${rtn} N PARENT_SCOPE)
  else()
    message(STATUS "openresty尚未安装")
    set(${rtn} N PARENT_SCOPE)
  endif()
endfunction()

is_install(ok)
if(NOT ok)
  doinstall("/data/xunlei/gitlab/onecloud/ad_server/openresty-1.13.6.2.tar.gz")
endif()
