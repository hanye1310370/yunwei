#!/bin/bash
MsqlP=`/www/wdlinux/mysql/bin/mysqladmin  -uroot -pnongyaobaihou ping`
Mysql_Ok="mysqld is alive"

if [[ "$MsqlP" != $Mysql_Ok ]]; then
    /etc/init.d/mysql	 restart 
    echo "169Linux mysql not ok PLZ moni sdb disk" |mail -s mysql_error_not_ok hz7726@163.com
else
    echo -e "\033[31m mysql is ok\033[0m"
fi
v_nginx=`ps aux|grep nginx|grep -v 'grep'|wc -l`
if [ "$v_nginx" -lt  1 ]; then
        /etc/init.d/nginx restart 
        echo "169Linux nginx not ok PLZ moni sdb disk" |mail -s nginx_error_not_ok hz7726@163.com 
else
        echo -e  "\033[31m 169nginx is alived\033[0m"
fi
v_mycat=`ps -ef | grep mycat | grep -v "grep"|wc -l`
if [ "$v_mycat" -lt  1 ]; then
        /data/mycat/bin/mycat restart 
        echo "169Linux nginx not ok PLZ moni sdb disk" |mail -s nginx_error_not_ok hz7726@163.com
else
        echo -e  "\033[31m 169 mycat is alived\033[0m"
fi
v_lsyncd=`ps -ef |grep lsyncd|grep -v "grep"|wc -l`
if [ "$v_lsyncd" -lt  1 ]; then
        /etc/init.d/lsyncd  restart
        if [ $? -ne 0 ]; then
        echo "169Linux lsyncd not ok PLZ moni sdb disk" |mail -s nginx_error_not_ok hz7726@163.com
        fi
else
        echo -e  "\033[31m 169  lsyncd is alived\033[0m"
fi
