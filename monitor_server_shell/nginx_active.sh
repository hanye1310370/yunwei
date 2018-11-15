#!/bin/bash
#application: 检测nginx的活动用户，超过400就记录下来
#name:   nginx_active.sh
#Revision:	0.1
#Date:		2016/12/19
#Author:	hanye
#Email:		hz7726@164.com
#Website:	www.1fangxin.cn
#Description:	Statistics of the top ten IP number and send email to author
#Notes:

#------------------------------------------------------------------------

#Copyright:	2016 (c) fangxin
#License:	GPL

Active=`/usr/bin/curl -s http://127.0.0.1:81/ngx_status | grep "Active" | awk -F: '{print $2}'`
time=`date +%Y%m%d%H%M`
if [ $Active -gt 400 ]; then
  echo  -e "\033[32m  $time:$Active \033[0m" >> /data/sh/nginx_active.txt
fi
    
