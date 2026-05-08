# Changelog

Todas as mudanças notáveis deste projeto serão documentadas aqui.

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/)
e este projeto adere a [Semantic Versioning](https://semver.org/lang/pt-BR/).

## [Unreleased]

### Adicionado
- Guia completo de setup do Obsidian como interface unificada do squad
  (`docs/obsidian-setup-guide.md`) — Tier 1 da estratégia de UI
- Coleção de **queries Dataview** prontas para uso
  (`docs/obsidian-queries-dataview.md`)
- Slide novo no PPTX (capítulo 10) explicando o fluxo Obsidian e os
  4 superpoderes (grafo, Dataview, Smart Connections, Templater)
- Tema CSS Oxford Heritage para Obsidian (snippet incluído no guia)

## [1.0.0] — 2026-05-08

### Adicionado
- Squad de **9 agentes** especializados em jornada de mestrado:
  - `methodology-advisor` — desenho metodológico
  - `academic-researcher` — busca em bases acadêmicas
  - `source-validator` — auditoria anti-alucinação
  - `knowledge-architect` — Zettelkasten / segundo cérebro
  - `academic-writer` — redação ABNT/APA
  - `citation-manager` — gestão de bibliografia
  - `voice-humanizer` — voz autoral com questionário de calibração
  - `peer-reviewer` — banca simulada
  - `ai-pattern-auditor` — mapa de calor de marcas de IA
- Plano organizacional completo (`docs/curadoria-conteudo-plano.md`)
  com framework PARA + Zettelkasten + CODE
- Apresentação institucional `docs/curadoria-verticalis-deck.pptx`
  (21 slides, branding Oxford Heritage v2.0 sem logomarcas)
- Plano de implementação em `.claude/plan/agentes-mestrado-plano.md`
- Scripts geradores de apresentação (`scripts/generate_pptx*.py`)
- Templates de memória inicial em `memory-templates/`
- Instaladores multiplataforma: `install.ps1`, `install.sh`
- Pipeline CI no GitHub Actions validando estrutura dos agentes

### Decisões arquiteturais
- Português Brasil como idioma operacional dos prompts dos agentes
- Frontmatter YAML como contrato entre agentes
- Memory por usuário fica em `memory/` (gitignored) — versionamos apenas
  templates em `memory-templates/`
- Posicionamento ético explícito do `voice-humanizer`: autenticidade
  autoral, **não** evasão de detector
