# Guia de Instalação

Instala o squad de 9 agentes em outra conta Claude Code, em qualquer
sistema operacional.

---

## Pré-requisitos

| Ferramenta | Versão mínima | Verificar com |
|---|---|---|
| Git | 2.30+ | `git --version` |
| Python | 3.10+ (opcional, só para regerar PPTX) | `python --version` |
| Claude Code instalado | qualquer | abrir o app |

Sistema operacional: Windows 10/11, macOS 12+, ou Linux (Ubuntu 22+).

---

## Instalação em 3 passos

### 1. Clonar o repositório

```bash
git clone https://github.com/byfabioviana/agent-study-assistant.git
cd agent-study-assistant
```

### 2. Rodar o instalador

#### Windows (PowerShell, com permissão de execução de scripts)
```powershell
# Se for a primeira vez rodando script PS1, rode esta linha uma vez:
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

./install.ps1
```

#### Mac / Linux
```bash
chmod +x install.sh
./install.sh
```

O instalador é interativo e pergunta:

1. **Escopo de instalação** —
   - `user` — copia para `~/.claude/agents/` (todos os projetos veem)
   - `project` — copia para `<projeto-atual>/.claude/agents/` (só esse projeto)
2. **Sobrescrever existentes?** — se você já tem `methodology-advisor.md`
   etc., o script pergunta antes de substituir
3. **Inicializar templates de memória?** — copia `memory-templates/` para
   `memory/` do projeto (apenas se você confirmar)

### 3. Validar instalação

Abra Claude Code num diretório qualquer e digite:

```
/agents
```

Os 9 agentes devem aparecer na lista. Caso contrário, veja
[Troubleshooting](#troubleshooting).

---

## Configuração inicial (após instalar)

Em qualquer projeto onde você quer usar os agentes, crie:

```
seu-projeto-mestrado/
├── memory/
│   ├── project_thesis.md
│   ├── citation_style.md
│   ├── user_writing_voice.md
│   └── feedback_writing.md
└── ...
```

Os arquivos em `memory/` são **seus** (gitignorados). Use os arquivos em
`memory-templates/` como ponto de partida:

```bash
# Mac/Linux
cp memory-templates/*.template seu-projeto/memory/
cd seu-projeto/memory
for f in *.template; do mv "$f" "${f%.template}"; done

# Windows PowerShell
Copy-Item memory-templates/*.template seu-projeto/memory/
Get-ChildItem seu-projeto/memory/*.template | Rename-Item -NewName { $_.Name -replace '\.template$', '' }
```

Edite cada arquivo com as suas informações reais.

---

## Atualização

Quando sair uma nova versão:

```bash
# Mac/Linux
./update.sh

# Windows
./update.ps1
```

O script:
1. Faz `git pull` no repo
2. Reinstala os agentes (mesma escolha de escopo da última instalação)
3. **Não toca em `memory/`** dos seus projetos — só nos prompts dos agentes

Se houver mudança breaking, o `CHANGELOG.md` indica claramente.

---

## Desinstalação

```bash
./uninstall.sh   # Mac/Linux
./uninstall.ps1  # Windows
```

Remove os 9 arquivos de `~/.claude/agents/` (ou do escopo de projeto).
**Não** apaga o conteúdo do seu `memory/` ou seus drafts — o
desinstalador toca apenas nos arquivos copiados pelo instalador.

---

## Estrutura instalada

Após `install.ps1` ou `install.sh` com escopo `user`:

```
~/.claude/agents/
├── academic-researcher.md
├── academic-writer.md
├── ai-pattern-auditor.md
├── citation-manager.md
├── knowledge-architect.md
├── methodology-advisor.md
├── peer-reviewer.md
├── source-validator.md
└── voice-humanizer.md
```

(O `README.md` do diretório `agents/` **não** é copiado — ele explica os
agentes para humanos, não para o Claude Code.)

---

## Troubleshooting

### "/agents" não mostra os novos agentes

1. Confira o caminho:
   ```bash
   ls ~/.claude/agents/      # Mac/Linux
   ls $env:USERPROFILE\.claude\agents\   # Windows PS
   ```
2. Reinicie o Claude Code (`/clear` + reabrir)
3. Confira que o frontmatter YAML é válido — abra um agente e veja se
   tem `name:`, `description:`, `tools:`, `model:`

### "execution of scripts is disabled" no Windows

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### Permissão negada no Mac/Linux

```bash
chmod +x install.sh uninstall.sh update.sh
```

### Quero customizar um agente sem perder na próxima atualização

Faça fork do repo, customize na sua fork, e instale a partir dela:

```bash
git clone https://github.com/SEU-USER/agent-study-assistant.git
```

Rebase periodicamente com o upstream para receber correções.

---

## Suporte

- Issues: https://github.com/byfabioviana/agent-study-assistant/issues
- Mudanças: ver [CHANGELOG.md](./CHANGELOG.md)
