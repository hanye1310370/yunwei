#!/bin/bash

#-------------------------------------------------------------------------

#Filename:	cut_apache.sh
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

#------------------------------------------------------------------------
#!/bin/bash
old=`date  -d ' -1 day ' +%Y%m%d`
cd /data/logs/apache/
if tar zcf access_${old}_log.tar.gz  access_${old}.log
    then
        if [ -f access_${old}.log ] 
             then
             rm access_${old}.log
         fi
fi
