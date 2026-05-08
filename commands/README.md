# Slash Commands

Comandos customizados do Claude Code para automatizar setup e operação
do Agent Study Assistant.

## Comandos disponíveis

| Comando | Função |
|---|---|
| `/study-setup` | Instalação completa em uma única ação: agentes + pastas + memory + tour |
| `/study-setup --update` | Atualiza para última versão preservando memory/ |
| `/study-setup --uninstall` | Remove agentes preservando seu trabalho |
| `/study-setup --check` | Valida instalação atual sem modificar nada |

## Instalação dos comandos

Os instaladores `install.ps1` e `install.sh` na raiz do repo copiam
automaticamente todos os `.md` desta pasta para `~/.claude/commands/`.

### Instalação manual de apenas um comando

Se você quer apenas o `/study-setup` (sem instalar o squad ainda):

**Mac/Linux**:
```bash
mkdir -p ~/.claude/commands
curl -L https://raw.githubusercontent.com/byfabioviana/agent-study-assistant/main/commands/study-setup.md \
  -o ~/.claude/commands/study-setup.md
```

**Windows PowerShell**:
```powershell
New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude\commands" -Force
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/byfabioviana/agent-study-assistant/main/commands/study-setup.md" `
  -OutFile "$env:USERPROFILE\.claude\commands\study-setup.md"
```

Após isso, abra qualquer sessão do Claude Code e digite `/study-setup`.
O comando vai cuidar de baixar o repo completo, instalar os 9 agentes
e configurar tudo.

## Como funcionam os slash commands no Claude Code

- Arquivos `.md` em `~/.claude/commands/` viram comandos `/nome-do-arquivo`
- Frontmatter YAML define `description`, `allowed-tools`, `argument-hint`
- O conteúdo do `.md` é o **prompt** que o Claude executa quando você
  digita o comando
- Argumentos passados pelo usuário ficam em `$ARGUMENTS`

## Criando novos comandos

Veja os comandos existentes como referência. Estrutura mínima:

```markdown
---
description: O que o comando faz (curto)
allowed-tools: ["Bash", "Read", "Write"]
argument-hint: "[opcional: descricao-dos-args]"
---

Instruções para o Claude executar quando o usuário rodar este comando.
Pode usar $ARGUMENTS para acessar os argumentos.
```
