#!/bin/bash

#-------------------------------------------------------------------------
#application:   检查linux是否被入侵的工具，监控命令是否被替换
#Filename:	    chkrootkit_everyday.sh
#Revision:	    0.1
#Date:		    2017/04/05
#Author:	    hanye	
#Email:		    hz7726@163.com
#Website:	    www.hz726.cn
#Description:	Check whether the site is rootkit infection
#Notes:
#crontab:     */5 * * * *  chkrootkit_everyday.sh
#------------------------------------------------------------------------

#Copyright:	201 (c)  www.1fangxin.cn
#License:	GPL
TIME="`date +%Y%m%d%H%M`"
/usr/bin/chkrootkit -n > /data/sh/.chkrootkitLog/.chkrootkit_$TIME.log

if [ "`grep 'INFECTED' /data/sh/.chkrootkitLog/.chkrootkit_$TIME.log`" != "" ];then
echo "Dangerous"
/etc/init.d/postfix start
echo 'rootkit infection!' | mutt -s 'Chkrootkit zsh-web-1'  -a "/data/sh/.chkrootkit_$TIME.log"  -- hz7726@163.com
sleep 10s
/etc/init.d/postfix stop

else
echo "OK"
fi
