#!/bin/bash
#file    lsyncd_status_failed.sh
#name     han
#crontab time 16:28
#version    1.0
ipconfig=`ifconfig  eth2| sed -n "2p"| awk -F: '{print $2}'|awk '{print $1}'`
TIME=`date +%Y%m%d%H%M`
echo  -e "\033[31m $ipconfig SERVER $TIME There is an error\033[0m " > /data/sh/.no_lsync_faied.txt
grep -i -E "failed|error" /data/mysql/project_nginx.log 
if [ $? == 0 ]; then
      grep -i -E "failed|error" /data/mysql/project_nginx.log >> /data/sh/.no_lsync_faied.txt
      mail -s "169Server lsyncd error" hz7726@163.com < /data/sh/.no_lsync_faied.txt
   else
       exit 1
fi
