#Requires -Version 5.1

<#
.SYNOPSIS
    Skill 安装脚本 (PowerShell)
.DESCRIPTION
    用于将本仓库中的 skill 安装到指定项目
.EXAMPLE
    .\install.ps1 -SkillName "git-commit"
    .\install.ps1 -SkillName "git-commit" -TargetDir "C:\path\to\project"
    .\install.ps1 -List
    .\install.ps1 -All
#>

param(
    [Parameter(Position=0)]
    [string]$SkillName,
    
    [Parameter(Position=1)]
    [string]$TargetDir = ".",
    
    [switch]$List,
    [switch]$All,
    [switch]$Help
)

# 获取脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsDir = Join-Path $ScriptDir "skills"

# 颜色函数
function Write-Green { param([string]$Message) Write-Host $Message -ForegroundColor Green }
function Write-Red { param([string]$Message) Write-Host $Message -ForegroundColor Red }
function Write-Yellow { param([string]$Message) Write-Host $Message -ForegroundColor Yellow }

# 使用说明
function Show-Usage {
    Write-Host @"
用法:
    .\install.ps1 -SkillName <skill-name> [-TargetDir <target-dir>]
    .\install.ps1 -List
    .\install.ps1 -All [-TargetDir <target-dir>]
    .\install.ps1 -Help

参数:
    -SkillName     要安装的 skill 名称
    -TargetDir     目标目录（可选，默认为当前目录）

选项:
    -List          列出所有可用的 skill
    -All           安装所有 skill
    -Help          显示此帮助信息

示例:
    .\install.ps1 -SkillName "git-commit"                    # 安装到当前目录
    .\install.ps1 -SkillName "git-commit" -TargetDir "C:\project"  # 安装到指定目录
    .\install.ps1 -List                                       # 列出所有 skill
    .\install.ps1 -All                                        # 安装所有 skill
"@
}

# 列出所有可用的 skill
function Get-AvailableSkills {
    Write-Green "可用的 skill:"
    Write-Host ""
    
    if (Test-Path $SkillsDir) {
        Get-ChildItem -Path $SkillsDir -Directory | ForEach-Object {
            $skillPath = Join-Path $_.FullName "SKILL.md"
            if (Test-Path $skillPath) {
                $content = Get-Content $skillPath -Raw
                if ($content -match 'description:\s*>\s*\n\s*(.+)') {
                    $description = $matches[1].Trim()
                } else {
                    $description = "(无描述)"
                }
                Write-Yellow "  $($_.Name)"
                Write-Host "    $description"
                Write-Host ""
            }
        }
    } else {
        Write-Red "错误: 找不到 skills 目录"
        exit 1
    }
}

# 安装单个 skill
function Install-Skill {
    param(
        [string]$Name,
        [string]$Target
    )
    
    $sourceDir = Join-Path $SkillsDir $Name
    $destDir = Join-Path $Target ".opencode\skills\$Name"
    
    # 检查 skill 是否存在
    if (-not (Test-Path $sourceDir)) {
        Write-Red "错误: 找不到 skill '$Name'"
        Write-Host "使用 -List 查看可用的 skill"
        exit 1
    }
    
    $skillFile = Join-Path $sourceDir "SKILL.md"
    if (-not (Test-Path $skillFile)) {
        Write-Red "错误: skill '$Name' 缺少 SKILL.md 文件"
        exit 1
    }
    
    # 创建目标目录
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }
    
    # 复制文件
    Copy-Item -Path "$sourceDir\*" -Destination $destDir -Recurse -Force
    
    Write-Green "✓ 已安装 skill '$Name'"
    Write-Host "  目标位置: $destDir"
}

# 安装所有 skill
function Install-AllSkills {
    param([string]$Target)
    
    if (-not (Test-Path $SkillsDir)) {
        Write-Red "错误: 找不到 skills 目录"
        exit 1
    }
    
    Write-Green "安装所有 skill..."
    Write-Host ""
    
    Get-ChildItem -Path $SkillsDir -Directory | ForEach-Object {
        $skillPath = Join-Path $_.FullName "SKILL.md"
        if (Test-Path $skillPath) {
            Install-Skill -Name $_.Name -Target $Target
            Write-Host ""
        }
    }
    
    Write-Green "✓ 所有 skill 安装完成"
}

# 主逻辑
if ($Help) {
    Show-Usage
    exit 0
}

if ($List) {
    Get-AvailableSkills
    exit 0
}

if ($All) {
    Install-AllSkills -Target $TargetDir
    exit 0
}

if (-not $SkillName) {
    Show-Usage
    exit 0
}

Install-Skill -Name $SkillName -Target $TargetDir