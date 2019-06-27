#coding:utf-8
import os,sys,time,subprocess

import warnings,logging
from scapy.all import traceroute
#需要scapy2.2--2.3.3，python2 环境
warnings.filterwarnings("ignore",category=DeprecationWarning)
logging.getLogger("scapy.runtime").setLevel(logging.ERROR)


domains = raw_input('输入域名或者IP：')
target = domains.split(' ')

dport = [80]

if len(target) >=1 and target[0]!='':
    res,unans = traceroute(target,dport,retry=-2 )

    # res.graph(target="> test.svg")
    #在linux当前目录下生成文档
    time.sleep(1)
    # subprocess.Popen("test.svg test.png",shell=True)
else:
    print("输入错误呵呵呵呵,退出")