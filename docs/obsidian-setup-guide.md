# Obsidian — Guia de Setup como Interface do Squad

> Tier 1 da estratégia de interface: Obsidian como UI moderna sobre o
> seu Drive sincronizado, com **assistente conversacional** que conhece
> seu vault, **queries SQL-like** sobre frontmatter e **grafo Zettelkasten**
> visual — tudo gratuito, local, integrado aos 9 agentes.

---

## Por que Obsidian (recap)

- Lê e escreve `.md` direto — **mesmos arquivos** que o Drive sincroniza
  e que os agentes Claude Code editam
- Wikilinks `[[nota]]` nativos (Zettelkasten)
- Frontmatter YAML reconhecido nativamente
- Grafo de conhecimento visual
- Plugin de IA (Smart Connections) com RAG sobre o vault inteiro
- Plugin Dataview faz queries no estilo banco de dados sobre seus `.md`
- 100% local, 100% gratuito, 100% offline

---

## Setup em 6 passos (~30 min)

### 1. Instalar Obsidian
Baixe em https://obsidian.md (Windows / Mac / Linux). Aplicação gratuita
para uso pessoal e acadêmico.

### 2. Abrir vault apontando para o Drive sincronizado

Pré-requisito: **Google Drive for Desktop** já sincronizando a pasta
`Mestrado-{Tema}/` localmente.

No Obsidian: `Open folder as vault` → selecione
`...\Google Drive\Meu Drive\Mestrado-{Tema}\`

> ⚠️ **Não** crie `.obsidian/` em outro lugar. O Drive vai sincronizar
> a configuração junto (incluindo seus plugins) entre máquinas.

### 3. Configurações iniciais essenciais

`Settings → Files & Links`:

| Opção | Valor recomendado |
|---|---|
| Default location for new notes | `00_Inbox/` |
| Default location for new attachments | `99_Sandbox/` |
| Use [[Wikilinks]] | ON |
| New link format | Shortest path |
| Detect all file extensions | ON |

`Settings → Editor`:

| Opção | Valor |
|---|---|
| Show line numbers | ON |
| Strict line breaks | ON |
| Indent visual cues | ON |

### 4. Instalar os 6 plugins essenciais

`Settings → Community plugins → Turn on community plugins`

Depois `Browse` e instale (todos gratuitos):

| Plugin | Autor | Função no seu fluxo |
|---|---|---|
| **Dataview** | Michael Brenan | Banco de dados visual sobre frontmatter |
| **Smart Connections** | Brian Petro | Chat com seu vault + busca semântica |
| **Templater** | SilentVoid | Templates de fichamento, nota atômica, draft |
| **Citations** | Hans Raaf | Inserir citações a partir do `biblio.bib` |
| **Excalidraw** | Zsolt Viczián | Diagramas hand-drawn nas notas |
| **Periodic Notes** | Liam Cain | Daily note automática (captura) |

Para cada um: clique no plugin → `Install` → `Enable`.

### 5. Configurar Smart Connections (assistente)

`Settings → Smart Connections`:

| Opção | Valor |
|---|---|
| Embedding model | `multi-qa-mpnet-base-dot-v1` (gratuito, local) — ou `text-embedding-3-small` se quiser usar OpenAI |
| Chat model | `Claude 3.5 Sonnet` se você tem API key, senão `Llama 3 local` via Ollama |
| Folders to include | Apenas `03_Resources/Notas-Atomicas/` e `Bibliografia/Fichamentos/` |
| Folders to exclude | `00_Inbox`, `99_Sandbox`, `04_Archive` |

> ⚠️ Primeira vez: o plugin vai gerar embeddings de todas as notas. Pode
> levar 5-30 minutos dependendo do volume. Deixe rodando em background.

### 6. Configurar Citations

`Settings → Citations`:

| Opção | Valor |
|---|---|
| Citation database path | `03_Resources/Bibliografia/biblio.bib` |
| Default citation key prefix | `@` |
| Hotkey "Insert citation" | `Ctrl+Shift+E` |

Pronto. Comando `Insert literature note` cria automaticamente um
fichamento em `03_Resources/Bibliografia/Fichamentos/{citekey}.md` com
frontmatter já preenchido.

---

## Workspace recomendado

`Settings → Hotkeys` para configurar atalhos. Layout sugerido:

```
┌──────────────┬──────────────────────────┬──────────────────────┐
│ FILE TREE    │ EDITOR                   │ RIGHT SIDEBAR        │
│              │                          │                      │
│ 00_Inbox/    │ # Nota em edicao         │ • Outline            │
│ 01_Projects/ │                          │ • Backlinks          │
│ 02_Areas/    │ Sustento, em dialogo    │ • Tags               │
│ 03_Resources │ critico com Han (2014), │ • Notas similares    │
│   Bibliogr.  │ que o cansaco descrito  │   (Smart Conn.)      │
│   Notas      │ por ele nao substitui...│                      │
│ 04_Archive/  │                          │ ─── CHAT ───         │
│              │                          │ > resuma o debate   │
│ TAGS PANE    │                          │   Foucault vs Han   │
│ #foucault    │                          │   nas minhas notas  │
│ #vigilancia  │                          │                      │
│ ...          │                          │                      │
└──────────────┴──────────────────────────┴──────────────────────┘
```

Salve como workspace: `Settings → Workspaces → Save current`. Crie
workspaces alternativos para "Leitura", "Escrita", "Revisão".

---

## Como cada modo de consulta funciona na prática

### Modo 1 — Hierárquico (file tree)
Use quando souber **onde** o conteúdo está. Navegação direta.

### Modo 2 — Por tag (tag pane)
Use quando souber o **tema**. Click em `#foucault` mostra todas as notas
com a tag.

### Modo 3 — Grafo (`Ctrl+G`)
Use quando quiser ver **conexões emergentes**. Filtros por tag, por
pasta, por data permitem isolar sub-redes.

### Modo 4 — Query Dataview
Use quando quiser **lista filtrada/ordenada**. Veja arquivo separado
[`obsidian-queries-dataview.md`](./obsidian-queries-dataview.md) com
dezenas de queries prontas para copiar.

### Modo 5 — Chat (Smart Connections)
Use quando quiser **resposta conversacional** baseada no conteúdo.

Exemplos de perguntas que funcionam bem:
- *"Quais notas tenho que conectam Foucault e Deleuze?"*
- *"Resuma o que aprendi sobre vigilância digital nos últimos 30 dias"*
- *"Há contradição entre minhas notas sobre `#poder` e `#cansaco`?"*
- *"Quais autores aparecem em pelo menos 5 notas mas não estão no
  meu `biblio.bib`?"*

O chat sempre **cita as notas** que usou na resposta — clique para abrir.

---

## Templates de Templater (cole em `Templates/`)

Crie pasta `03_Resources/Templates/` e adicione:

### `nota-atomica.md`

```markdown
---
id: <% tp.date.now("YYYYMMDDHHmm") %>
title: <% tp.file.title %>
type: nota
status: raw
tags: []
project: ""
related: []
sources: []
created: <% tp.date.now("YYYY-MM-DD") %>
modified: <% tp.date.now("YYYY-MM-DD") %>
---

# <% tp.file.title %>

{Tese da nota — uma frase}

## Por que importa para minha pesquisa

## Conecta com
- [[]]

## Tensão / contradição

## Pergunta aberta
```

### `fichamento.md`

```markdown
---
type: lit
citekey: 
status: raw
read_date: <% tp.date.now("YYYY-MM-DD") %>
---

# {Título} — {Autor}

## Tese central
{uma frase}

## Argumentos principais
1. 
2. 

## Citações-chave (com página)
> "" (p. )

## Conceitos novos
- ****: 

## Como dialoga com sua pesquisa

## Notas atômicas geradas
- [[]]
```

### `daily-note.md`

```markdown
---
date: <% tp.date.now("YYYY-MM-DD") %>
type: daily
---

# <% tp.date.now("dddd, DD [de] MMMM [de] YYYY") %>

## Capturas de hoje
- 

## Ideias rápidas
- 

## Notas atômicas geradas hoje

## Próxima ação
```

`Settings → Templater → Template hotkeys`: configure atalhos
(ex: `Ctrl+Shift+N` = nota atômica).

---

## Integração com o squad de agentes Claude Code

Os agentes operam sobre os mesmos arquivos `.md` que o Obsidian edita.
Fluxo recomendado:

```
1. Você edita uma nota no Obsidian
2. Ctrl+Shift+P → "Open in default app" (ou abre terminal externo)
3. No terminal Claude Code, dentro da pasta do vault:
   /humanizar drafts/capitulo-2.md
4. voice-humanizer reescreve o arquivo .md
5. Obsidian recarrega automaticamente (file watcher nativo)
6. Smart Connections re-embedda em background
```

### Plugin opcional — Terminal embutido
- **Terminal** (Friedrich Adam) — abre terminal **dentro** do Obsidian,
  apontando direto para a pasta do vault. Permite acionar Claude Code
  sem sair da interface.

---

## Sincronização entre máquinas

Como o vault está dentro do Google Drive sincronizado, **todos os seus
plugins e configurações** sincronizam automaticamente entre PC, Mac e
celular (Obsidian Mobile). Não precisa do Obsidian Sync (pago).

⚠️ Cuidado: se você abrir o mesmo vault em dois dispositivos
simultaneamente e ambos editarem o mesmo arquivo, o Drive pode gerar
"conflicted copy". Boa prática: feche em um antes de abrir no outro.

---

## Tema visual Oxford Heritage (opcional)

Para alinhar com o branding deste projeto, instale o tema **Minimal**
(autor Stephan Ango), que aceita customização CSS. Em
`Settings → Appearance → CSS snippets`, crie `oxford-heritage.css`:

```css
/* Oxford Heritage v2.0 — paleta */
.theme-dark {
  --background-primary: #0B2823;
  --background-primary-alt: #2D453E;
  --background-secondary: #2D453E;
  --background-secondary-alt: #3A564E;
  --text-normal: #F4F1EA;
  --text-muted: #AAAAAA;
  --text-accent: #C5B358;
  --text-accent-hover: #D4C878;
  --interactive-accent: #C5B358;
  --interactive-accent-hover: #D4C878;
  --tag-color: #D4C878;
  --link-color: #C5B358;
  --h1-color: #C5B358;
}

.theme-light {
  --background-primary: #F4F1EA;
  --background-primary-alt: #E0DDD5;
  --text-normal: #1E1E1E;
  --text-accent: #2D453E;
  --interactive-accent: #C5B358;
  --link-color: #2D6E43;
}

/* Tipografia (instale Plus Jakarta Sans, Lora, IBM Plex Mono no SO) */
body {
  --font-text: "Plus Jakarta Sans", -apple-system, sans-serif;
  --font-interface: "Plus Jakarta Sans", sans-serif;
  --font-monospace: "IBM Plex Mono", "Cascadia Code", monospace;
  --font-h1: "Lora", "Plus Jakarta Sans", serif;
}

/* Tipografia: titulos display em Lora */
.markdown-preview-view h1,
.cm-header-1 {
  font-family: "Lora", serif !important;
  font-weight: 700;
}
```

Ative em `Settings → Appearance → CSS snippets → oxford-heritage` (toggle ON).

---

## Próximos passos

1. **Concluir o setup** (passos 1-6 deste guia, ~30 min)
2. **Aplicar tema Oxford** (opcional, 5 min)
3. **Criar 5 notas atômicas** para popular o grafo
4. **Testar Smart Connections** com 3 perguntas reais
5. **Validar fluxo Claude Code ↔ Obsidian** (acionar agente, ver
   atualização automática no Obsidian)
6. Se algo faltar (dashboard customizado, multi-usuário, integração
   externa), partimos para Tier 2 (app web custom)

---

## Referências

- Documentação oficial: https://help.obsidian.md
- Smart Connections: https://github.com/brianpetro/obsidian-smart-connections
- Dataview: https://blacksmithgu.github.io/obsidian-dataview/
- Templater: https://silentvoid13.github.io/Templater/
- Tema Minimal: https://minimal.guide
