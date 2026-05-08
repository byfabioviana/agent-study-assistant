# Atualizador (Windows)
$ErrorActionPreference = "Stop"
$ScriptRoot = $PSScriptRoot

Write-Host ""
Write-Host "Puxando ultima versao do GitHub..." -ForegroundColor Cyan

Set-Location $ScriptRoot
git pull --ff-only

Write-Host ""
Write-Host "Reinstalando agentes..." -ForegroundColor Cyan

# Detectar escopo da ultima instalacao se houver marker
$UserMarker = Join-Path $env:USERPROFILE ".claude\agents\.agent-study-assistant.json"
$ProjectMarker = Join-Path (Get-Location) ".claude\agents\.agent-study-assistant.json"

if (Test-Path $UserMarker) {
    & "$ScriptRoot\install.ps1" -Scope user -Force
} elseif (Test-Path $ProjectMarker) {
    & "$ScriptRoot\install.ps1" -Scope project -Force
} else {
    & "$ScriptRoot\install.ps1"
}

Write-Host ""
Write-Host "Atualizacao concluida. Versao: $(Get-Content $ScriptRoot\VERSION)" -ForegroundColor Green
