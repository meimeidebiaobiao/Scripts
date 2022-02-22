import os
import re
import sys

filelist = os.listdir(r"F:\kugimiya-voice-1.0.3\voices")
for file in filelist:
    print (file)
    a = file.split("-")
    os.chdir(r"F:\kugimiya-voice-1.0.3\voices")
    os.rename(file,a[0]+".mp3")