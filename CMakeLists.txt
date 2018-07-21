cmake_minimum_required(VERSION 3.0)
project(ad_server VERSION 0.0.0.1) #应该修改此处的project-name和对应的版本号

# build section

# install section

install(SCRIPT install_openresty.cmake)

# install(SCRIPT install_code.cmake)

# include(InstallRequiredSystemLibraries)
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_GENERATOR "TGZ")

include(CPack)
