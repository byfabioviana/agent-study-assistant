# Plano Organizacional para Curadoria de Conteúdos Acadêmicos

> Sistema de curadoria pensado para uma jornada de mestrado, garantindo recuperação rápida, contexto persistente e integração com os 8 agentes do squad acadêmico.

---

## 1. Filosofia de curadoria

Combinamos três frameworks consagrados:

| Framework | Autor | O que aporta |
|---|---|---|
| **PARA** | Tiago Forte | Organização por nível de acionabilidade (Projetos → Áreas → Recursos → Arquivo) |
| **Zettelkasten** | Niklas Luhmann | Notas atômicas linkadas — núcleo do conhecimento |
| **CODE** | Tiago Forte | Workflow: **C**apture → **O**rganize → **D**istill → **E**xpress |

Princípio orientador: **organização por uso, não por origem**. Não importa de onde veio (PDF, podcast, conversa) — o que importa é onde a informação será **acionada** quando você precisar dela.

---

## 2. Plataforma escolhida — **Google Drive**

### Por quê Google Drive (vs OneDrive)

| Critério | Google Drive | OneDrive | Vencedor |
|---|---|---|---|
| Espaço grátis | 15 GB | 5 GB | 🟢 GDrive |
| OCR em PDFs | Nativo | Limitado | 🟢 GDrive |
| Busca dentro de PDFs | Nativa | Sim | 🟡 Empate |
| Integração Scholar | Library nativa | Não | 🟢 GDrive |
| Google Colab (análise) | Nativo | Não | 🟢 GDrive |
| Convênio universitário | Frequente (Workspace EDU) | Frequente (M365 EDU) | 🟡 Depende |
| Colaboração com orientador | Docs simultâneo | Word web/desktop | 🟡 Empate |
| Versionamento | 30 dias / 100 versões | 30 dias / 25 versões | 🟢 GDrive |
| Cliente desktop Windows | Drive for Desktop | Nativo | 🟡 Empate |

### Quando preferir OneDrive
- Sua universidade oferece **Microsoft 365 Education com 1TB** (verifique antes de escolher)
- Você trabalha intensivamente com **Word desktop** + **EndNote** + **Mendeley desktop**
- Equipe da pesquisa já usa Teams + SharePoint

### Decisão default: **Google Drive** (recomendado)

Justificativa: melhor custo-benefício no plano gratuito + Scholar Library + Colab são vantagens decisivas para mestrado.

---

## 3. Estrutura de pastas no Google Drive

```
📁 Mestrado-{Tema}/
├── 📁 00_Inbox/                    ← capturas brutas (esvaziar semanalmente)
│
├── 📁 01_Projects/                 ← P do PARA: têm prazo
│   ├── 📁 2026-Dissertacao/
│   │   ├── 📁 drafts/
│   │   ├── 📁 figuras/
│   │   ├── 📁 dados/
│   │   └── 📄 README.md            ← objetivos, prazos, status
│   ├── 📁 2026-Q3-Artigo-Periodico/
│   ├── 📁 2026-Q4-Qualificacao/
│   └── 📁 2026-Q2-Disciplina-Metodologia/
│
├── 📁 02_Areas/                    ← A do PARA: contínuas, sem prazo
│   ├── 📁 Linha-Pesquisa/          ← seu campo principal
│   ├── 📁 Orientacao/              ← atas, e-mails, decisões
│   ├── 📁 Disciplinas/             ← cursadas e em curso
│   └── 📁 Carreira-Academica/      ← editais, bolsas, congressos
│
├── 📁 03_Resources/                ← R do PARA: temáticos, consultáveis
│   ├── 📁 Bibliografia/
│   │   ├── 📁 PDFs/                ← {citekey}.pdf
│   │   ├── 📁 Fichamentos/         ← {citekey}.md
│   │   └── 📄 biblio.bib           ← gerado pelo citation-manager
│   ├── 📁 Notas-Atomicas/          ← Zettelkasten núcleo
│   │   ├── 📁 inbox/
│   │   ├── 📁 permanent/
│   │   └── 📁 index/               ← MOCs (Maps of Content)
│   ├── 📁 Templates/               ← .md, .docx, .tex modelo
│   ├── 📁 Metodos/                 ← protocolos, instrumentos validados
│   └── 📁 Glossario/               ← conceitos do campo
│
├── 📁 04_Archive/                  ← A do PARA: concluído ou inativo
│   └── 📁 {ano}-{slug}/
│
└── 📁 99_Sandbox/                  ← experimentos, rascunhos descartáveis
```

### Por que esta numeração
- Pastas iniciadas com número aparecem **sempre na mesma ordem** (Drive ordena lexicograficamente)
- `00_Inbox` no topo lembra de processar
- `99_Sandbox` no fundo isola experimentos
- Niveis 01–04 seguem PARA na ordem de acionabilidade decrescente

---

## 4. Convenção de nomenclatura (CRÍTICO)

Todo arquivo segue:

```
YYYYMMDD-tipo-slug-em-kebab-case.ext
```

### Tipos canônicos

| Prefixo | Significado | Exemplo |
|---|---|---|
| `lit` | Fichamento de literatura | `20260507-lit-foucault-vigiar-punir.md` |
| `nota` | Nota atômica permanente | `20260507-nota-poder-disciplinar-modulacao.md` |
| `draft` | Rascunho de texto autoral | `20260507-draft-cap2-secao3.md` |
| `dado` | Dataset bruto/tratado | `20260507-dado-entrevistas-codificadas.csv` |
| `fig` | Figura/diagrama | `20260507-fig-modelo-conceitual.png` |
| `tab` | Tabela | `20260507-tab-perfil-amostra.xlsx` |
| `slides` | Apresentação | `20260507-slides-qualificacao-v2.pptx` |
| `audio` | Áudio (entrevista, sua voz) | `20260507-audio-entrevista-p07.mp3` |
| `transcript` | Transcrição | `20260507-transcript-entrevista-p07.md` |
| `analise` | Output de análise | `20260507-analise-conteudo-categorias.md` |
| `peer` | Peer review | `20260507-peer-cap2-v1.md` |
| `meeting` | Ata de orientação | `20260507-meeting-orientador.md` |

### Por quê este formato
- **Data ISO ordenável** — listar por nome ordena por tempo automaticamente
- **Tipo no nome** — você filtra com `Ctrl+F` qualquer coisa (ex.: digitar `lit-foucault` localiza)
- **Kebab-case** — funciona em Windows, Mac, Linux, URLs, Drive, Git

---

## 5. Frontmatter YAML — metadados que viram superpoderes

Todo arquivo `.md` começa com:

```markdown
---
id: 202605071430
title: Poder disciplinar opera por modulação contínua
type: nota                         # lit | nota | draft | analise | peer
status: connected                  # raw | refined | connected | cited
tags: [poder, vigilancia, foucault, modulacao]
project: 2026-Dissertacao
area: Linha-Pesquisa
related:
  - "[[202604201430-poder-disciplinar]]"
  - "[[202604180900-zuboff-capitalismo]]"
sources:
  - foucault1975
  - deleuze1992
created: 2026-05-07
modified: 2026-05-07
voice_calibrated: true             # passou pelo voice-humanizer?
---

# Conteúdo da nota...
```

### Por quê isto importa

- **Pesquisa por metadado** — `grep -l "tags: .*foucault" notes/permanent/*.md` lista tudo sobre Foucault
- **Status visível** — você sabe o que está cru e o que está pronto
- **Links bidirecionais** — `related` permite reconstruir a rede mesmo se mover arquivos
- **Auditoria** — `voice_calibrated: false` em draft é red flag antes de submeter

---

## 6. Workflow CODE adaptado

```
   Captura          Organiza            Destila          Expressa
   (Capture)        (Organize)          (Distill)        (Express)
      │                 │                   │                │
      ▼                 ▼                   ▼                ▼
  00_Inbox/   →   03_Resources/    →   permanent/   →   01_Projects/
                    (PARA)              (Zettel)         (drafts)
      │                 │                   │                │
   academic-      knowledge-          knowledge-        academic-
   researcher     architect           architect         writer
                                                            │
                                                            ▼
                                                       voice-humanizer
                                                            │
                                                            ▼
                                                       peer-reviewer
                                                            │
                                                            ▼
                                                       citation-manager
                                                            │
                                                            ▼
                                                       SUBMISSÃO
```

### Capture (diário)
- PDF de Scholar → `00_Inbox/`
- Insight em call → grava áudio → `00_Inbox/{data}-audio-insight.mp3`
- Snippet em livro físico → foto + Drive OCR → `00_Inbox/`

### Organize (semanal — domingo, 30 min)
- Esvaziar `00_Inbox/`
- Cada item vai para `03_Resources/Bibliografia/PDFs/{citekey}.pdf`
- Acionar `citation-manager` → atualiza `biblio.bib`

### Distill (sessão de leitura)
- Para cada PDF lido → `Fichamentos/{citekey}.md` (acionado por `knowledge-architect`)
- Cada ideia distinta no fichamento → nota atômica em `Notas-Atomicas/permanent/`
- Linkar bidirecionalmente

### Express (sprint de redação)
- Selecionar notas relevantes via `grep` por tag → outline
- `academic-writer` redige draft em `01_Projects/2026-Dissertacao/drafts/`
- `source-validator` audita
- `voice-humanizer` calibra
- `peer-reviewer` ataca
- `citation-manager` formata referências

---

## 7. Como cada agente atua no Google Drive

> Pré-requisito: **Drive for Desktop** instalado, sincronizando a pasta `Mestrado-{Tema}` localmente. Os agentes operam sobre os arquivos locais; mudanças sobem para nuvem automaticamente.

### 7.1 `methodology-advisor`
- **Lê**: `02_Areas/Orientacao/`, `01_Projects/{atual}/README.md`
- **Escreve**: `01_Projects/{atual}/metodologia.md`, `memory/project_methodology.md`
- **Drive**: usa Google Docs para metodologia se você quer comentários do orientador
- **Trigger**: chamar no início de cada projeto novo

### 7.2 `academic-researcher`
- **Lê**: `memory/project_thesis.md`, `memory/project_keywords.md`
- **Escreve**:
  - `03_Resources/Bibliografia/PDFs/` (download de PDFs com permissão)
  - `01_Projects/{atual}/research/{YYYY-MM-DD}-{slug}/sources.md`
- **Drive**: aproveita **Scholar → Save to Drive** (botão nativo). Pasta `Bibliografia/PDFs/` é destino fixo.
- **Integração**: quando encontra DOI, aciona `citation-manager` para criar entrada `.bib`

### 7.3 `source-validator`
- **Lê**: qualquer `.md` em `01_Projects/{atual}/drafts/` + `references/biblio.bib`
- **Escreve**: `01_Projects/{atual}/peer-review/{YYYY-MM-DD}-validacao-{slug}.md`
- **Drive**: outputs ficam no projeto auditado, não em recursos compartilhados

### 7.4 `knowledge-architect`
- **Lê**: PDFs, fichamentos, sua voz dictada
- **Escreve**:
  - `03_Resources/Bibliografia/Fichamentos/{citekey}.md`
  - `03_Resources/Notas-Atomicas/permanent/{timestamp}-{slug}.md`
  - `03_Resources/Notas-Atomicas/index/moc-{tema}.md`
- **Drive**: `Notas-Atomicas/` é o **núcleo do segundo cérebro** — backup adicional recomendado em git privado

### 7.5 `academic-writer`
- **Lê**: `Notas-Atomicas/permanent/`, `biblio.bib`, `memory/user_writing_voice.md`
- **Escreve**: `01_Projects/{atual}/drafts/`
- **Drive**: ao terminar capítulo, exporta `.md` → `.docx` (Pandoc) para enviar ao orientador via Google Docs

### 7.6 `citation-manager`
- **Lê / escreve**: `03_Resources/Bibliografia/biblio.bib`, `references/referencias-{norma}.md`
- **Drive**: `biblio.bib` é arquivo único compartilhado entre projetos — todos os capítulos referenciam o mesmo

### 7.7 `voice-humanizer` ⭐ (atualizado nesta versão)
- **Lê**:
  - `memory/user_writing_voice.md` (calibração persistente)
  - `memory/voice_questionnaire.md` (resultado do questionário)
  - drafts a humanizar
- **Escreve**:
  - `memory/user_writing_voice.md` (atualiza ao aprender)
  - drafts reescritos em colaboração com você
  - `memory/voice_calibration_log.md` — histórico de evolução da calibração
- **Workflow novo**: aplica questionário de calibração em primeira sessão (ver agente atualizado)

### 7.8 `peer-reviewer`
- **Lê**: drafts, metodologia, biblio.bib, MOCs do Zettelkasten
- **Escreve**: `01_Projects/{atual}/peer-review/{YYYY-MM-DD}-banca-{slug}.md`
- **Drive**: gera versão `.docx` para você imprimir e levar à reunião com orientador

---

## 8. Pesquisa rápida — como você acha qualquer coisa em 5 segundos

### 8.1 Busca no Google Drive (interface web)
- `type:pdf foucault` → todos os PDFs com "foucault"
- `before:2026-01-01 type:document` → docs antigos
- Drive faz OCR em PDFs e busca **dentro do conteúdo**

### 8.2 Busca por arquivo (Drive for Desktop, Windows Search)
- `Ctrl+F` no Explorer dentro de `Mestrado-*`
- Nome ISO ordenável já filtra por data

### 8.3 Busca semântica nas notas (com Claude Code)
```bash
# No terminal dentro da pasta sincronizada
grep -rli "modulacao\|controle continuo" 03_Resources/Notas-Atomicas/permanent/
```
Ou peça ao `knowledge-architect`:
> "Liste notas que conectam Foucault e Deleuze sobre vigilância."

### 8.4 Busca por tag (frontmatter YAML)
```bash
grep -lr "tags:.*foucault" 03_Resources/Notas-Atomicas/
```

### 8.5 Mapas de Conteúdo (MOCs)
Em `Notas-Atomicas/index/moc-{tema}.md` você tem **portões de entrada** curados manualmente para cada grande tema. Comece sempre pelo MOC.

---

## 9. Cadências de manutenção

| Frequência | Ritual | Duração | Quem |
|---|---|---|---|
| **Diária** | Capturar em `00_Inbox/` ao longo do dia | 0 min ativo | você |
| **Semanal (domingo)** | Esvaziar `Inbox`, atualizar `biblio.bib` | 30 min | você + `citation-manager` |
| **Quinzenal** | Revisar status das notas (raw → refined → connected) | 45 min | `knowledge-architect` |
| **Mensal** | Revisar MOCs, identificar lacunas | 1h | `knowledge-architect` + `peer-reviewer` |
| **Por capítulo concluído** | Auditoria completa (validate + humanize + peer) | 2h | squad completo |
| **Trimestral** | Atualizar `memory/user_writing_voice.md` com novos exemplos | 30 min | `voice-humanizer` |

---

## 10. Métricas de saúde do sistema

Acompanhe mensalmente (peça ao `knowledge-architect` para gerar):

| Métrica | Saudável | Alerta |
|---|---|---|
| Notas em `permanent/` | crescendo 10+/mês | estagnado |
| % notas `connected` | > 60% | < 40% (notas órfãs demais) |
| Tamanho de `Inbox` | < 10 itens | > 30 (não está processando) |
| Citações em drafts com `[CITAR]` | < 5 por capítulo | muitas — buscar fontes |
| Fontes em `biblio.bib` validadas | 100% | qualquer alucinação não detectada |
| MOCs criados | 1 por linha de pesquisa | nenhum (faltando síntese) |

---

## 11. Backup e segurança

- **Drive já é backup**, mas adicione redundância:
  - **Repositório git privado** (GitHub/GitLab) com `Notas-Atomicas/` + `drafts/` (texto puro versionado é ouro)
  - **Backup local periódico** com `robocopy` (Windows) ou `rsync` (Mac/Linux)
- **Permissões**: `01_Projects/{atual}/drafts/` somente você — orientador acessa via Google Docs específicos compartilhados
- **PDFs com copyright**: `03_Resources/Bibliografia/PDFs/` deve ser **privado** — nunca compartilhar pasta inteira

---

## 12. Cronograma de adoção (4 semanas)

### Semana 1 — Estrutura
- [ ] Criar pasta `Mestrado-{Tema}` no Drive
- [ ] Replicar árvore PARA + Zettelkasten
- [ ] Instalar Drive for Desktop, sincronizar localmente
- [ ] Mover material disperso atual para `00_Inbox/` (não tente organizar tudo agora)

### Semana 2 — Calibração
- [ ] Preencher `memory/project_thesis.md`
- [ ] Preencher `memory/citation_style.md`
- [ ] Aplicar **questionário de calibração** do `voice-humanizer` (novo)
- [ ] Submeter 3 textos seus antigos → `voice-humanizer` extrai padrões para `user_writing_voice.md`

### Semana 3 — Primeiro fluxo CODE
- [ ] Capturar 5 fontes novas via `academic-researcher`
- [ ] Validar com `source-validator`
- [ ] Fichar com `knowledge-architect` → 5 notas atômicas
- [ ] Linkar bidirecionalmente

### Semana 4 — Primeiro Express
- [ ] Selecionar 8–12 notas atômicas conectadas
- [ ] `academic-writer` produz mini-seção (1.500 palavras)
- [ ] Ciclo: validate → humanize → peer-review
- [ ] Avaliar: o sistema funcionou? Ajustar.

---

## 13. Anexos

### A. Template de README de projeto
`01_Projects/{ano-slug}/README.md`:

```markdown
---
project: 2026-Dissertacao
status: ativo
deadline: 2027-03-15
---

# Dissertação — {Título Provisório}

## Pergunta de pesquisa
{...}

## Objetivos
- Geral: {...}
- Específicos:
  - {...}
  - {...}

## Cronograma
- Qualificação: 2026-12-01
- Defesa: 2027-03-15

## Status atual
- [x] Cap. 1 — Introdução (rascunho v2)
- [ ] Cap. 2 — Referencial (em redação)
- [ ] Cap. 3 — Metodologia
- [ ] Cap. 4 — Análise
- [ ] Cap. 5 — Considerações finais

## Decisões importantes
- 2026-04-15: optei por estudo de caso múltiplo (ver `metodologia.md`)
- 2026-05-02: substituí abordagem etnográfica por análise documental (motivo: acesso a campo)

## Próxima ação
{...}
```

### B. Template de fichamento
`03_Resources/Bibliografia/Fichamentos/{citekey}.md`:

```markdown
---
type: lit
citekey: foucault1975
status: refined
read_date: 2026-04-20
---

# {Título} — {Autor}

## Tese central (1 frase)
{...}

## Argumentos principais
1. {...}
2. {...}

## Citações-chave (com página)
> "{...}" (p. XX)

## Conceitos novos para você
- **conceito**: definição

## Como dialoga com sua pesquisa
{...}

## Notas atômicas geradas
- [[202604201430-{slug}]]
- [[...]]

## Status do PDF
- [x] Lido integralmente
- [ ] Lido em diagonal
- [ ] Apenas resumo
```

---

**Documento gerado em**: 2026-05-07
**Versão**: 1.0
**Próxima revisão recomendada**: após Sprint 1 (semana 4)
