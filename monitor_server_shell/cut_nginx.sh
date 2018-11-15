#!/bin/bash
#This script used to cut nginx logs and compress logs during the first day of a month.
#Add crond: 0 0 * * * root /bin/bash /cut_log.sh
#Thu 2010+1 81
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

NGINX_PID=`ps aux | grep 'nginx: master' | grep -v 'grep nginx' | awk '{print $2}'`
LOGS_PATH="/data/logs/nginx"
mkdir -p ${LOGS_PATH}/$(date  -d "yesterday"  +"%Y")/$(date  -d "yesterday" +"%m")/
mv ${LOGS_PATH}/access.log ${LOGS_PATH}/$(date  -d "yesterday" +"%Y")/$(date  -d "yesterday"  +"%m")/$(date  -d "yesterday"  +"%Y%m%d").log
cd ${LOGS_PATH}/$(date  -d "yesterday" +"%Y")/$(date  -d "yesterday"  +"%m")
tar jcvf $(date  -d "yesterday"  +"%Y%m%d").log.tar.bz2 $(date  -d "yesterday"  +"%Y%m%d").log
sleep 10s
rm $(date  -d "yesterday"  +"%Y%m%d").log -f
kill -USR1 $NGINX_PID
##    Del the modified files before 180 days
find $LOGS_PATH/$(date  -d "yesterday"  +"%Y")/*  -type d -mtime +30  -exec rm -rf {} \;
#find $LOGS_PATH/2016/*  -type d -mtime +180 -exec rm -rf {} \;
