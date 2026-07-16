param(
    [Parameter(Position=0)]
    [string]$SkillName,
    
    [Parameter(Position=1)]
    [string]$TargetDir = ".",
    
    [switch]$List,
    [switch]$All,
    [switch]$Help
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
if (-not $ScriptDir) {
    $ScriptDir = $PSScriptRoot
}
$SkillsDir = Join-Path $ScriptDir "skills"

function Show-Usage {
    Write-Host @"
Skill Installer for OpenCode

Usage:
    .\install.ps1 <skill-name> [target-dir]
    .\install.ps1 -List
    .\install.ps1 -All [target-dir]
    .\install.ps1 -Help

Examples:
    .\install.ps1 git-commit
    .\install.ps1 git-commit C:\path\to\project
    .\install.ps1 -List
    .\install.ps1 -All
"@
}

function Get-AvailableSkills {
    Write-Host "Available skills:" -ForegroundColor Green
    Write-Host ""
    
    if (Test-Path $SkillsDir) {
        Get-ChildItem -Path $SkillsDir -Directory | ForEach-Object {
            $skillPath = Join-Path $_.FullName "SKILL.md"
            if (Test-Path $skillPath) {
                Write-Host "  $($_.Name)" -ForegroundColor Yellow
            }
        }
        Write-Host ""
    } else {
        Write-Host "Error: skills directory not found" -ForegroundColor Red
        exit 1
    }
}

function Install-Skill {
    param(
        [string]$Name,
        [string]$Target
    )
    
    $sourceDir = Join-Path $SkillsDir $Name
    $destDir = Join-Path $Target ".opencode\skills\$Name"
    
    if (-not (Test-Path $sourceDir)) {
        Write-Host "Error: Skill '$Name' not found" -ForegroundColor Red
        Write-Host "Use -List to see available skills"
        exit 1
    }
    
    $skillFile = Join-Path $sourceDir "SKILL.md"
    if (-not (Test-Path $skillFile)) {
        Write-Host "Error: SKILL.md not found in skill '$Name'" -ForegroundColor Red
        exit 1
    }
    
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }
    
    Copy-Item -Path "$sourceDir\*" -Destination $destDir -Recurse -Force
    
    Write-Host "Skill '$Name' installed to: $destDir" -ForegroundColor Green
}

function Install-AllSkills {
    param([string]$Target)
    
    if (-not (Test-Path $SkillsDir)) {
        Write-Host "Error: skills directory not found" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "Installing all skills..." -ForegroundColor Green
    Write-Host ""
    
    Get-ChildItem -Path $SkillsDir -Directory | ForEach-Object {
        $skillPath = Join-Path $_.FullName "SKILL.md"
        if (Test-Path $skillPath) {
            Install-Skill -Name $_.Name -Target $Target
            Write-Host ""
        }
    }
    
    Write-Host "All skills installed." -ForegroundColor Green
}

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