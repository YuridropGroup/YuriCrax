@echo off
cls
title YuriCrax Compressor
setlocal enabledelayedexpansion

:: =================================
:: Color Configuration (ANSI).
:: =================================

set "purple=[35m"
set "white=[37m"
set "red=[31m"
set "reset=[0m"

:: =================================
:: File & Directory Configurations.
:: =================================

:: Ask user for the directory for the game and set game_directory to that.

call set /P "game_directory=%purple%[ %%TIME:~0,8%% ]%reset% %white%Enter the games directory: %reset%"

:: Set the temp_directory for the .pcf files.

set "temp_directory=%game_directory%_pcf_temp"
if exist "%temp_directory%" rmdir /s /q "%temp_directory%"
mkdir "%temp_directory%"

:: Create final archive path

for %%a in ("%game_directory%") do set "folder_name=%%~nxa"
set "file_final_name=%game_directory%\..\%folder_name%.7z"
call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Final archive name: %reset% %file_final_name%

:: =================================
:: Precompile each file recursively.
:: =================================

call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Precompiling all files...%reset%

for /R "%game_directory%" %%f in (*.*) do (

    echo "%%f" | find /I "%temp_directory%" >nul && continue

    set "relPath=%%~dpf"
    set "relPath=!relPath:%game_directory%\=!"
    set "destFolder=%temp_directory%\!relPath!"
    mkdir "!destFolder!" 2>nul

    if exist "%%~dpnf.pcf" del /f /q "%%~dpnf.pcf"

    precomp "%%f" >nul
    if exist "%%~dpnf.pcf" (
        move "%%~dpnf.pcf" "!destFolder!\" >nul
        call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Moved precompiled file:%reset% "%%~nxf.pcf"
    ) else (
        call echo %purple%[ %%TIME:~0,8%% ]%reset% %red%Unable to move .pcf file:%reset% "%%~nxf"
    )
)

:: =================================
:: Compress to .7z.
:: =================================

call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Compressing into .7z archive...%reset%
7z a -t7z -m0=lzma2 -mx=9 -md=256m -mfb=273 -ms=on "%file_final_name%" "%temp_directory%\*" >nul

:: =================================
:: Cleanup.
:: =================================

call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Game compression complete.%reset%
pause
endlocal