@echo off
set CURDATE=%date:~0,4%%date:~5,2%%date:~8,2%

echo open 192.168.2.99 > ftp.txt
echo ftpbak>> ftp.txt
echo GZca@ftp#586>> ftp.txt
echo bin >> ftp.txt
echo cd /ftpbackup/app >> ftp.txt
echo lcd D:\auto_backup\backup >> ftp.txt
echo prompt >> ftp.txt
echo TongZhiWeiYe_%CURDATE%.rar >> ftp.txt
echo bye >> ftp.txt
ftp -s:ftp.txt
del ftp.txt