# Desinstalador (Windows)
[CmdletBinding()]
param(
    [ValidateSet("user", "project", "ask")]
    [string]$Scope = "ask"
)

$ErrorActionPreference = "Stop"
$ScriptRoot = $PSScriptRoot

if ($Scope -eq "ask") {
    Write-Host "De qual escopo desinstalar?"
    Write-Host "  [u] user    - ~/.claude/agents/"
    Write-Host "  [p] project - .claude/agents/ aqui"
    $ans = Read-Host "Escolha (u/p) [u]"
    if ($ans -eq "p" -or $ans -eq "P") { $Scope = "project" } else { $Scope = "user" }
}

if ($Scope -eq "user") {
    $TargetDir = Join-Path $env:USERPROFILE ".claude\agents"
} else {
    $TargetDir = Join-Path (Get-Location) ".claude\agents"
}

if (-not (Test-Path $TargetDir)) {
    Write-Host "Diretorio nao existe: $TargetDir" -ForegroundColor Yellow
    exit 0
}

$SourceDir = Join-Path $ScriptRoot "agents"
$AgentNames = Get-ChildItem -Path $SourceDir -Filter "*.md" |
              Where-Object { $_.Name -ne "README.md" } |
              Select-Object -ExpandProperty Name

Write-Host ""
Write-Host "Removendo de: $TargetDir" -ForegroundColor Cyan
Write-Host ""

$Removed = 0
foreach ($name in $AgentNames) {
    $path = Join-Path $TargetDir $name
    if (Test-Path $path) {
        Remove-Item $path -Force
        Write-Host "[remove] $name" -ForegroundColor Yellow
        $Removed++
    }
}

# Marker
$marker = Join-Path $TargetDir ".agent-study-assistant.json"
if (Test-Path $marker) { Remove-Item $marker -Force }

# Slash commands
$CommandsSourceDir = Join-Path $ScriptRoot "commands"
if (Test-Path $CommandsSourceDir) {
    if ($Scope -eq "user") {
        $CommandsTargetDir = Join-Path $env:USERPROFILE ".claude\commands"
    } else {
        $CommandsTargetDir = Join-Path (Get-Location) ".claude\commands"
    }
    if (Test-Path $CommandsTargetDir) {
        $CommandNames = Get-ChildItem -Path $CommandsSourceDir -Filter "*.md" |
                        Where-Object { $_.Name -ne "README.md" } |
                        Select-Object -ExpandProperty Name
        foreach ($name in $CommandNames) {
            $cpath = Join-Path $CommandsTargetDir $name
            if (Test-Path $cpath) {
                Remove-Item $cpath -Force
                Write-Host "[remove] /$($name.Replace('.md',''))" -ForegroundColor Yellow
            }
        }
    }
}

Write-Host ""
Write-Host "Removidos: $Removed agentes" -ForegroundColor Green
Write-Host "Seu memory/ e drafts continuam intactos." -ForegroundColor DarkGray
