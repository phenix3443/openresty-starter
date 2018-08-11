#!/usr/bin/env bash
# -*-coding:utf-8-*-
# author:liushangliang@xunlei.com
# description: nginx http server.
# Settings Nginx
SERVER_NAME="project_name"      # 此处需要修改为项目名
SCRIPT_DIR=$(cd $(dirname $0);pwd)
NGINX_DIR=$(cd ${SCRIPT_DIR}/../;pwd)
NGINX_CONF=${NGINX_DIR}/conf/nginx.conf
NGINX_BIN="${NGINX_DIR}/sbin/nginx -c ${NGINX_CONF} -p ${NGINX_DIR}"
RETVAL=0

start() {
    echo "${SERVER_NAME} starting: "
    mkdir -p /dev/shm/nginx_temp
    ${NGINX_BIN}
    RETVAL=$?
    echo
    return $RETVAL
}

stop() {
    echo "${SERVER_NAME} stopping: "
    ${NGINX_BIN} -s stop
    rm -rf /dev/shm/nginx_temp
    RETVAL=$?
    echo
    return $RETVAL
}

reload(){
    echo "${SERVER_NAME} reloading: "
    ${NGINX_BIN} -s reload
    RETVAL=$?
    echo
    return $RETVAL
}

restart(){
    stop
    start
}

testconfig(){
    echo "${SERVER_NAME} config test: "
    ${NGINX_BIN} -t
    return 0
}
monitor(){
    echo "monitor starting"
    num=$(ps -ef | grep ${SERVER_NAME} | grep -vE 'grep|ngx.sh' | wc -l)
    if [ ${num} -lt 1 ];then
        datetime=`date +'%Y-%m-%dT%H:%M:%S'`
        echo "${datetime}, restart nginx now" >> ${NGINX_DIR}/logs/start.log
        restart
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    reload)
        reload
        ;;
    restart)
        restart
        ;;
    testconfig)
        testconfig
        ;;
    monitor)
        monitor
        ;;
    *)
        echo $"Usage: $0 {start|stop|reload|restart|testconfig|monitor}"
        RETVAL=1
esac

exit $RETVAL
