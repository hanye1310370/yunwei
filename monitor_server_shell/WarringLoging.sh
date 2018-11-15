#!/bin/bash
##############################################
#Author: hanye
#Email:  hz7726@163.com
#Last modified: 2018/11/15/14:42
#Filename: WarringLoging.sh
#Revision:  0.1
#Description: 
#crontab: * * * * * WarringLoging.sh
#Website:   www.hz7726.net
#License: GPL
##############################################
eval `/usr/bin/curl -s "http://ip.taobao.com/service/getIpInfo.php?ip=${SSH_CLIENT%% *}" | jq . | awk -F':|[ ]+|"' '$3~/^(country|area|region|city|isp)$/{print $3"="$7}'`

EMAIL='/data/soft/sendEmail-v1.56/sendEmail'
FEMAIL="hz7726@163.com" #发件邮箱
MAILP="passwd"     #发邮件邮箱密码
MAILSMTP="smtp.exmail.qq.com" #发件邮箱的SMTP
MAILT="hz7726@163.com" #收件邮箱
MAILmessage="登入者IP地址：${SSH_CLIENT%% *}\n\
IP归属地：${country}_${area}_${region}_${city}_${isp}\n\
被登录服务器IP：$(curl -s ip.cn| grep -Eo '([0-9]{1,3}[\.]){3}[0-9]{1,3}')"
$EMAIL -q -f $FEMAIL -t $MAILT -u "您服务器有人登录SSH" -m "$MAILmessage"   -o tls=no -s $MAILSMTP -o message-charset=utf-8 -xu $FEMAIL -xp $MAILP
