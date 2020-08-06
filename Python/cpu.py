#!/usr/bin/python
 
import threading
import time
import os
import string
import sys
class ControlThread(threading.Thread):
 
 
  def __init__(self):
    threading.Thread.__init__(self)
    self.runflag = True 
 
  def run(self):
    while self.runflag:
      os.popen('usleep ' + sys.argv[5])
 
  def stop(self):
    self.runflag = False
threadList=[]
 
 
for i in range(0,string.atoi(sys.argv[3])):
  thread = ControlThread()
  threadList.append(thread)
  thread.start()
 
while True:
  output = 100 - string.atof(os.popen('sar -u 1 1|grep Average |awk \'{print $8}\'').read())
 
  if output < string.atoi(sys.argv[1]):
   for i in range(0,string.atoi(sys.argv[4])):
    thread = ControlThread()
    thread.start()
    threadList.append(thread)
   print "+++++"
  if output > string.atoi(sys.argv[2]):
   for i in range(0,string.atoi(sys.argv[4])):  
    thread = threadList.pop()
    thread.stop()
   print "-----"


##python实现的脚本如下，这个脚本需要5个数字参数的输入，分别为：
##最低CPU利用率，最高CPU利用率，初始线程数量，每次调节的线程数量，每个线程睡眠的时间（毫秒）