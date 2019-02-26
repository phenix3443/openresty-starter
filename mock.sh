# -*- coding:utf-8-*-
#!/bin/bash
# 建立本地 mock 环境
PROJECT="example"
PORT=9000

SCRIPT_DIR=$(cd $(dirname $0);pwd)
PROJECT_DIR=${SCRIPT_DIR}
NGINX_DIR=${PROJECT_DIR}/nginx

# 自定义 mock 网络
# docker network create --driver bridge mock

# 本地通用的 mysql docker，避免开启多个
# docker run -d --name mysql-5.7 --network mock --network-alias mysql-5.7 --restart always -e MYSQL_ROOT_PASSWORD="test" mysql:5.7

# 使用本地通用的 redis，避免开启多个
# docker run -d --name redis-4  --network mock --network-alias redis-4 --restart always redis:4

docker run \
       -d \
       --name ${PROJECT} \
       --network mock \
       --network-alias example \
       -v ${NGINX_DIR}/conf/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
       -v ${NGINX_DIR}/conf/vhosts:/usr/local/openresty/nginx/conf/vhosts \
       -v ${NGINX_DIR}/lua:/usr/local/openresty/nginx/lua \
       -v ${NGINX_DIR}/lib:/usr/local/openresty/nginx/lib \
       -v ${NGINX_DIR}/logs:/usr/local/openresty/nginx/logs \
       -p ${PORT}:80 \
       openresty/openresty:1.13.6.2-2-centos  && \
       docker exec ${PROJECT} yum install -y gcc  && \ # 使用 luarocks 安装依赖
       docker exec ${PROJECT} sh /usr/local/openresty/nginx/lib/luarocks.sh

# reload mock server
# docker exec ${PROJECT} /usr/bin/openresty -s reload
