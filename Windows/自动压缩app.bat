echo off
set CURDATE=%date:~0,4%%date:~5,2%%date:~8,2%
#runas /user:localhost\gzca cmd
#echo 123456
start D:\WinRAR\WinRAR.exe a  D:\auto_backup\backup\TongZhiWeiYe_%CURDATE%.rar  D:\apache-tomcat-8.0.23\webapps\esm

echo .
echo 备份已于：%DATE% %time% 完成！
echo .