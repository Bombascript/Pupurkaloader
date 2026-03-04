@echo off
setlocal EnableDelayedExpansion
title Pupurka Terminal
color 0A

:: Set log file name with timestamp
set LOGFILE=pupurka_log_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.txt
set LOGFILE=%LOGFILE: =0%

:: Create module folder if it doesn't exist
if not exist "module" mkdir "module"

echo ======================================== > %LOGFILE%
echo Pupurka Terminal Startup Log >> %LOGFILE%
echo Date: %date% Time: %time% >> %LOGFILE%
echo ======================================== >> %LOGFILE%

echo [INFO] Starting Pupurka Command Line Terminal... >> %LOGFILE%

:boot
cls
color 0A
echo.
echo  PUPURKA BIOS v2.44 (C) 2026
echo  Main Processor: Pupurka Quantum Core
echo  Memory Testing: 32768K OK
echo  Detecting Primary Master... [OK]
echo.
ping localhost -n 2 >nul

:: Эффект ошибки - меняем цвет всей консоли на красный
color 0C
echo  [!] CRITICAL ERROR: BOOT SECTOR CORRUPTED
echo  [!] KERNEL PANIC: 0x0000007B
echo  [!] ATTEMPTING TO RECOVER...
ping localhost -n 2 >nul

:: Эффект предупреждения - меняем цвет на желтый
color 0E
echo  [*] BYPASSING SECURITY PROTOCOLS...
echo  [*] REBUILDING FILE SYSTEM INDEX...
ping localhost -n 2 >nul

:: Возвращаем хакерский зеленый цвет
color 0A
echo  [+] RECOVERY SUCCESSFUL. SYSTEM STABILIZED.
ping localhost -n 2 >nul
echo.

echo  [ OK ] SYSTEM FULLY OPERATIONAL.
ping localhost -n 2 >nul
goto menu

:menu
cls
color 0A
echo.
echo  ================================================================
echo.
echo      _____   _   _   _____   _   _   ____    _  __      _    
echo     ^|  __ \ ^| ^| ^| ^| ^|  __ \ ^| ^| ^| ^| ^|  _ \  ^| ^|/ /     / \   
echo     ^| ^|__) ^|^| ^| ^| ^| ^| ^|__) ^|^| ^| ^| ^| ^| ^|_) ^| ^| ' /     / _ \  
echo     ^|  ___/ ^| ^| ^| ^| ^|  ___/ ^| ^| ^| ^| ^|  _ ^<  ^|  ^<     / ___ \ 
echo     ^| ^|     ^| ^|_^| ^| ^| ^|     ^| ^|_^| ^| ^| ^|_) ^| ^| . \   / /   \ \
echo     ^|_^|      \___/  ^|_^|      \___/  ^|____/  ^|_^|\_\ /_/     \_\
echo.
echo  ================================================================
echo                        main-v1.0.0-pupurka
echo  ================================================================
echo.
echo      [1] Start Scan                [4] Exit
echo      [2] Configuration             [5] Modules
echo      [3] Update
echo.
echo  ================================================================
echo.
set /p choice="  root@pupurka:~# "

if "%choice%"=="1" goto scan
if "%choice%"=="2" goto config
if "%choice%"=="3" goto update
if "%choice%"=="4" goto exit_app
if "%choice%"=="5" goto modules
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
echo  ========================================
echo           CONFIGURATION MODULE
echo  ========================================
echo.
echo  [ Simulation Mode Active ]
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

:modules
cls
echo [INFO] User opened modules menu >> %LOGFILE%
echo.
echo  ========================================
echo              AVAILABLE MODULES
echo  ========================================
echo.

set count=0
for %%f in (module\*.py) do (
    set /a count+=1
    set "mod!count!=%%~nxf"
    echo    [!count!] %%~nxf
)

if !count!==0 (
    echo    No Python modules found in the 'module' folder.
    echo    Please add some .py files to the folder.
)

echo.
echo    [0] Back to Main Menu
echo.
echo  ========================================
echo.
set /p mod_choice="  Select module to run (0-!count!): "

if "%mod_choice%"=="0" goto menu

set "selected_mod="
for /l %%i in (1,1,!count!) do (
    if "%mod_choice%"=="%%i" set "selected_mod=!mod%%i!"
)

if defined selected_mod (
    echo.
    echo [INFO] Running module: !selected_mod! >> %LOGFILE%
    echo Running !selected_mod!...
    echo ----------------------------------------
    python "module\!selected_mod!"
    echo ----------------------------------------
    echo Module execution finished.
    pause
    goto modules
) else (
    echo Invalid selection.
    ping localhost -n 2 >nul
    goto modules
)

:exit_app
echo [INFO] Application closed normally. >> %LOGFILE%
echo ======================================== >> %LOGFILE%
echo End of log. >> %LOGFILE%
echo.
echo Exiting Pupurka... Connection closed.
ping localhost -n 2 >nul
exit
