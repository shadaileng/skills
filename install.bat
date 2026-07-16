@echo off
setlocal enabledelayedexpansion

rem Skill 安装脚本 (Windows)
rem 用于将本仓库中的 skill 安装到指定项目

set "SCRIPT_DIR=%~dp0"
set "SKILLS_DIR=%SCRIPT_DIR%skills"

rem 颜色定义（Windows 10+）
set "GREEN=[92m"
set "RED=[91m"
set "YELLOW=[93m"
set "NC=[0m"

rem 使用说明
if "%~1"=="" goto :usage
if "%~1"=="--help" goto :usage
if "%~1"=="-h" goto :usage
if "%~1"=="--list" goto :list
if "%~1"=="-l" goto :list
if "%~1"=="--all" goto :install_all
if "%~1"=="-a" goto :install_all

rem 安装单个 skill
set "SKILL_NAME=%~1"
set "TARGET_DIR=%~2"
if "%TARGET_DIR%"=="" set "TARGET_DIR=."

set "SOURCE_DIR=%SKILLS_DIR%\%SKILL_NAME%"
set "DEST_DIR=%TARGET_DIR%\.opencode\skills\%SKILL_NAME%"

if not exist "%SOURCE_DIR%" (
    echo %RED%错误: 找不到 skill '%SKILL_NAME%'%NC%
    echo 使用 --list 查看可用的 skill
    exit /b 1
)

if not exist "%SOURCE_DIR%\SKILL.md" (
    echo %RED%错误: skill '%SKILL_NAME%' 缺少 SKILL.md 文件%NC%
    exit /b 1
)

rem 创建目标目录
if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

rem 复制文件
xcopy /E /I /Y "%SOURCE_DIR%\*" "%DEST_DIR%\" >nul

echo %GREEN%✓ 已安装 skill '%SKILL_NAME%'%NC%
echo   目标位置: %DEST_DIR%
goto :eof

rem 列出所有可用的 skill
:list
echo %GREEN%可用的 skill:%NC%
echo.

for /d %%i in ("%SKILLS_DIR%\*") do (
    if exist "%%i\SKILL.md" (
        set "SKILL_NAME=%%~nxi"
        echo   %YELLOW%!SKILL_NAME!%NC%
        echo.
    )
)
goto :eof

rem 安装所有 skill
:install_all
set "TARGET_DIR=%~2"
if "%TARGET_DIR%"=="" set "TARGET_DIR=."

echo %GREEN%安装所有 skill...%NC%
echo.

for /d %%i in ("%SKILLS_DIR%\*") do (
    if exist "%%i\SKILL.md" (
        set "SKILL_NAME=%%~nxi"
        call :install_single "!SKILL_NAME!" "%TARGET_DIR%"
        echo.
    )
)

echo %GREEN%✓ 所有 skill 安装完成%NC%
goto :eof

rem 安装单个 skill（内部函数）
:install_single
set "SKILL_NAME=%~1"
set "TARGET_DIR=%~2"

set "SOURCE_DIR=%SKILLS_DIR%\%SKILL_NAME%"
set "DEST_DIR=%TARGET_DIR%\.opencode\skills\%SKILL_NAME%"

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"
xcopy /E /I /Y "%SOURCE_DIR%\*" "%DEST_DIR%\" >nul

echo %GREEN%✓ 已安装 skill '%SKILL_NAME%'%NC%
echo   目标位置: %DEST_DIR%
goto :eof

rem 使用说明
:usage
echo 用法:
echo   %~nx0 ^<skill-name^> [target-dir]
echo   %~nx0 --list
echo   %~nx0 --all [target-dir]
echo.
echo 参数:
echo   skill-name    要安装的 skill 名称
echo   target-dir    目标目录（可选，默认为当前目录）
echo.
echo 选项:
echo   --list        列出所有可用的 skill
echo   --all         安装所有 skill
echo   --help        显示此帮助信息
echo.
echo 示例:
echo   %~nx0 git-commit                    # 安装到当前目录
echo   %~nx0 git-commit C:\path\to\project # 安装到指定目录
echo   %~nx0 --list                         # 列出所有 skill
echo   %~nx0 --all                          # 安装所有 skill 到当前目录
goto :eof