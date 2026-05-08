# Agent Education Study

> Squad de 9 agentes Claude Code especializados em apoiar uma jornada de
> mestrado: pesquisa, validação, organização do conhecimento, redação,
> formatação, auditoria de padrões de IA, voz autoral e revisão crítica.

[![Version](https://img.shields.io/badge/version-1.0.0-c5b358)](./VERSION)
[![License](https://img.shields.io/badge/license-MIT-0b2823)](./LICENSE)
[![Made with Claude Code](https://img.shields.io/badge/Claude%20Code-9%20agents-2d453e)](https://claude.com/claude-code)

---

## Visão geral

Este repositório entrega **infraestrutura cognitiva** para mestrandos que
usam IA como copiloto de pesquisa. Combina três frameworks consagrados:

| Framework | Autor | Camada |
|---|---|---|
| **PARA** | Tiago Forte | Organização macro (onde guardar) |
| **Zettelkasten** | Niklas Luhmann | Núcleo da tese (onde pensar) |
| **CODE** | Tiago Forte | Fluxo operacional (como avançar) |

Os 9 agentes operam sobre uma estrutura de pastas Google Drive, lendo e
escrevendo arquivos `.md` com frontmatter YAML como contrato.

---

## O squad

| # | Agente | Função | Modelo |
|---|---|---|---|
| 1 | `methodology-advisor` | Desenho metodológico (qual/quant/misto) | opus |
| 2 | `academic-researcher` | Busca em Scholar, SciELO, CAPES | sonnet |
| 3 | `source-validator` | Auditoria anti-alucinação | sonnet |
| 4 | `knowledge-architect` | Zettelkasten / segundo cérebro | sonnet |
| 5 | `academic-writer` | Redação ABNT/APA | opus |
| 6 | `citation-manager` | Gestão de `biblio.bib` | haiku |
| 7 | `ai-pattern-auditor` | Mapa de calor de marcas de IA | opus |
| 8 | `voice-humanizer` | Voz autoral + questionário de calibração | opus |
| 9 | `peer-reviewer` | Banca simulada | opus |

Detalhamento completo em [`agents/README.md`](./agents/README.md).

---

## Instalação

### 🚀 Para quem não programa — copie, cole, pronto

**[➡️ Vá direto para o INSTALL-FACIL.md](./INSTALL-FACIL.md)**

É um único arquivo com prompts prontos em português. Você copia, cola
no Claude Code, responde 3-4 perguntas e está tudo configurado em
~5 minutos. **Sem terminal, sem comandos técnicos.**

---

### ⚡ Modo intermediário — comando `/study-setup`

Se você já usa Claude Code, só precisa baixar **um único arquivo** e
rodar `/study-setup` em qualquer sessão. O comando faz tudo: clona o
repo, instala os 9 agentes, cria a árvore de pastas PARA + Zettelkasten,
inicializa `memory/` com seu tema/norma, e te dá um tour pelos agentes.

**Mac/Linux**:
```bash
mkdir -p ~/.claude/commands && \
curl -L https://raw.githubusercontent.com/byfabioviana/agent-study-assistant/main/commands/study-setup.md \
  -o ~/.claude/commands/study-setup.md
```

**Windows PowerShell**:
```powershell
New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude\commands" -Force | Out-Null
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/byfabioviana/agent-study-assistant/main/commands/study-setup.md" `
  -OutFile "$env:USERPROFILE\.claude\commands\study-setup.md"
```

Depois, abra **qualquer sessão do Claude Code** e digite:

```
/study-setup
```

O comando é interativo, leva ~5 minutos e termina com o tour pelos
agentes. Use `/study-setup --update` para atualizar e
`/study-setup --check` para validar.

### Instalação manual (alternativa)

Se preferir clonar o repo inteiro e rodar o instalador shell:

**Windows (PowerShell)**:
```powershell
git clone https://github.com/byfabioviana/agent-study-assistant.git
cd agent-study-assistant
./install.ps1
```

**Mac / Linux**:
```bash
git clone https://github.com/byfabioviana/agent-study-assistant.git
cd agent-study-assistant
chmod +x install.sh && ./install.sh
```

O instalador copia agentes (`~/.claude/agents/`) e comandos
(`~/.claude/commands/`), com confirmação para cada sobrescrita.

Guia detalhado em [`INSTALL.md`](./INSTALL.md).

---

## Estrutura do repositório

```
agent-study-assistant/
├── agents/                    # 9 agentes — copiados para ~/.claude/agents/
│   ├── README.md
│   └── *.md
├── docs/                      # Documentação e apresentações
│   ├── curadoria-conteudo-plano.md
│   └── curadoria-verticalis-deck.pptx
├── scripts/                   # Geradores de PPTX
│   └── generate_pptx_verticalis.py
├── memory-templates/          # Templates iniciais para memory/ do usuário
│   ├── project_thesis.md.template
│   ├── citation_style.md.template
│   ├── user_writing_voice.md.template
│   └── README.md
├── .claude/
│   └── plan/                  # Planos de implementação
├── .github/
│   └── workflows/             # CI: validação dos agentes
├── install.ps1 / install.sh   # Instaladores
├── uninstall.ps1 / uninstall.sh
├── update.ps1 / update.sh
├── README.md  (este arquivo)
├── INSTALL.md
├── CHANGELOG.md
├── LICENSE
└── VERSION
```

---

## Estrutura de pastas recomendada para o seu projeto de pesquisa

(Crie em uma pasta sincronizada pelo Google Drive — **não** dentro deste
repositório)

```
Mestrado-{Tema}/
├── 00_Inbox/                  # capturas brutas
├── 01_Projects/               # P do PARA — projetos com prazo
├── 02_Areas/                  # A do PARA — responsabilidades contínuas
├── 03_Resources/              # R do PARA — temáticos
│   ├── Bibliografia/
│   └── Notas-Atomicas/        # núcleo Zettelkasten
├── 04_Archive/                # A do PARA — concluído
├── 99_Sandbox/                # rascunhos descartáveis
└── memory/                    # contexto persistente para os agentes
```

---

## Interface recomendada — Obsidian

Você consome o vault sincronizado pelo Drive através do **Obsidian**
(gratuito, local, offline) com 6 plugins essenciais — incluindo um
**chat com seu vault** (Smart Connections), **queries SQL-like** sobre
frontmatter (Dataview) e **grafo Zettelkasten** visual.

Setup completo (~30 min) em [`docs/obsidian-setup-guide.md`](./docs/obsidian-setup-guide.md).
Queries Dataview prontas para copiar em [`docs/obsidian-queries-dataview.md`](./docs/obsidian-queries-dataview.md).

Os agentes Claude Code editam os mesmos arquivos `.md` que o Obsidian
exibe — sem duplicação, sem sincronização extra.

---

## Workflow de submissão (fluxo completo)

```
academic-writer     →   gera draft a partir das notas atômicas
        ↓
source-validator    →   audita citações (anti-alucinação)
        ↓
ai-pattern-auditor  →   mapa de calor parágrafo a parágrafo
        ↓
voice-humanizer     →   reescrita focada nos trechos 🔴/🟠
        ↓
peer-reviewer       →   banca simulada (10 piores perguntas)
        ↓
citation-manager    →   formata referências finais
        ↓
                        SUBMISSÃO
```

---

## Princípios éticos

1. **Autoria é sua** — os agentes são ferramenta; nunca substituto
2. **`voice-humanizer` ≠ evasão de detector** — ele exige sua intervenção
   intelectual em cada parágrafo. Texto que você não defende em 30 s
   oralmente é reescrito por **você**, não maquiado pelo agente
3. **Declaração de uso de IA** — se sua instituição exige, declare. O
   propósito aqui é qualidade autoral, não disfarce
4. **`source-validator` é mandatório** — toda citação verificada contra
   fonte primária antes de submeter

---

## Atualização

```bash
# Mac/Linux
./update.sh

# Windows
./update.ps1
```

Puxa última versão do GitHub e reinstala os agentes preservando seu
`memory/` local.

---

## Desinstalação

```bash
./uninstall.sh   # Mac/Linux
./uninstall.ps1  # Windows
```

Remove os agentes de `~/.claude/agents/` mantendo seu `memory/` intacto.

---

## Contribuir

Issues e PRs bem-vindos. Para mudanças significativas, abra uma issue
primeiro discutindo a proposta.

```bash
git checkout -b feat/nome-da-feature
# faça suas mudanças
git commit -m "feat: descricao"
git push -u origin feat/nome-da-feature
gh pr create
```

---

## Licença

[MIT](./LICENSE) — uso livre, inclusive comercial e acadêmico.
