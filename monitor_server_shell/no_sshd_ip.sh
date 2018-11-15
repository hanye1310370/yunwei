#!/bin/bash

#-------------------------------------------------------------------------
#application: 检测ssh暴力破解，如果登录密码输入错误超过5次，就拉黑
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



SECURE_LOG=/var/log/secure
FAILED_LOGIN_IP=/data/sh/failed_login_ip.txt
SUCCESSFUL_LOGIN_IP=/data/sh/successful_login_ip.txt
NO_SSHD_IP=/data/sh/no_sshd_ip.txt
TIME=`date +%Y%m%d%H`
awk -F : '{print $4}' $SECURE_LOG |grep "Failed password for" |awk '{print $6}'|sort |uniq -c > $FAILED_LOGIN_IP
#Find out the IP failure login times greater than 50 
awk '{if ($1 > 5) print $2}'  $FAILED_LOGIN_IP > $NO_SSHD_IP
	for ip in `cat $NO_SSHD_IP`
	 	do 
	echo sshd:$ip >> /etc/hosts.deny
	echo "#$TIME"   >> /etc/hosts.deny
	done
cat $SECURE_LOG |grep Accepted >> $SUCCESSFUL_LOGIN_IP
echo $TIME >> $SUCCESSFUL_LOGIN_IP
cat /dev/null > $SECURE_LOG
cat $SUCCESSFUL_LOGIN_IP|grep ssh2|grep  -v 192.168|grep 127.0.0.1 |grep ::1  > /data/sh/unknow_ip.txt
cat /data/sh/successful_login_ip.txt  >> /data/sh/successful_login_ip.txt.bak
cat /dev/null > /data/sh/successful_login_ip.txt
UNKNOW_IP=`cat /data/sh/unknow_ip.txt`
SIZE=`du -sk /data/sh/unknow_ip.txt|awk '{print $1}'`
printf $SIZE
if [  $SIZE  != "0"  ];then
	/etc/init.d/postfix	restart
	echo "cat $UNKNOW_IP" | mail -s "Danger,UNKNOW_IP was found! zsh-web-1" hz7726@163.com
sleep 30s
	/etc/init.d/postfix stop
else
	exit 1
fi

