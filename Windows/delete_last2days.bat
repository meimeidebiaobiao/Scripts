@echo off

forfiles /p "xxx(·��)xxx" /m *.dmp /d -2 /c "cmd /c del @file /f"