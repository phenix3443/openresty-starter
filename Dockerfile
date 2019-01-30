# -*- coding:utf-8 -*-
ARG IMAGE_BASE="openresty/openresty"
ARG IMAGE_TAG="1.13.6.2-2-centos"

FROM ${IMAGE_BASE}:${IMAGE_TAG}
RUN yum install -y gcc; \
    sh -c nginx/lib/luarocks.sh
