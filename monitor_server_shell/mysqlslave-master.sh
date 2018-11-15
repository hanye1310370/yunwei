#!/bin/bash
#application:   监控mysql主从复制,检测失败就重启，否则就发送邮件
#check          MySQL_Slave Status
#Revision:	    0.1
#Date:		    2016/12/19
#Author:	    hanye
#Email:		    hz7726@164.com
#Website:	    www.1fangxin.cn
#Description:	Statistics of the top ten IP number and send email to author
#Notes:

#------------------------------------------------------------------------

#Copyright:	2016 (c) fangxin
#License:	GPL

pass="repl_users"
user="repl_users"
port=`netstat -na|grep "LISTEN"|grep "3306"|awk -F[:" "]+ '{print $5}'|sed -n '1p'`
ip=`ifconfig eth2|grep "inet addr" | awk -F[:" "]+ '{print $4}'`
array=($(mysql   -u$user -p$pass  -e "show slave status\G"|grep "Running" |awk '{print $2}'))
if [ "$port" == "3306" ]
      then
      if [ "${array[0]}" == "Yes" -a  "${array[1]}" == "Yes" ]
            then
                echo "slave is OK" 
      else
            #echo " Slave is not running" | mail -s "请查看主从模式是否出错" hz7726@163.com      
            file=`mysql  -P3306 -u$user -p$pass -h192.168.1.20  -e "show master status\G"|grep "File"|awk '{print $2}'`
            post=`mysql  -P3306 -u$user -p$pass -h192.168.1.20  -e "show master status\G"|grep "Pos"|awk '{print $2}'`
           mysql  -P3306 -uroot -pnongyaobaihou -e "slave stop;reset slave;change master to master_host='192.168.1.20',master_port='$port',master_user='$user',master_password='$pass',master_log_file='$file',master_log_pos=$pos;slave start;"
 
          sleep 3
      mysql  -P3306 -u$user -p$pass -e  "show slave status\G;"|grep Running
         echo
             echo "Now Replication is Finished!"
                 echo
                     echo "**********************************************************"
                             exit 2
       echo
        echo "Now Replication is Finished!"
            echo
                echo "**********************************************************"
 fi
 # else
            # /etc/init.d/postfix start 
           # echo " mysqld 可能停止运行 请查看" | mail -s "mysql 停止运行" hz7726@163.com
             #/etc/init.d/postfix  stop
 fi

