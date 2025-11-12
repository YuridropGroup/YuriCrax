@echo off
cls
title YuriCrax Decompressor
setlocal enabledelayedexpansion

:: =================================
:: Color Configuration (ANSI)
:: =================================

set "purple=[35m"
set "white=[37m"
set "red=[31m"
set "reset=[0m"

:: =================================
:: Input Handling
:: =================================

if "%~1"=="" (
    call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Usage is "decompress.bat path_to_archive.7z"%reset%
    pause
    exit /b
)

set "game_archive=%~1"
set "archive_name=%~n1"
set "archive_dir=%~dp1"
set "output_dir=%archive_dir%%archive_name%_YD"

:: =================================
:: Extract Archive
:: =================================

if not exist "%output_dir%" mkdir "%output_dir%"
call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Extracting archive.%reset%
7z x "%game_archive%" -o"%output_dir%" >nul
if errorlevel 1 (
    call echo %purple%[ %%TIME:~0,8%% ]%reset% %red%Extraction failed!%reset%
    pause
    exit /b
)
call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Archive extracted successfully.%reset%

:: =================================
:: Decompress .pcf Files In Place
:: =================================

set "original_dir=%cd%"
call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Scanning for .pcf files...%reset%
for /r "%output_dir%" %%f in (*.pcf) do (
    pushd "%%~dpf" >nul
    call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Decompressing:%reset% "%%~nxf"
    precomp -r "%%~nxf" >nul
    if errorlevel 1 (
        call echo %purple%[ %%TIME:~0,8%% ]%reset% %red%Failed:%reset% "%%~nxf"
    ) else (
        del /f /q "%%~nxf" >nul
    )
    popd >nul
)

call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Decompression complete.%reset%
call echo %purple%[ %%TIME:~0,8%% ]%reset% %white%Output folder:%reset% "%output_dir%"
pause
endlocal