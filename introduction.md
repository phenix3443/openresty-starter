<!-- -*- coding:utf-8-*- -->

# 概述 #
本项目总结 openresty 日常开发的功能和模块，最终目的是规范和简化开发流程、实现松耦合、高内聚的项目。规范的方面主要包括：

+ 项目结构
+ 项目文档
+ 代码结构
+ 代码文档
+ 单元测试
+ 接口测试
+ 打包部署
+ 统计监控
+ 性能测试

# 目录结构 #

# 使用 #
可以基于该项目进行二次开发。主要改动有：

## READEME.md ##

##  ##

# 部署 #

## 传统 ##

### 安装 openresty ###
考虑到最好在生产环境自行安装 openresty，所以打包好的文件没有 nginx 执行程序。
``` shell
./build_openresty.sh <project-dir>
```

### 打包代码 ###

``` shell
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=<project-dir>
make install
```

## 部署代码 ##
将打包好的文件替换 openresty/nginx 下的同名文件。

如果业务前端有在 nginx 代理，在代理的 nginx.conf 加入以下内容：

``` nginx
include <path-to-project>/project.proxy.nginx.conf;
```

## Docker ##
