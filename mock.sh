# -*- coding:utf-8-*-
#!/bin/bash
# 建立 mock 环境
SCRIPT_DIR=$(dirname $0);pwd
PROJECT_DIR=${SCRIPT_DIR}
NGINX_DIR=${PROJECT_DIR}/nginx
nginx_port=1235
echo ${SCRIPT_DIR}

DB_CID=$(docker run -d \
                --name example-mysql \
                --restart always \
                -e MYSQL_ROOT_PASSWORD="" \
                mysql:5.7)

CACHE_CID=$(docker run -d \
                   --restart always \
                   --name example-redis \
                   redis:4)

MOCK_CID=$(docker run -d \
                  --name example \
                  --restart always \
                  --link example-mysql:mysql \
                  --link example-redis:redis \
                  -v ${NGINX_DIR}/conf/project.proxy.nginx.conf:/usr/local/openresty/nginx/conf/project.proxy.nginx.conf \
                  -v ${NGINX_DIR}/conf/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
                  -v ${NGINX_DIR}/conf/vhosts:/usr/local/openresty/nginx/conf/vhosts \
                  -v ${NGINX_DIR}/lua:/usr/local/openresty/nginx/lua \
                  -v ${NGINX_DIR}/lib:/usr/local/openresty/nginx/lib \
           openresty/openresty:1.13.6.2-2-centos)

# echo "mock_cid: "${MOCK_CID}
