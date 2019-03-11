#!/bin/bash
#set -x
# 该脚本在每个整点执行

log_dir=<example>/nginx/logs
pid_file=<example>/nginx/logs/nginx.pid

# 如果 date +"%Y%m%d_%H:%M:%S"输出为 20171208_20:00:05
# 则 cur_hour 为 20171208_20, last_hour 为 20171208_19
cur_hour=$(date +"%Y%m%d_%H" -d "next minute")
last_hour=$(date +"%Y%m%d_%H" -d "59 minute ago")


# 对日志目录文件名符合模式'project.access*.log 或'project.error*.log' 且 类型为普通文件或符号链接的文件作日志切割
for file in $(find $log_dir -maxdepth 1 \( -iname 'project.access*.log' -o -iname 'project.error*.log' \) \( -type l -o -type f \))
do
    bname=`basename $file`

    # 首次创建的日志文件不是符号链接, 以 last_hour 为后缀直接重命名
    if [ -f "$file" -a ! -e "$log_dir/${bname}.${last_hour}" ]; then
        mv $log_dir/$bname{,.$last_hour}
    fi

    # 当前小时的日志文件已经存在, 需要留意
    if [ -e "$log_dir/${bname}.${cur_hour}" ]; then
        echo "careful $log_dir/${bname}.${cur_hour} exists !"
    fi

    # 创建当前小时的日志文件, 并用对应的符号链接指向实际文件
    touch $log_dir/${bname}.${cur_hour}
    ln -s -f $log_dir/$bname{.$cur_hour,}
done


# 发送指令告知 nginx 重新打开日志文件
kill -USR1 `cat ${pid_file}`

# 删除任何修改时间在 7 天以前且名字符合模式'*.log*'的文件或目录
for oldfiles in $(find $log_dir -mtime +5 -iname '*.log*')
do
    echo $oldfiles
    rm -rf $oldfiles
done
