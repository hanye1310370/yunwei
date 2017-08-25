#!/bin/bash

#-------------------------------------------------------------------------
#application：   检测nginx访问ip地址并记录发邮件
#Filename:	     count_ip.sh
#Revision:	     0.1
#Date:		     2016/12/19
#Author:	     hanye
#Email:		     hz7726@164.com
#Website:	     www.1fangxin.cn
#Description:	Statistics of the top ten IP number and send email to author
#crontab：     */5 * * *　* count_ip.sh  > /dev/null 2>&1
#Notes:

#------------------------------------------------------------------------

#Copyright:	2016 (c) fangxin
#License:	GPL

NGINX_DIR=/data/nginx/nginx_access
COUNT_IP_DIR=$NGINX_DIR/ip
TIME=`date -d "yesterday" +%Y%m%d`
 awk '{print $1}' $NGINX_DIR/access.log | sort | uniq -c | sort -nr |wc -l >  $COUNT_IP_DIR/$TIME.log
 awk '{print $1}' $NGINX_DIR/access.log | sort | uniq -c | sort -nr |head -n 200 >> $COUNT_IP_DIR/$TIME.log
/bin/sh	/data/sh/cut_nginx_logs.sh

/etc/init.d/postfix restart

cat $COUNT_IP_DIR/$TIME.log | mail -s "`date +%Y/%m/%d`:count_ip zsh-web-1" hz7726@163.com
sleep 20s
/etc/init.d/postfix stop

