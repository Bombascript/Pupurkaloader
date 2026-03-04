@echo off
setlocal EnableDelayedExpansion
title Pupurka Terminal
color 0A

:: Set log file name with timestamp
set LOGFILE=pupurka_log_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.txt
set LOGFILE=%LOGFILE: =0%

echo ======================================== > %LOGFILE%
echo Pupurka Terminal Startup Log >> %LOGFILE%
echo Date: %date% Time: %time% >> %LOGFILE%
echo ======================================== >> %LOGFILE%

echo [INFO] Starting Pupurka Command Line Terminal... >> %LOGFILE%

:boot
cls
echo Initializing system...
ping localhost -n 2 >nul
echo Loading kernel modules... OK
ping localhost -n 1 >nul
echo Mounting file systems... OK
ping localhost -n 1 >nul
echo Starting network interface...
ping localhost -n 2 >nul
echo ERROR: Failed to bind IPv6 address
ping localhost -n 1 >nul
echo Retrying network configuration...
ping localhost -n 2 >nul
echo Network interface started successfully.
ping localhost -n 1 >nul
echo Loading user profile...
ping localhost -n 2 >nul
echo ERROR: Profile corrupted, loading default
ping localhost -n 1 >nul
echo Starting Pupurka daemon...
ping localhost -n 2 >nul
echo [ OK ] Pupurka daemon started.
ping localhost -n 2 >nul

:menu
cls
echo.
echo   _____   _   _   _____   _   _   ____    _  __      _    
echo  ^|  __ \ ^| ^| ^| ^| ^|  __ \ ^| ^| ^| ^| ^|  _ \  ^| ^|/ /     / \   
echo  ^| ^|__) ^|^| ^| ^| ^| ^| ^|__) ^|^| ^| ^| ^| ^| ^|_) ^| ^| ' /     / _ \  
echo  ^|  ___/ ^| ^| ^| ^| ^|  ___/ ^| ^| ^| ^| ^|  _ ^<  ^|  ^<     / ___ \ 
echo  ^| ^|     ^| ^|_^| ^| ^| ^|     ^| ^|_^| ^| ^| ^|_) ^| ^| . \   / /   \ \
echo  ^|_^|      \___/  ^|_^|      \___/  ^|____/  ^|_^|\_\ /_/     \_\
echo.
echo main-v1.0.3-pupurka
echo.
echo   [1] Start Scan
echo   [2] Configuration
echo   [3] Update
echo   [4] Exit
echo.

set /p choice="root@pupurka:~# "

if "%choice%"=="1" goto scan
if "%choice%"=="2" goto config
if "%choice%"=="3" goto update
if "%choice%"=="4" goto exit_app
if /i "%choice%"=="clear" goto menu
if /i "%choice%"=="exit" goto exit_app

echo bash: %choice%: command not found
echo [WARN] Unknown command: %choice% >> %LOGFILE%
ping localhost -n 2 >nul
goto menu

:scan
echo [INFO] User started scan >> %LOGFILE%
echo.
echo Starting network scan... Please wait.
ping localhost -n 2 >nul
echo [*] Scanning local ports...
ping localhost -n 3 >nul
echo [+] Port 80 (HTTP) - OPEN
echo [+] Port 443 (HTTPS) - OPEN
ping localhost -n 2 >nul
echo [*] Scan complete. No vulnerabilities found.
echo.
pause
goto menu

:config
echo [INFO] User opened configuration >> %LOGFILE%
echo.
echo Configuration module loaded. (Simulation)
echo.
pause
goto menu

:update
echo [INFO] User checked for updates >> %LOGFILE%
echo.
echo Connecting to update server...

:: Укажите здесь прямую ссылку на ваш новый файл start.cmd на сервере (например, raw ссылка с GitHub или Pastebin)
set UPDATE_URL=https://raw.githubusercontent.com/Bombascript/Pupurkaloader/main/start.cmd

echo Downloading latest version...
curl -s -L -o update_temp.cmd %UPDATE_URL%

if exist update_temp.cmd (
    :: Проверяем, не пустой ли файл скачался (защита от ошибки 404)
    for %%A in (update_temp.cmd) do if %%~zA==0 goto update_fail

    echo Update downloaded successfully!
    echo Installing update...
    ping localhost -n 2 >nul
    
    :: Заменяем текущий файл новым
    move /y update_temp.cmd "%~nx0" >nul
    
    echo Update complete! Restarting terminal...
    echo [INFO] Update installed successfully. Restarting... >> %LOGFILE%
    ping localhost -n 2 >nul
    
    :: Перезапускаем обновленный файл и закрываем старый
    start "" "%~nx0"
    exit
)

:update_fail
if exist update_temp.cmd del update_temp.cmd
echo [ERROR] Failed to download update. Check your internet connection or server URL.
echo [ERROR] Update failed. >> %LOGFILE%
pause
goto menu

:exit_app
echo [INFO] Application closed normally. >> %LOGFILE%
echo ======================================== >> %LOGFILE%
echo End of log. >> %LOGFILE%
echo.
echo Exiting Pupurka... Connection closed.
ping localhost -n 2 >nul
exit
