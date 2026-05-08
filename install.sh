#!/usr/bin/env bash
# Instalador do squad de agentes Claude Code (Mac / Linux)
# Uso: ./install.sh [--scope user|project] [--force] [--no-templates]

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCOPE="ask"
FORCE=0
NO_TEMPLATES=0

# --- parse args ---
while [[ $# -gt 0 ]]; do
    case $1 in
        --scope) SCOPE="$2"; shift 2 ;;
        --force) FORCE=1; shift ;;
        --no-templates) NO_TEMPLATES=1; shift ;;
        -h|--help)
            echo "Uso: $0 [--scope user|project] [--force] [--no-templates]"
            exit 0
            ;;
        *) echo "Argumento desconhecido: $1"; exit 1 ;;
    esac
done

# colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
DGREEN='\033[0;32m'
DGRAY='\033[1;30m'
NC='\033[0m'

VERSION=$(cat "$SCRIPT_DIR/VERSION" | tr -d '[:space:]')

echo ""
echo "==============================================="
echo " Agent Education Study - Instalador"
echo " v$VERSION"
echo "==============================================="
echo ""

# --- 1. determinar escopo ---
if [[ "$SCOPE" == "ask" ]]; then
    echo -e "${YELLOW}Escopo de instalacao:${NC}"
    echo "  [u] user    - copia para ~/.claude/agents/ (todos os projetos)"
    echo "  [p] project - copia para .claude/agents/ do diretorio atual"
    read -p "Escolha (u/p) [u]: " ans
    if [[ "$ans" == "p" || "$ans" == "P" ]]; then
        SCOPE="project"
    else
        SCOPE="user"
    fi
fi

if [[ "$SCOPE" == "user" ]]; then
    TARGET_DIR="$HOME/.claude/agents"
else
    TARGET_DIR="$(pwd)/.claude/agents"
fi

echo ""
echo -e "${CYAN}Destino: $TARGET_DIR${NC}"
echo ""

mkdir -p "$TARGET_DIR"

# --- 2. listar agentes ---
SOURCE_DIR="$SCRIPT_DIR/agents"
AGENT_FILES=()
while IFS= read -r f; do
    [[ "$(basename "$f")" == "README.md" ]] && continue
    AGENT_FILES+=("$f")
done < <(find "$SOURCE_DIR" -maxdepth 1 -name "*.md" | sort)

echo -e "${YELLOW}Agentes a instalar: ${#AGENT_FILES[@]}${NC}"
for f in "${AGENT_FILES[@]}"; do
    echo "  - $(basename "$f" .md)"
done
echo ""

# --- 3. copiar com confirmacao ---
INSTALLED=0
SKIPPED=0
OVERWRITTEN=0

for f in "${AGENT_FILES[@]}"; do
    name="$(basename "$f")"
    dest="$TARGET_DIR/$name"
    if [[ -f "$dest" ]]; then
        if [[ $FORCE -eq 1 ]]; then
            cp "$f" "$dest"
            echo -e "${YELLOW}[overwrite]${NC} $name"
            OVERWRITTEN=$((OVERWRITTEN+1))
        else
            if cmp -s "$f" "$dest"; then
                echo -e "${DGRAY}[unchanged]${NC} $name"
                SKIPPED=$((SKIPPED+1))
                continue
            fi
            read -p "Sobrescrever $name? (s/n) [n]: " ans
            if [[ "$ans" == "s" || "$ans" == "S" ]]; then
                cp "$f" "$dest"
                echo -e "${YELLOW}[overwrite]${NC} $name"
                OVERWRITTEN=$((OVERWRITTEN+1))
            else
                echo -e "${DGRAY}[skip]${NC} $name"
                SKIPPED=$((SKIPPED+1))
            fi
        fi
    else
        cp "$f" "$dest"
        echo -e "${GREEN}[install]${NC} $name"
        INSTALLED=$((INSTALLED+1))
    fi
done

# --- 4. templates de memoria ---
if [[ $NO_TEMPLATES -eq 0 ]]; then
    echo ""
    read -p "Inicializar templates de memoria em ./memory/? (s/n) [n]: " ans
    if [[ "$ans" == "s" || "$ans" == "S" ]]; then
        MEM_DIR="$(pwd)/memory"
        mkdir -p "$MEM_DIR"
        TPL_DIR="$SCRIPT_DIR/memory-templates"
        for t in "$TPL_DIR"/*.template; do
            [[ -f "$t" ]] || continue
            new_name="$(basename "$t" .template)"
            dest="$MEM_DIR/$new_name"
            if [[ -f "$dest" ]]; then
                echo -e "${DGRAY}[skip]${NC} memory/$new_name ja existe"
            else
                cp "$t" "$dest"
                echo -e "${GREEN}[init]${NC} memory/$new_name"
            fi
        done
    fi
fi

# --- 5. marcador ---
cat > "$TARGET_DIR/.agent-study-assistant.json" <<EOF
{
  "version": "$VERSION",
  "scope": "$SCOPE",
  "target": "$TARGET_DIR",
  "installed_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "source": "$SCRIPT_DIR"
}
EOF

# --- 6. resumo ---
echo ""
echo "==============================================="
echo " Instalacao concluida"
echo "==============================================="
echo -e "  Instalados:   ${GREEN}$INSTALLED${NC}"
if [[ $OVERWRITTEN -gt 0 ]]; then echo -e "  Sobrescritos: ${YELLOW}$OVERWRITTEN${NC}"; fi
if [[ $SKIPPED -gt 0 ]];     then echo -e "  Mantidos:     ${DGRAY}$SKIPPED${NC}"; fi
echo ""
echo -e "${CYAN}Proximos passos:${NC}"
echo "  1. Abra o Claude Code"
echo "  2. Digite /agents para confirmar a lista"
echo "  3. Edite memory/project_thesis.md com seu tema"
echo "  4. Acione voice-humanizer para aplicar o questionario"
echo ""
