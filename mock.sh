# -*- coding:utf-8-*-
#!/bin/bash
# 建立 mock 环境
SCRIPT_DIR=$(dirname $0);pwd
PROJECT_DIR=${SCRIPT_DIR}
NGINX_DIR=${PROJECT_DIR}/nginx
nginx_port=1235
echo ${SCRIPT_DIR}

DB_CID=$(docker run \
                -d \
                --restart always \
                -e MYSQL_ROOT_PASSWORD="" \
                mysql:5.7)

CACHE_CID=$(docker run \
                   -d \
                   --restart always \
                   redis:4)

MOCK_CID=$(docker run \
                  -d \
                  --restart always \
                  --name example \
                  --link ${DB_CID}:mysql \
                  --link ${CACHE_CID}:redis \
                  -v ${NGINX_DIR}/conf/project.proxy.nginx.conf:/usr/local/openresty/nginx/conf/project.proxy.nginx.conf \
                  -v ${NGINX_DIR}/conf/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
                  -v ${NGINX_DIR}/conf/vhosts:/usr/local/openresty/nginx/conf/vhosts \
                  -v ${NGINX_DIR}/lua:/usr/local/openresty/nginx/lua \
                  -v ${NGINX_DIR}/lib:/usr/local/openresty/nginx/lib \
                  -v ${NGINX_DIR}/logs:/usr/local/openresty/nginx/logs \
                  -p 9000:80 \
                  openresty/openresty:1.13.6.2-2-centos)


# 使用 luarocks 安装依赖
docker exec example yum install -y gcc
docker exec example sh /usr/local/openresty/nginx/lib/luarocks.sh

echo "example mock cid: "${MOCK_CID}
