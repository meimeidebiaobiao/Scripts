@echo off 

rem ###########################################################  
rem # Windows Server 2008��Oracle���ݿ��Զ�����������ű�  
rem ###########################################################  


rem ȡ��ǰϵͳʱ��,���������ϵͳ��ͬ��ȡֵ��һ��
set CURDATE=%date:~0,4%%date:~5,2%%date:~8,2%
set CURMON=%date:~0,4%%date:~5,2%

rem ���������ߡ��û���������  
set OWNER=ORCL
set USER=esmguiyang
set PASSWORD=gzcaesm_1105

echo ���ݿ�ʼ...
echo ��ǰ��ʱ���ǣ� %DATE% %time%

rem ����������Ŀ¼��Ŀ¼�ṹΪdbbackup/YYYYMMDD/  
set BAKHOME=D:
set BAKDIR=dbbackup

if not exist %BAKHOME%\%BAKDIR% (
   mkdir %BAKHOME%\%BAKDIR%
) else (
echo Ŀ¼ %BAKHOME%\%BAKDIR% �Ѿ�����
)

cd %BAKHOME%\%BAKDIR%

cd %BAKHOME%\%BAKDIR%
if not exist "%CURMON%" (
mkdir %CURMON%
) else (
echo Ŀ¼ %BAKHOME%\%BAKDIR%\%CURMON% �Ѿ�����
)

rem ���������ļ���
set FILENAME=%OWNER%_%CURDATE%.dmp 
set EXPLOG=%OWNER%_%CURDATE%.log 

rem ʹ��exp�����ȱ���,����ȫ����ģʽ
expdp %USER%/%PASSWORD%@%OWNER% file=%BAKHOME%\%BAKDIR%\%FILENAME% log=%BAKHOME%\%BAKDIR%\%EXPLOG% schemas=esmguiyang

echo .
echo �������ڣ�%DATE% %time% ��ɣ�
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