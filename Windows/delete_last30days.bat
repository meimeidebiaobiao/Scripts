@echo off


forfiles /p "D:\dbbackup" /m *.dmp /d -30 /c "cmd /c del @file /f"