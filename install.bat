@echo off
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "SKILLS_DIR=%SCRIPT_DIR%skills"

if "%~1"=="" goto :usage
if "%~1"=="--help" goto :usage
if "%~1"=="-h" goto :usage
if "%~1"=="--list" goto :list
if "%~1"=="-l" goto :list
if "%~1"=="--all" goto :install_all
if "%~1"=="-a" goto :install_all

set "SKILL_NAME=%~1"
set "TARGET_DIR=%~2"
if "%TARGET_DIR%"=="" set "TARGET_DIR=."

set "SOURCE_DIR=%SKILLS_DIR%\%SKILL_NAME%"
set "DEST_DIR=%TARGET_DIR%\.opencode\skills\%SKILL_NAME%"

if not exist "%SOURCE_DIR%" (
    echo Error: Skill '%SKILL_NAME%' not found
    echo Use --list to see available skills
    exit /b 1
)

if not exist "%SOURCE_DIR%\SKILL.md" (
    echo Error: SKILL.md not found in skill '%SKILL_NAME%'
    exit /b 1
)

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"
xcopy /E /I /Y "%SOURCE_DIR%\*" "%DEST_DIR%\" >nul

echo Skill '%SKILL_NAME%' installed to: %DEST_DIR%
goto :eof

:list
echo Available skills:
echo.

for /d %%i in ("%SKILLS_DIR%\*") do (
    if exist "%%i\SKILL.md" (
        echo   %%~nxi
    )
)
echo.
goto :eof

:install_all
set "TARGET_DIR=%~2"
if "%TARGET_DIR%"=="" set "TARGET_DIR=."

echo Installing all skills...
echo.

for /d %%i in ("%SKILLS_DIR%\*") do (
    if exist "%%i\SKILL.md" (
        set "SKILL_NAME=%%~nxi"
        call :install_single "!SKILL_NAME!" "%TARGET_DIR%"
        echo.
    )
)

echo All skills installed.
goto :eof

:install_single
set "SKILL_NAME=%~1"
set "TARGET_DIR=%~2"

set "SOURCE_DIR=%SKILLS_DIR%\%SKILL_NAME%"
set "DEST_DIR=%TARGET_DIR%\.opencode\skills\%SKILL_NAME%"

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"
xcopy /E /I /Y "%SOURCE_DIR%\*" "%DEST_DIR%\" >nul

echo Skill '%SKILL_NAME%' installed to: %DEST_DIR%
goto :eof

:usage
echo Skill Installer for OpenCode
echo.
echo Usage:
echo   %~nx0 ^<skill-name^> [target-dir]
echo   %~nx0 --list
echo   %~nx0 --all [target-dir]
echo   %~nx0 --help
echo.
echo Examples:
echo   %~nx0 git-commit
echo   %~nx0 git-commit C:\path\to\project
echo   %~nx0 --list
echo   %~nx0 --all
goto :eof