#!/usr/bin/env bash
# Atualizador (Mac/Linux)
set -euo pipefail
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ""
echo "Puxando ultima versao do GitHub..."

cd "$SCRIPT_DIR"
git pull --ff-only

echo ""
echo "Reinstalando agentes..."

USER_MARKER="$HOME/.claude/agents/.agent-study-assistant.json"
PROJECT_MARKER="$(pwd)/.claude/agents/.agent-study-assistant.json"

if [[ -f "$USER_MARKER" ]]; then
    "$SCRIPT_DIR/install.sh" --scope user --force
elif [[ -f "$PROJECT_MARKER" ]]; then
    "$SCRIPT_DIR/install.sh" --scope project --force
else
    "$SCRIPT_DIR/install.sh"
fi

echo ""
echo "Atualizacao concluida. Versao: $(cat "$SCRIPT_DIR/VERSION")"
