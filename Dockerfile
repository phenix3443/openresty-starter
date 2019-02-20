# -*- coding:utf-8 -*-
ARG IMAGE_BASE="openresty/openresty"
ARG IMAGE_TAG="1.13.6.2-2-centos"

FROM ${IMAGE_BASE}:${IMAGE_TAG}

LABEL maintainer="phenix3443 <phenix3443@gmail.com>"

WORKDIR /usr/local/openresty/nginx/

ADD conf/project.proxy.nginx.conf conf/project.proxy.nginx.conf
ADD conf/nginx.conf conf/nginx.conf
ADD conf/vhosts conf/vhosts
ADD lua lua
ADD lib lib

RUN yum install -y gcc; \
    && sh -c nginx/lib/luarocks.sh
