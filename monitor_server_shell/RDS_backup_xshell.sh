#!/bin/bash
##############################################
#Author: hanye
#Email:  hz7726@163.com
#Last modified: 2018/11/15/14:50
#Filename: mysqlbackup.sh
#Revision:  0.1
#Description: 
#crontab: * * * * * mysqlbackup.sh
#Website:   www.hz7726.net
#License: GPL
##############################################

db_user="MYSQL_USER"
db_passwd="MYSQL_USER_PASS"
host="MYSQL_HOST"
DB_NAME=`/usr/local/mysql/bin/mysql -u$db_user -p$db_passwd -h$host $db_name  -e "show databases"|egrep -v "*schema|Database|sys|mysql"`
#备份目录
backup_dir="/data/backup/backmysql"
old_backuo_dir="/data/backup/backmysqlold"
#时间格式
time=$(date +"%Y-%m-%d-%H-%M")
find ${old_backuo_dir}  -name  "*" -mtime +15 |xargs rm -rf
#进入备份目录将之前的移动到old目录
cd ${backup_dir}
echo "you are in bakmysql directory now"
mv *.gz ${old_backuo_dir}
echo "Old databases are moved to bakmysqlold folder"
#mysql 备份的命令，注意有空格和没有空格
for db_name in $DB_NAME
do
/usr/local/mysql/bin/mysqldump  -u$db_user -p$db_passwd -h$host $db_name --single-transaction  --set-gtid-purged=OFF |gzip > "$backup_dir/$db_name"-"$time.sql.gz"
echo "your database  $db_name backup successfully completed"
