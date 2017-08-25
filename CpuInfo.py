#!/usr/bin/env python
#-*- encoding: utf-8 -*-
#########################################################################
# File Name: CpuInfo.py
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

#########################################################################
 
from __future__ import print_function
from collections import OrderedDict
import pprint
 
def CPUinfo():
    ''' Return the information in /proc/CPUinfo
    as a dictionary in the following format:
    CPU_info['proc0']={...}
    CPU_info['proc1']={...}
    '''
    CPUinfo=OrderedDict()
    procinfo=OrderedDict()
 
    nprocs = 0
    with open('/proc/cpuinfo') as f:
        for line in f:
            if not line.strip():
                # end of one processor
                CPUinfo['proc%s' % nprocs] = procinfo
                nprocs=nprocs+1
                # Reset
                procinfo=OrderedDict()
            else:
                if len(line.split(':')) == 2:
                    procinfo[line.split(':')[0].strip()] = line.split(':')[1].strip()
                else:
                    procinfo[line.split(':')[0].strip()] = ''
             
    return CPUinfo
 
if __name__=='__main__':
    CPUinfo = CPUinfo()
    for processor in CPUinfo.keys():
        print(CPUinfo[processor]['model name'])
