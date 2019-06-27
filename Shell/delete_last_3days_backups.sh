#!/bin/sh
find /home/backup/data -mtime +3 -name 'accounts*' -exec rm -f {} \;
find /home/backup/app -mtime +3 -name '*app*' -exec rm -f {} \;
