@echo off 

rem ###########################################################  
rem # Windows Server 2008下Oracle数据库自动备份批处理脚本  
rem ###########################################################  


rem 取当前系统时间,可能因操作系统不同而取值不一样
set CURDATE=%date:~0,4%%date:~5,2%%date:~8,2%
set CURMON=%date:~0,4%%date:~5,2%

rem 设置所有者、用户名和密码  
set OWNER=ORCL
set USER=esmguiyang
set PASSWORD=gzcaesm_1105

echo 备份开始...
echo 当前的时间是： %DATE% %time%

rem 创建备份用目录，目录结构为dbbackup/YYYYMMDD/  
set BAKHOME=D:
set BAKDIR=dbbackup

if not exist %BAKHOME%\%BAKDIR% (
   mkdir %BAKHOME%\%BAKDIR%
) else (
echo 目录 %BAKHOME%\%BAKDIR% 已经存在
)

cd %BAKHOME%\%BAKDIR%

cd %BAKHOME%\%BAKDIR%
if not exist "%CURMON%" (
mkdir %CURMON%
) else (
echo 目录 %BAKHOME%\%BAKDIR%\%CURMON% 已经存在
)

rem 创建备份文件名
set FILENAME=%OWNER%_%CURDATE%.dmp 
set EXPLOG=%OWNER%_%CURDATE%.log 

rem 使用exp命令热备份,采用全备份模式
expdp %USER%/%PASSWORD%@%OWNER% file=%BAKHOME%\%BAKDIR%\%FILENAME% log=%BAKHOME%\%BAKDIR%\%EXPLOG% schemas=esmguiyang

echo .
echo 备份已于：%DATE% %time% 完成！
echo .

echo open 192.168.2.99 > ftp.txt
echo ftpbak>> ftp.txt
echo GZca@ftp#586>> ftp.txt
echo bin >> ftp.txt
echo cd /ftpbackup/esmdb >> ftp.txt
echo lcd D:\dbbackup >> ftp.txt
echo prompt >> ftp.txt
echo put %FILENAME% >> ftp.txt
echo put %EXPLOG% >> ftp.txt
echo bye >> ftp.txt
ftp -s:ftp.txt
del ftp.txt