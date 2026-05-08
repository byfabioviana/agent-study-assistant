# Squad de Agentes Acadêmicos — Mestrado

Conjunto de **9 agentes** Claude Code especializados em apoiar uma jornada de mestrado: pesquisa, validação, organização do conhecimento, redação, formatação, auditoria de padrões de IA, autenticidade autoral e revisão crítica.

> **Posicionamento ético**: estes agentes apoiam a pesquisa do aluno como ferramenta. A autoria é sempre do aluno. O `voice-humanizer` **não** é um serviço de evasão de detectores de IA — é um editor de voz autoral. Se sua instituição exige declaração de uso de IA, declare.

---

## Agentes incluídos

| Agente | Modelo | Quando usar |
|---|---|---|
| `methodology-advisor` | opus | Início do projeto, qualificação, escolha de método |
| `academic-researcher` | sonnet | Revisão de literatura, busca em bases científicas |
| `source-validator` | sonnet | Após qualquer output de IA, antes de submissão |
| `knowledge-architect` | sonnet | Continuamente, após cada leitura/insight |
| `academic-writer` | opus | Redação de capítulos, seções, artigos |
| `citation-manager` | haiku | Adição de fonte, conversão de norma, finalização |
| **`ai-pattern-auditor`** ⭐ | opus | **Antes do voice-humanizer** — diagnostica trechos com marca de IA, gera mapa de calor parágrafo-a-parágrafo |
| `voice-humanizer` | opus | Última passada antes de submissão. Aplica questionário de calibração de tom de voz na primeira sessão. |
| `peer-reviewer` | opus | Antes de qualificação, defesa ou submissão a revista |

---

## Instalação

> **Recomendado**: use os instaladores `install.ps1` (Windows) ou
> `install.sh` (Mac/Linux) na raiz do repositório — eles tratam escopo,
> sobrescrita e marker file automaticamente. As opções abaixo são
> manuais, para casos de customização.

### Opção A — Instalação manual a nível de usuário (todos os projetos)

A partir da raiz do clone (`agent-study-assistant/`), copie os `.md`
para `~/.claude/agents/`:

**Windows (PowerShell)**:
```powershell
Copy-Item .\agents\*.md "$env:USERPROFILE\.claude\agents\" -Exclude "README.md"
```

**Mac/Linux**:
```bash
mkdir -p ~/.claude/agents
find ./agents -maxdepth 1 -name "*.md" ! -name "README.md" -exec cp {} ~/.claude/agents/ \;
```

### Opção B — Instalação manual a nível de projeto

A partir da raiz do clone, copie para `.claude/agents/` do projeto-alvo:

```bash
mkdir -p /caminho/do/projeto/.claude/agents
cp ./agents/*.md /caminho/do/projeto/.claude/agents/
rm /caminho/do/projeto/.claude/agents/README.md
```

### Verificação

Abra o Claude Code no projeto e digite:

```
/agents
```

Os 8 agentes devem aparecer na lista.

---

## Estrutura de pastas recomendada para o projeto de pesquisa

```
seu-projeto-mestrado/
├── agents/                    # (se instalação por projeto)
├── memory/                    # memória persistente entre sessões
│   ├── project_thesis.md      # tema, pergunta, objetivos
│   ├── project_methodology.md # desenho metodológico escolhido
│   ├── citation_style.md      # ABNT / APA / Vancouver
│   ├── user_writing_voice.md  # exemplos da sua voz autoral (calibração)
│   └── feedback_*.md          # correções persistentes
├── notes/                     # Zettelkasten
│   ├── inbox/                 # notas brutas a processar
│   ├── literature/            # fichamentos de fontes
│   ├── permanent/             # notas atômicas refinadas
│   └── index/                 # MOCs (Maps of Content)
├── references/
│   ├── biblio.bib             # banco BibTeX
│   ├── pdfs/                  # artigos baixados
│   └── referencias-{norma}.md # lista formatada
├── research/                  # outputs de busca
│   └── {YYYY-MM-DD}-{slug}/
│       ├── sources.md
│       └── search_log.md
├── drafts/                    # capítulos em redação
│   ├── 01-introducao.md
│   ├── 02-referencial.md
│   ├── 03-metodologia.md
│   ├── 04-resultados.md
│   └── 05-conclusoes.md
└── README.md
```

---

## Fluxo recomendado

### Fase 1 — Fundação (semana 1)
1. `methodology-advisor` ajuda a desenhar o projeto
2. Preenche `memory/project_thesis.md` e `memory/project_methodology.md`
3. Coleta 3–5 parágrafos seus em `memory/user_writing_voice.md` para calibração

### Fase 2 — Coleta (semanas 2–4)
1. `academic-researcher` faz revisão de literatura
2. `source-validator` audita resultados
3. `knowledge-architect` converte em notas atômicas
4. `citation-manager` mantém `biblio.bib` consistente

### Fase 3 — Redação (semanas 5–10)
1. `academic-writer` redige capítulos a partir das notas
2. `source-validator` audita cada citação
3. `ai-pattern-auditor` gera mapa de calor parágrafo-a-parágrafo com score de marcas de IA
4. `voice-humanizer` reescreve focado nos trechos 🔴/🟠 apontados pelo auditor
5. `citation-manager` formata referências finais

### Fase 4 — Defesa (semanas 11–12)
1. `peer-reviewer` simula banca
2. Itera correções
3. Repete `voice-humanizer` + `peer-reviewer` até convergir

---

## Skills nativas mobilizadas

Os agentes assumem que estas skills do Claude Code estão disponíveis:

### Pesquisa
- `tech-search` — pipeline de pesquisa profunda
- `mcp__plugin_everything-claude-code_exa__web_search_exa`
- `mcp__plugin_everything-claude-code_exa__web_fetch_exa`
- `WebSearch`, `WebFetch` (nativas)
- `mcp__plugin_everything-claude-code_context7__query-docs`

### Análise
- `sci-statistical-analysis`
- `sci-statsmodels`
- `sci-pymc`
- `sci-fred-economic-data` (se tema for econômico)
- `sci-geopandas` (se tema for espacial)
- `data-scientist` (agente)

### Apresentação
- `frontend-slides` — slides HTML para qualificação/defesa
- `sci-market-research-reports` — templates LaTeX longos

### Conhecimento persistente
- `mcp__plugin_everything-claude-code_memory__*` — grafo de conhecimento
- `/save-session` + `/resume-session`

---

## Comandos slash sugeridos

Crie em `.claude/commands/` para acelerar:

### `/fichar`
```markdown
Acione o agente `knowledge-architect` para fichar o conteúdo a seguir e gerar notas atômicas.
```

### `/citar`
```markdown
Acione o agente `citation-manager` para adicionar a referência a seguir ao biblio.bib e formatar conforme memory/citation_style.md.
```

### `/revisar-banca`
```markdown
Acione o agente `peer-reviewer` para fazer revisão crítica simulando banca do arquivo passado como argumento.
```

### `/auditar-ia`
```markdown
Acione o agente `ai-pattern-auditor` para gerar mapa de calor parágrafo-a-parágrafo com score de marcas de IA, marcadores específicos e plano priorizado de humanização.
```

### `/humanizar`
```markdown
Acione o agente `voice-humanizer` para reescrever o texto na voz do aluno. Se ainda não houver perfil calibrado, aplica primeiro o questionário de 21 perguntas. Use APÓS `ai-pattern-auditor`.
```

### `/validar-fontes`
```markdown
Acione o agente `source-validator` para auditar todas as citações do arquivo passado.
```

---

## Memória entre sessões

Os agentes consomem e atualizam arquivos em `memory/` que **persistem entre sessões do Claude Code**. Ao iniciar nova sessão:

1. Os agentes leem `memory/project_thesis.md` para retomar contexto
2. `voice-humanizer` lê `memory/user_writing_voice.md` para manter consistência
3. `methodology-advisor` lê `memory/project_methodology.md` para não retroceder

**Recomendação**: revise os arquivos em `memory/` mensalmente. Se algo mudou (mudou de orientador, de pergunta, de norma), atualize.

---

## Troubleshooting

### "O agente não aparece em /agents"
- Verifique se está em `~/.claude/agents/` (user-level) ou `.claude/agents/` (project-level)
- Reinicie o Claude Code
- Confirme que o frontmatter YAML está válido (sem typo em `name`, `description`, `tools`, `model`)

### "O agente está alucinando referências"
- Acione **sempre** `source-validator` após `academic-researcher`
- Não confie em primeira passada; toda referência precisa de DOI ou URL real

### "O texto continua sendo flagado como IA"
- O `voice-humanizer` por design exige sua intervenção. Texto sem seu input intelectual continuará flagado.
- Faça as gravações de 60s sugeridas pelo agente.
- Insira casos do seu campo empírico, suas leituras específicas, suas divergências.

### "Estou perdido em qual agente acionar"
Use este atalho mental:
- **Não sei como pesquisar** → `methodology-advisor` (desenho) ou `academic-researcher` (busca)
- **Tenho fontes mas não sei se são reais** → `source-validator`
- **Tenho leituras mas estão dispersas** → `knowledge-architect`
- **Preciso escrever** → `academic-writer`
- **Texto pronto, mas quero saber onde está com cara de IA** → `ai-pattern-auditor` (mapa de calor)
- **Quero reescrever na minha voz** → `voice-humanizer` (após o auditor)
- **Vou submeter** → `peer-reviewer` + `citation-manager`

---

## Roadmap de evolução

Após estabilizar os 8 agentes, considere adicionar:

- **`study-coach`** — planejamento de sessões com spaced repetition
- **`abstract-generator`** — gera resumo/abstract a partir do trabalho completo
- **`apresentacao-architect`** — desenha slides de qualificação/defesa
- **`orientador-prep`** — prepara você para reuniões com orientador (perguntas, status)
- **`grant-writer`** — para bolsas e editais

Cada um seguindo o mesmo padrão: frontmatter YAML + prompt focado + integração com memória persistente.

---

## Licença

Uso pessoal e acadêmico. Adapte livremente aos seus projetos.

---

**Última atualização**: 2026-05-07
