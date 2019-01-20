# -*-coding:utf-8 -*-
# desc: openresty 项目编译打包脚本
cmake_minimum_required(VERSION 3.0)
project(example-project VERSION 0.0.0.1)

# install section
include(install.cmake)
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_GENERATOR "TGZ")

include(CPack)
