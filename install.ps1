# Instalador do squad de agentes Claude Code (Windows / PowerShell)
# Uso: ./install.ps1 [-Scope user|project] [-Force] [-NoTemplates]

[CmdletBinding()]
param(
    [ValidateSet("user", "project", "ask")]
    [string]$Scope = "ask",
    [switch]$Force,
    [switch]$NoTemplates
)

$ErrorActionPreference = "Stop"
$ScriptRoot = $PSScriptRoot

Write-Host ""
Write-Host "===============================================" -ForegroundColor DarkGreen
Write-Host " Agent Education Study - Instalador" -ForegroundColor DarkGreen
Write-Host " v$(Get-Content "$ScriptRoot\VERSION")" -ForegroundColor DarkGreen
Write-Host "===============================================" -ForegroundColor DarkGreen
Write-Host ""

# --- 1. Determinar escopo ---
if ($Scope -eq "ask") {
    Write-Host "Escopo de instalacao:" -ForegroundColor Yellow
    Write-Host "  [u] user    - copia para ~/.claude/agents/ (todos os projetos)"
    Write-Host "  [p] project - copia para .claude/agents/ do diretorio atual"
    $ans = Read-Host "Escolha (u/p) [u]"
    if ($ans -eq "p" -or $ans -eq "P") { $Scope = "project" } else { $Scope = "user" }
}

if ($Scope -eq "user") {
    $TargetDir = Join-Path $env:USERPROFILE ".claude\agents"
} else {
    $TargetDir = Join-Path (Get-Location) ".claude\agents"
}

Write-Host ""
Write-Host "Destino: $TargetDir" -ForegroundColor Cyan
Write-Host ""

# --- 2. Criar diretorio se nao existir ---
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    Write-Host "Criado: $TargetDir" -ForegroundColor Green
}

# --- 3. Listar agentes a instalar ---
$SourceDir = Join-Path $ScriptRoot "agents"
$AgentFiles = Get-ChildItem -Path $SourceDir -Filter "*.md" |
              Where-Object { $_.Name -ne "README.md" }

Write-Host "Agentes a instalar: $($AgentFiles.Count)" -ForegroundColor Yellow
foreach ($f in $AgentFiles) {
    Write-Host "  - $($f.BaseName)"
}
Write-Host ""

# --- 4. Copiar com confirmacao ---
$Installed = 0
$Skipped = 0
$Overwritten = 0

foreach ($f in $AgentFiles) {
    $dest = Join-Path $TargetDir $f.Name
    if (Test-Path $dest) {
        if ($Force) {
            Copy-Item $f.FullName $dest -Force
            Write-Host "[overwrite] $($f.Name)" -ForegroundColor Yellow
            $Overwritten++
        } else {
            $existing = Get-Content $dest -Raw
            $new = Get-Content $f.FullName -Raw
            if ($existing -eq $new) {
                Write-Host "[unchanged] $($f.Name)" -ForegroundColor DarkGray
                $Skipped++
                continue
            }
            $ans = Read-Host "Sobrescrever $($f.Name)? (s/n) [n]"
            if ($ans -eq "s" -or $ans -eq "S") {
                Copy-Item $f.FullName $dest -Force
                Write-Host "[overwrite] $($f.Name)" -ForegroundColor Yellow
                $Overwritten++
            } else {
                Write-Host "[skip] $($f.Name)" -ForegroundColor DarkGray
                $Skipped++
            }
        }
    } else {
        Copy-Item $f.FullName $dest
        Write-Host "[install] $($f.Name)" -ForegroundColor Green
        $Installed++
    }
}

# --- 4b. Instalar slash commands ---
$CommandsSourceDir = Join-Path $ScriptRoot "commands"
if (Test-Path $CommandsSourceDir) {
    if ($Scope -eq "user") {
        $CommandsTargetDir = Join-Path $env:USERPROFILE ".claude\commands"
    } else {
        $CommandsTargetDir = Join-Path (Get-Location) ".claude\commands"
    }
    if (-not (Test-Path $CommandsTargetDir)) {
        New-Item -ItemType Directory -Path $CommandsTargetDir -Force | Out-Null
    }
    $CommandFiles = Get-ChildItem -Path $CommandsSourceDir -Filter "*.md" |
                    Where-Object { $_.Name -ne "README.md" }
    Write-Host ""
    Write-Host "Instalando slash commands em: $CommandsTargetDir" -ForegroundColor Cyan
    foreach ($f in $CommandFiles) {
        $dest = Join-Path $CommandsTargetDir $f.Name
        Copy-Item $f.FullName $dest -Force
        Write-Host "[install] /$($f.BaseName)" -ForegroundColor Green
    }
}

# --- 5. Templates de memoria (opcional) ---
if (-not $NoTemplates) {
    Write-Host ""
    $ans = Read-Host "Inicializar templates de memoria em ./memory/? (s/n) [n]"
    if ($ans -eq "s" -or $ans -eq "S") {
        $MemoryDir = Join-Path (Get-Location) "memory"
        if (-not (Test-Path $MemoryDir)) {
            New-Item -ItemType Directory -Path $MemoryDir -Force | Out-Null
        }
        $TemplateDir = Join-Path $ScriptRoot "memory-templates"
        $tpls = Get-ChildItem -Path $TemplateDir -Filter "*.template"
        foreach ($t in $tpls) {
            $newName = $t.Name -replace '\.template$', ''
            $dest = Join-Path $MemoryDir $newName
            if (Test-Path $dest) {
                Write-Host "[skip] memory/$newName ja existe" -ForegroundColor DarkGray
            } else {
                Copy-Item $t.FullName $dest
                Write-Host "[init] memory/$newName" -ForegroundColor Green
            }
        }
    }
}

# --- 6. Salvar marcador de instalacao ---
$Marker = @{
    version = (Get-Content "$ScriptRoot\VERSION").Trim()
    scope = $Scope
    target = $TargetDir
    installed_at = (Get-Date -Format "yyyy-MM-ddTHH:mm:ss")
    source = $ScriptRoot
} | ConvertTo-Json
$MarkerPath = Join-Path $TargetDir ".agent-study-assistant.json"
$Marker | Out-File -FilePath $MarkerPath -Encoding UTF8

# --- 7. Resumo ---
Write-Host ""
Write-Host "===============================================" -ForegroundColor DarkGreen
Write-Host " Instalacao concluida" -ForegroundColor DarkGreen
Write-Host "===============================================" -ForegroundColor DarkGreen
Write-Host "  Instalados:   $Installed" -ForegroundColor Green
if ($Overwritten -gt 0) { Write-Host "  Sobrescritos: $Overwritten" -ForegroundColor Yellow }
if ($Skipped -gt 0)     { Write-Host "  Mantidos:     $Skipped" -ForegroundColor DarkGray }
Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Cyan
Write-Host "  1. Abra o Claude Code"
Write-Host "  2. Digite /agents para confirmar a lista"
Write-Host "  3. Edite memory/project_thesis.md com seu tema"
Write-Host "  4. Acione voice-humanizer para aplicar o questionario"
Write-Host ""
