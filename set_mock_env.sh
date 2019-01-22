# -*- coding:utf-8-*-
#!/bin/bash
# 建立 mock 环境
DB_CID=$(docker run -d -e MYSQL_ROOT_PASSWORD=sd-9898w mysql:5.7)
CACHE_CID=$(docker run -d --name example-redis redis:4)
MOCK_CID=$(docker create -d --name example --link ${DB_CID}:mysql --link ${CACHE_CID}:redis openresty/openresty:1.13.6.2-2-bionic)
echo "mock_cid: "${MOCK_CID}
docker start ${MOCK_CID}
