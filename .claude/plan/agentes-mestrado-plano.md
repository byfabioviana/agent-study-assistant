# Plano de Implementação — Squad de Agentes para Pesquisa Acadêmica (Mestrado)

> Documento gerado por `/multi-plan` em modo **Claude-only** (wrappers Codex/Gemini não disponíveis neste ambiente). Estrutura, papéis e prompts foram desenhados a partir do inventário de agentes/skills existentes em `~/.claude/`.

---

## 1. Diagnóstico do problema

Você é mestrando, usa IAs como ferramenta de pesquisa, mas hoje enfrenta três fricções principais:

| Fricção | Sintoma | Causa raiz |
|---|---|---|
| **Curadoria pulverizada** | Resultados de IA misturam fontes confiáveis, blogs e alucinações | Falta de um agente *gatekeeper* que valide cada afirmação contra a fonte primária |
| **Conhecimento se perde** | Insights ficam em conversas dispersas, sem estrutura cumulativa | Falta de uma camada Zettelkasten/segundo cérebro persistente |
| **Texto soa "de IA"** | Detectores acusam padrão estatístico (baixa burstiness, vocabulário previsível) | Texto gerado em uma única passada sem reescrita autoral |

**Princípio ético adotado**: o agente "humanizador" não foi desenhado para *enganar* detectores, mas para garantir que o produto final reflita seu raciocínio, sua leitura e sua voz. IA é ferramenta; autoria é sua. Se sua instituição exige declaração de uso de IA, declare — o objetivo aqui é qualidade autoral, não evasão.

---

## 2. Squad proposto — 8 agentes especializados

A arquitetura segue o modelo de **separação de responsabilidades** dos agentes existentes (`architect`, `code-reviewer`, `tdd-guide`...) aplicada ao domínio acadêmico.

### Mapa de fluxo (do tema à dissertação)

```
                    ┌─────────────────────┐
                    │   VOCÊ (mestrando)  │
                    └──────────┬──────────┘
                               │ tema / pergunta
        ┌──────────────────────┼──────────────────────┐
        ▼                      ▼                      ▼
┌───────────────┐    ┌──────────────────┐    ┌──────────────────┐
│ methodology-  │    │ academic-        │    │ knowledge-       │
│ advisor       │───▶│ researcher       │───▶│ architect        │
│ (desenho)     │    │ (curadoria)      │    │ (Zettelkasten)   │
└───────────────┘    └────────┬─────────┘    └────────┬─────────┘
                              ▼                       ▼
                     ┌──────────────────┐    ┌──────────────────┐
                     │ source-validator │    │ academic-writer  │
                     │ (anti-alucinação)│    │ (estrutura)      │
                     └──────────────────┘    └────────┬─────────┘
                                                      ▼
                              ┌──────────────────┬──────────────────┐
                              ▼                  ▼                  ▼
                    ┌──────────────────┐ ┌──────────────┐ ┌──────────────────┐
                    │ citation-manager │ │ voice-       │ │ peer-reviewer    │
                    │ (ABNT/APA)       │ │ humanizer    │ │ (banca simulada) │
                    └──────────────────┘ └──────────────┘ └──────────────────┘
```

### 2.1 Tabela-resumo

| # | Agente | Responsabilidade | Quando acionar | Modelo sugerido |
|---|---|---|---|---|
| 1 | `methodology-advisor` | Desenho metodológico, epistemologia, escolha qual/quant/misto | Início do projeto, qualificação | opus |
| 2 | `academic-researcher` | Busca em Scholar, arXiv, SSRN, SciELO, CAPES; síntese de literatura | Revisão bibliográfica | sonnet |
| 3 | `source-validator` | Verifica se citações existem, detecta alucinações de IA prévia | Após cada output de IA | sonnet |
| 4 | `knowledge-architect` | Organiza notas atômicas (Zettelkasten), liga conceitos | Continuamente | sonnet |
| 5 | `academic-writer` | Estrutura capítulos, argumentação, ABNT NBR 14724 | Redação de seções | opus |
| 6 | `citation-manager` | Formata referências ABNT/APA/Vancouver, mantém .bib | Antes de entregar texto | haiku |
| 7 | `voice-humanizer` | Reescrita autoral, varia burstiness/perplexity, integra sua voz | Última passada antes de submeter | opus |
| 8 | `peer-reviewer` | Simula banca: aponta lacunas, falácias, fragilidade metodológica | Antes da qualificação/defesa | opus |

---

## 3. Skills do Claude Code mobilizadas

Inventário de skills nativas e plugins que cada agente utiliza:

### 3.1 Pesquisa & validação
- **`tech-search`** — pipeline auto-contido (WebSearch + WebFetch + Haiku workers) salvando em `docs/research/{data}-{slug}/`
- **`mcp__plugin_everything-claude-code_exa__web_search_exa`** — busca semântica profunda
- **`mcp__plugin_everything-claude-code_exa__web_fetch_exa`** — extração de conteúdo de URLs
- **`WebSearch` / `WebFetch`** — fallback nativo
- **`mcp__plugin_everything-claude-code_context7__query-docs`** — docs técnicas atualizadas (útil se o tema envolver libs/frameworks)
- **`sci-fred-economic-data`** — séries econômicas FRED (relevante se o mestrado for em economia, finanças ou áreas correlatas)

### 3.2 Análise & síntese
- **`sci-statistical-analysis`** — seleção de testes estatísticos com saída em formato APA
- **`sci-statsmodels`** — modelos econométricos rigorosos
- **`sci-pymc`** — modelagem bayesiana
- **`sci-geopandas`** — análise espacial (caso aplicável)
- **`data-scientist`** (agente) — análises exploratórias e modelos preditivos
- **`mcp__plugin_everything-claude-code_sequential-thinking__sequentialthinking`** — raciocínio em cadeia para argumentos complexos

### 3.3 Escrita & estrutura
- **`sci-market-research-reports`** — templates de relatórios longos (50+ páginas) em LaTeX
- **`frontend-slides`** — apresentações HTML para qualificação/defesa
- **`tm-skill-designer`** — meta-skill para criar novas skills sob demanda

### 3.4 Conhecimento persistente
- **`mcp__plugin_everything-claude-code_memory__*`** — grafo de conhecimento (entidades, relações, observações)
- **Sistema de memória nativo** (`memory/*.md`) — fatos persistentes entre sessões
- **`mcp__claude_ai_Google_Drive__*`** — integração com Drive para artigos/PDFs
- **`mcp__claude_ai_Gmail__*`** — alertas de Scholar, comunicação com orientador

### 3.5 Comandos úteis
- **`/save-session`** + **`/resume-session`** — continuidade entre sessões de estudo
- **`/skill-create`** — gera skills customizadas (ex.: template-da-sua-instituição)
- **`/loop`** — execuções recorrentes (ex.: alerta semanal de novos papers no tema)
- **`/schedule`** — agentes remotos cron (ex.: digest semanal)

---

## 4. Plano de **contratação e refinamento** dos agentes

Inspirado em ciclos de hiring + onboarding em squads de engenharia. Total: **5 sprints de ~3 dias cada** = ~2 semanas.

### Sprint 0 — Fundação (Dia 0–1)
- [ ] Criar a pasta de trabalho do seu mestrado (ex: `~/Google Drive/Mestrado-{Tema}/`)
- [ ] Estrutura de pastas:
  ```
  Mestrado-{Tema}/
  ├── agents/             # definições .md dos agentes (cópia do repo)
  ├── prompts/            # prompts reutilizáveis
  ├── memory/             # memória persistente do projeto
  ├── notes/              # Zettelkasten (notas atômicas)
  │   ├── inbox/          # notas brutas
  │   ├── permanent/      # notas refinadas
  │   └── literature/     # fichamentos de fontes
  ├── references/         # .bib, PDFs de artigos
  ├── drafts/             # capítulos em redação
  ├── research/           # outputs de tech-search
  └── README.md
  ```
- [ ] Definir tema/pergunta de pesquisa em `memory/project_thesis.md`
- [ ] Definir norma (ABNT/APA/Vancouver) em `memory/citation_style.md`

### Sprint 1 — Contratação dos "fundadores" (Dia 1–4)
**Objetivo**: agentes que viabilizam coleta + validação.
- [ ] `academic-researcher` — testar com 3 buscas reais do seu tema
- [ ] `source-validator` — alimentar com 1 texto gerado por IA, validar cada citação
- [ ] `knowledge-architect` — criar 5 notas atômicas iniciais

**Critério de aprovação (definição de pronto)**:
- Researcher retorna 5+ fontes com DOI/URL verificáveis
- Validator detecta corretamente uma citação fabricada (teste plantado)
- Architect produz notas seguindo princípio Luhmann (uma ideia por nota, links explícitos)

### Sprint 2 — Contratação dos "metodólogos" (Dia 4–7)
- [ ] `methodology-advisor` — submeter sua pergunta de pesquisa, receber 3 desenhos alternativos
- [ ] `peer-reviewer` — testar com um texto seu existente, avaliar qualidade da crítica

**Critério**: Advisor identifica trade-offs (validade interna × generalização) com referência a autores canônicos da área. Reviewer aponta no mínimo 3 fragilidades concretas (não genéricas).

### Sprint 3 — Contratação dos "redatores" (Dia 7–10)
- [ ] `academic-writer` — gerar esqueleto de 1 capítulo
- [ ] `citation-manager` — converter 10 referências entre formatos
- [ ] `voice-humanizer` — reescrever 500 palavras de output de IA na sua voz

**Critério**: Writer respeita estrutura IMRAD ou ABNT NBR 14724. Manager produz `.bib` válido. Humanizer aumenta variância de comprimento de sentença em ≥30% e mantém densidade conceitual.

### Sprint 4 — Refinamento e calibração (Dia 10–14)
- [ ] Rodar fluxo completo end-to-end com um mini-artigo (1.500 palavras)
- [ ] Ajustar prompts dos agentes que falharem
- [ ] Documentar padrões em `memory/feedback_*.md` (segundo o sistema de memória do Claude Code)
- [ ] Criar comandos slash personalizados em `.claude/commands/` (ex.: `/fichar`, `/citar`, `/revisar-banca`)

### Sprint 5 — Continuidade
- [ ] Configurar `/loop` semanal: alerta de novos papers no tema
- [ ] Configurar hooks `PostToolUse` para auto-formatar referências ao salvar `.md`
- [ ] Backup do `agents/` em repositório git privado

---

## 5. Descrição detalhada de cada agente

### 5.1 `methodology-advisor`
- **Persona**: pesquisador sênior, leitor de Creswell, Bardin, Yin, Bauer & Gaskell
- **Entradas**: pergunta de pesquisa, contexto do problema, restrições (tempo, acesso a campo)
- **Saídas**: 3 desenhos metodológicos alternativos com prós/contras, autores de referência, instrumentos
- **Princípio**: nunca recomenda método sem justificar epistemologicamente

### 5.2 `academic-researcher`
- **Persona**: bibliotecário-pesquisador
- **Entradas**: tema, palavras-chave, recorte temporal, idiomas
- **Saídas**: lista priorizada de fontes (Scholar, SciELO, CAPES, arXiv, SSRN, ResearchGate) com:
  - DOI/URL verificável
  - Fator de impacto / Qualis quando disponível
  - Resumo de 3 linhas
  - Relevância para sua pergunta (1–5)
- **Skills mobilizadas**: `tech-search`, `exa`, `WebSearch`
- **Saída em**: `research/{data}-{slug}/sources.md`

### 5.3 `source-validator`
- **Persona**: revisor cético — assume que toda IA pode alucinar
- **Entradas**: texto com citações
- **Saídas**: relatório por afirmação:
  - ✅ Verificada (cita-se a fonte real)
  - ⚠️ Parcial (fonte existe, afirmação é interpretação)
  - ❌ Alucinação (fonte não encontrada ou não suporta a afirmação)
- **Comportamento crítico**: nunca aprova sem checar a fonte primária

### 5.4 `knowledge-architect`
- **Persona**: praticante do método Zettelkasten (Luhmann) e Building a Second Brain (Forte)
- **Entradas**: trecho de leitura, insight, fichamento bruto
- **Saídas**: nota atômica em `notes/permanent/{id}-{slug}.md` com:
  - Uma ideia única
  - Links `[[wikilink]]` para notas relacionadas
  - Tag `#status/raw|refined|connected`
  - Frontmatter YAML com data, fonte, tipo
- **Princípio**: prefere muitas notas pequenas a poucas notas grandes (alta coesão, baixo acoplamento — análogo ao princípio de arquivos do `coding-style.md`)

### 5.5 `academic-writer`
- **Persona**: orientador-editor que escreve em ABNT NBR 14724 / APA 7th
- **Entradas**: notas do `knowledge-architect`, esqueleto do capítulo
- **Saídas**: rascunho com estrutura argumentativa explícita (tese → argumento → evidência → contra-argumento → síntese)
- **Restrição**: nunca inventa citação — se faltar fonte, marca `[CITAR: ...]` para o `academic-researcher` resolver

### 5.6 `citation-manager`
- **Persona**: Mendeley/Zotero personificado
- **Entradas**: lista de referências em qualquer formato
- **Saídas**:
  - `references/biblio.bib` (BibTeX)
  - Lista formatada conforme `memory/citation_style.md`
- **Skills**: `WebFetch` para buscar metadados via DOI/CrossRef

### 5.7 `voice-humanizer` (núcleo ético)
- **Persona**: editor de texto autoral — não detector-evasion service
- **Posicionamento ético explícito**:
  > "Meu trabalho não é enganar detectores. É garantir que o texto reflita seu raciocínio. Se você não consegue defender um parágrafo oralmente em 30 segundos, ele precisa ser reescrito por você — não maquiado por mim."
- **Técnicas legítimas**:
  1. **Variação de burstiness**: alternância proposital entre sentenças curtas e longas
  2. **Perplexity natural**: vocabulário menos previsível, evitando frases-clichê de IA ("é importante notar que", "em conclusão", "moreover")
  3. **Integração de voz**: insere onde você concorda/discorda, sua experiência, sua leitura própria
  4. **Anti-padrões**: remove paralelismos excessivos, listas tripartites automáticas, transições mecânicas
- **Workflow**: pede que você grave 60 segundos de áudio explicando o parágrafo, depois reescreve ancorado no que VOCÊ disse
- **Não faz**: trocar palavras por sinônimos para "passar" em detector. Isso é trapaça e detectores modernos pegam mesmo assim.

### 5.8 `peer-reviewer`
- **Persona**: membro de banca implacável — Karl Popper + revisor 2 do Nature
- **Entradas**: texto, capítulo ou projeto
- **Saídas**: relatório estruturado:
  - Lacunas teóricas (quais autores faltam?)
  - Falácias lógicas (não-sequiturs, falsa causalidade)
  - Fragilidades metodológicas (amostra, instrumentos, viés)
  - Perguntas que a banca **vai** fazer
- **Comportamento**: nunca é gentil por gentileza. Cita autores específicos na crítica.

---

## 6. Boas práticas operacionais

### 6.1 Memória persistente
Cada agente lê/escreve em `memory/` seguindo o sistema nativo do Claude Code:
- `user_thesis_topic.md` — tema atual
- `user_writing_voice.md` — exemplos da sua voz autoral (calibração para `voice-humanizer`)
- `feedback_*.md` — correções que você deu (ex.: "nunca use 'em suma'")
- `project_*.md` — contexto do projeto (orientador, prazo, instituição)

### 6.2 Continuidade
- `/save-session` ao final de cada sessão de estudo
- `/resume-session` ao retomar
- Arquivos em `notes/permanent/` são fonte de verdade entre sessões

### 6.3 Auditoria de IA
Antes de submeter qualquer texto:
1. `source-validator` — toda citação verificada?
2. `peer-reviewer` — sobrevive à crítica?
3. `voice-humanizer` — soa como você?
4. Leitura humana final — você defende cada parágrafo?

---

## 7. Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Dependência de IA reduzir aprendizado | `peer-reviewer` força você a defender o texto; nunca aceite sem entender |
| Alucinação passar despercebida | Workflow obriga `source-validator` antes de qualquer submissão |
| Texto soar uniforme entre capítulos | `voice-humanizer` calibrado a partir de exemplos seus em `memory/user_writing_voice.md` |
| Norma ABNT mudar | `citation-manager` lê `memory/citation_style.md` toda execução |
| Violação de integridade acadêmica | Posicionamento ético explícito do `voice-humanizer`; sempre declarar uso de IA quando exigido |

---

## 8. Arquivos a serem criados (deliverable)

| Arquivo | Função |
|---|---|
| `agents/methodology-advisor.md` | Definição do agente |
| `agents/academic-researcher.md` | Definição do agente |
| `agents/source-validator.md` | Definição do agente |
| `agents/knowledge-architect.md` | Definição do agente |
| `agents/academic-writer.md` | Definição do agente |
| `agents/citation-manager.md` | Definição do agente |
| `agents/voice-humanizer.md` | Definição do agente |
| `agents/peer-reviewer.md` | Definição do agente |
| `agents/README.md` | Como instalar e usar |

Cada arquivo segue o frontmatter padrão (`name`, `description`, `tools`, `model`) compatível com `~/.claude/agents/`.

---

## 9. Próximos passos

1. **Revisar este plano** — alguma área está faltando? Algum agente sobrando para o seu caso?
2. **Aprovar criação** — gero todos os 9 arquivos `.md` em sequência
3. **Sprint 0** — você cria a estrutura de pastas (ou peço para eu criar)
4. **Calibração** — alimentar `memory/user_writing_voice.md` com 3–5 parágrafos seus já escritos

---

**Status**: Plano salvo em `.claude/plan/agentes-mestrado-plano.md`. Aguardando sua revisão antes de gerar os arquivos dos agentes.
