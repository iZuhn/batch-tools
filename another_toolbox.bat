@echo off
Title Toolbox
:MENU
mode 40,7
cls
echo 1. Open CMD in Admninistrator Mode
echo 2. System Information
echo 3. Network
echo 4. Social Media and ChatGPT
echo 5. File and Folder Management
echo.
echo|set /p=">>"
choice /c 12345 >nul
    if /I "%errorlevel%" EQU "1" (
    runas /user:Admin cmd
	goto :MENU
    )
	if /I "%errorlevel%" EQU "2" (
    goto :B
    )
	if /I "%errorlevel%" EQU "3" (
    goto :C
    )
	if /I "%errorlevel%" EQU "4" (
    goto :D
    )
	if /I "%errorlevel%" EQU "5" (
    goto :E
    )
cls	



:B #SYSTEM INFO - MENU
mode 60,7
cls
echo 1. Display detailed system operating and configuration info
echo 2. Delete TEMP files (may need Administrator rights)
echo 3. Back to Main Menu
echo.
echo.
echo.
echo|set /p=">>"
choice /c 123 >nul
    if /I "%errorlevel%" EQU "1" (
    goto :B1
    )
	if /I "%errorlevel%" EQU "2" (
    goto :B2
    )
	if /I "%errorlevel%" EQU "3" (
    goto :MENU
    )

:B1 #SHOWS SYSTEM INFO
mode 120,30
cls
systeminfo
pause >nul
goto :B
:B2 #DELETES TEMPORARY FILES FROM SYSTEM (SAFE)
set "tempDirs=C:\Windows\Temp %TMP% C:\Windows\Prefetch"
    set "tempSize=0"

    for %%D in (%tempDirs%) do (
        if exist "%%D" (
            echo Clearing %%D folder...
            for /d %%A in ("%%D\*") do (
                del /f /s /q "%%A\*.*"
                set /a tempSize+=%%~zA
                rd /s /q "%%A"
            )
            del /f /s /q "%%D\*.*"
            set /a tempSize+=%%~zD
        ) else (
            echo File %%D does not exist.
			pause >nul
        )
    )

    cls
    echo TEMP file has been cleaned.
    echo.
    ping localhost -n 3 >nul
    cls
    echo Emptying bin...
    RD /S /Q %systemdrive%\$Recycle.Bin
    cls
    echo Bin is now empty.
    ping localhost -n 3 >nul
    cls
    echo Restarting Explorer (Fixes visual bugs with icons on desktop)
    taskkill /f /im explorer.exe
    timeout 1 >nul
    start explorer.exe
    cls
    echo Cleaning has been completed, press any key to continue.
    echo.
    echo.
    endlocal
    pause >nul
goto :B



:C #NETWORK - MENU
mode 63,7
cls
echo 1. Show all saved wifi networks
echo 2. Show all saved wifi network passwords (Needs Administrator)
echo 3. Back to Main Menu
echo.
echo.
echo.
echo|set /p=">>"
choice /c 123 >nul
    if /I "%errorlevel%" EQU "1" (
    goto :C1
    )
	if /I "%errorlevel%" EQU "2" (
    goto :C2
    )
	if /I "%errorlevel%" EQU "3" (
    goto :MENU
    )
:C1 #SHOWS ALL PREVIOUS WIFI NETWORKS
cls
netsh wlan show profile
pause >nul
goto :C
:C2 #FIX NEEDED - SHOULD DISPLAY SSID AND ITS KEY (PASSWORD)
cls
for /F "tokens=2 delims=:" %a in ('netsh wlan show profile') do @(set wifi_pwd= & for /F "tokens=2 delims=: usebackq" %F IN ( netsh wlan show profile %a key^=clear ^| find "Key Content" ) do @(set wifi_pwd=%F) & echo %a : !wifi_pwd!)
pause >nul
goto :C



:D #SOCIAL MEDIA AND CHATGPT - MENU
mode 40,8
cls
echo 1. Weather
echo 2. Check the Status of a Website
echo 3. Check Your Public IP Address
echo 4. Generate a QR Code
echo 5. Check Social Media
echo 6. Back to Main Menu
echo.
echo|set /p=">>"
choice /c 123456 >nul
    if /I "%errorlevel%" EQU "1" (
    goto :D1
    )
	if /I "%errorlevel%" EQU "2" (
    goto :D2
    )
	if /I "%errorlevel%" EQU "3" (
    goto :D3
    )
	if /I "%errorlevel%" EQU "4" (
    goto :D4
    )
	if /I "%errorlevel%" EQU "5" (
    goto :D5
    )
	if /I "%errorlevel%" EQU "6" (
    goto :MENU
    )
:D1 CURLS THE WEATHER
mode 125,40
cls
curl wttr.in/czech_republic
pause >nul
goto :D
:D2 #CHECKS STATUS OF WEBSITE
cls
echo What website do you want to check?
set /p "var=Website URL: "
if "%var%"=="" (
	cls
    echo No URL provided. Exiting.
    pause >nul
    goto :D
)
if /I "%var%"=="exit" (
    goto :D
)
cls
for /f "tokens=2 delims= " %%i in ('curl -Is http://%var% ^| findstr /R "^HTTP/1.1"') do (
    if "%%i"=="302" (
        echo Status : OK
		echo Code: %%i
    ) else if "%%i"=="301" (
        echo Status : Moved Permanently
		echo Code: %%i
    ) else if "%%i"=="200" (
        echo Status : OK
		echo Code: %%i
    ) else if "%%i"=="404" (
        echo Status : Not Found, Code 404
		echo Code: %%i
    ) else if "%%i"=="500" (
        echo Status : Internal Server Error
		echo Code: %%i
    ) else (
        echo Status Code is %%i
    )
)
pause >nul
goto :D2
:D3 #CHECKS YOUR PUBLIC IP ADDRESS
cls
curl checkip.amazonaws.com
pause >nul
goto :D
:D4 #GENERATES A QR CODE
mode 50, 7
cls
echo What website you want to generate QR code for?
set /p generate=
cls
mode 80, 40
curl https://qrenco.de/%generate%
pause >nul
goto :D
:D5 #CHECKS YOUTUBE LATEST VIDEO OF SPECIFIED CHANNEL
cls
echo What YouTuber you want to check?
set /p youtubeuser=">>"
cls
curl -s https://decapi.me/youtube/latest_video?user=%youtubeuser%
pause >nul
goto :D



:E #FILE AND FOLDER MANAGEMENT - MENU
cls
echo Work In Process, press any key to return to Main menu
pause >nul
goto :MENU