@echo off
set "currentUser=%USERNAME%"
set "currentTime=%time%"
set "currentDate=%date%"
mode 21, 6
chcp 65001 >nul

:1
echo ┏━━━━━━━━━━━━━━━━━━━┓
echo   [90mPřihlášen: [97m%currentUser%
echo   [90mDatum: [97m%date% 
echo   [90mČas: [97m%time:~0,5%[95m
echo ┗━━━━━━━━━━━━━━━━━━━┛
timeout /t 1 /nobreak >nul
cls
goto 1