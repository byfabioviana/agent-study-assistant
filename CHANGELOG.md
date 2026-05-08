# Changelog

Todas as mudanças notáveis deste projeto serão documentadas aqui.

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/)
e este projeto adere a [Semantic Versioning](https://semver.org/lang/pt-BR/).

## [Unreleased]

### Adicionado
- **`docs/manual-uso-agentes.pptx`** — apresentação de 18 slides com
  manual de uso operacional dos agentes para o mestrando que já
  instalou o squad. Apresenta o **framework "5 FASES da Jornada"**
  (Input → Desenho → Digestão → Produção → Polimento), com:
  - Anatomia de uma chamada de agente (3 formas de acionar + estrutura
    ideal de prompt)
  - Slide dedicado por fase com agentes envolvidos, quando acionar,
    prompt template copiável, saída esperada, próximo passo e
    anti-padrão a evitar
  - Quatro ritmos de uso documentados: diário (30 min), semanal
    (1 h aos domingos), sprint de capítulo (1-2 semanas), pré-submissão
    (checklist de 10 itens)
  - Decision tree "qual agente usar quando" com 9 perguntas-chave
  - Cheat sheet imprimível com todos os agentes em uma página
- `scripts/generate_pptx_manual_uso.py` — script que gera o manual,
  reutilizando a paleta Oxford Heritage v2.0 e tipografia (Plus Jakarta
  Sans + Lora + IBM Plex Mono) já estabelecidas
- Link destacado para o manual no `README.md`
- **`INSTALL-FACIL.md`** — guia de instalação para usuários leigos
  tecnicamente, com 3 prompts prontos (Padrão, Mínimo, Detalhado) que
  podem ser copiados e colados diretamente no Claude Code. Inclui
  prompts adicionais para atualização e tratamento de erros, além
  de FAQ amigável
- Link destacado para `INSTALL-FACIL.md` no topo da seção de instalação
  do `README.md`
- **Slash command `/study-setup`** — instalador interativo via Claude Code
  que faz tudo em um único comando: clone do repo, instalação dos 9
  agentes, criação da árvore PARA + Zettelkasten, inicialização de
  `memory/` pré-preenchido e tour conversacional pelos agentes
- `commands/study-setup.md` com 9 etapas guiadas (apresentação, detecção
  de SO, coleta de inputs, clone/update do repo, instalação,
  estrutura de pastas, memory, validação, tour, resumo final)
- `commands/README.md` documentando como instalar o comando isoladamente
  via `curl` ou `Invoke-WebRequest` (sem precisar clonar o repo)
- Argumentos suportados pelo `/study-setup`: `--update`, `--uninstall`,
  `--check` ou caminho de pasta como argumento posicional
- `install.ps1` e `install.sh` agora também copiam `commands/*.md`
  para `~/.claude/commands/` (mesmo escopo dos agentes)
- `uninstall.ps1` e `uninstall.sh` removem comandos junto com agentes
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
