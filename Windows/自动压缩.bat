echo off
set CURDATE=%date:~0,4%%date:~5,2%%date:~8,2%
#runas /user:localhost\gzca cmd
#echo 123456
start D:\WinRAR\WinRAR.exe a D:\auto_backup&put\backup\tongzhiweiye_%CURDATE%.rar D:\apache-tomcat-8.0.23 

echo .
echo 备份已于：%DATE% %time% 完成！
echo .

echo open 192.168.2.99> ftpcommand.txt
echo ftpbak>>ftpcommand.txt
echo GZca@ftp#586>>ftpcommand.txt
echo bin>>ftpcommand.txt
echo cd /ftpbackup/app>>ftpcommand.txt
echo lcd D:/app/admin/orcl/dpdump>>ftpcommand.txt
echo prompt>>ftpcommand.txt
echo put %FILENAME%>>ftpcommand.txt
echo put %EXPLOG%>>ftpcommand.txt
echo bye>>ftpcommand.txt
ftp -s:ftpcommand.txt
del ftpcommand.txt