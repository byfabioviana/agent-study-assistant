#!/usr/bin/env bash
# Desinstalador (Mac/Linux)
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCOPE="ask"

while [[ $# -gt 0 ]]; do
    case $1 in
        --scope) SCOPE="$2"; shift 2 ;;
        *) shift ;;
    esac
done

if [[ "$SCOPE" == "ask" ]]; then
    echo "De qual escopo desinstalar?"
    echo "  [u] user    - ~/.claude/agents/"
    echo "  [p] project - .claude/agents/ aqui"
    read -p "Escolha (u/p) [u]: " ans
    if [[ "$ans" == "p" || "$ans" == "P" ]]; then SCOPE="project"; else SCOPE="user"; fi
fi

if [[ "$SCOPE" == "user" ]]; then
    TARGET_DIR="$HOME/.claude/agents"
else
    TARGET_DIR="$(pwd)/.claude/agents"
fi

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Diretorio nao existe: $TARGET_DIR"
    exit 0
fi

SOURCE_DIR="$SCRIPT_DIR/agents"
echo ""
echo "Removendo de: $TARGET_DIR"
echo ""

REMOVED=0
for f in "$SOURCE_DIR"/*.md; do
    name="$(basename "$f")"
    [[ "$name" == "README.md" ]] && continue
    if [[ -f "$TARGET_DIR/$name" ]]; then
        rm -f "$TARGET_DIR/$name"
        echo "[remove] $name"
        REMOVED=$((REMOVED+1))
    fi
done

rm -f "$TARGET_DIR/.agent-study-assistant.json"

# Slash commands
COMMANDS_SOURCE="$SCRIPT_DIR/commands"
if [[ -d "$COMMANDS_SOURCE" ]]; then
    if [[ "$SCOPE" == "user" ]]; then
        COMMANDS_TARGET="$HOME/.claude/commands"
    else
        COMMANDS_TARGET="$(pwd)/.claude/commands"
    fi
    if [[ -d "$COMMANDS_TARGET" ]]; then
        for c in "$COMMANDS_SOURCE"/*.md; do
            [[ -f "$c" ]] || continue
            cname="$(basename "$c")"
            [[ "$cname" == "README.md" ]] && continue
            if [[ -f "$COMMANDS_TARGET/$cname" ]]; then
                rm -f "$COMMANDS_TARGET/$cname"
                cbase="${cname%.md}"
                echo "[remove] /$cbase"
            fi
        done
    fi
fi

echo ""
echo "Removidos: $REMOVED agentes"
echo "Seu memory/ e drafts continuam intactos."
