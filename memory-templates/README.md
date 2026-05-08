# Memory Templates

Templates iniciais para o `memory/` do seu projeto de pesquisa.

`memory/` contém **dados pessoais** (perfil de voz, tema da tese,
correções de estilo) e **NÃO** é versionado no repositório — está no
`.gitignore`. Estes templates são o ponto de partida.

## Como usar

### Mac / Linux
```bash
cp memory-templates/*.template seu-projeto/memory/
cd seu-projeto/memory
for f in *.template; do mv "$f" "${f%.template}"; done
```

### Windows PowerShell
```powershell
Copy-Item memory-templates\*.template seu-projeto\memory\
Get-ChildItem seu-projeto\memory\*.template | Rename-Item -NewName { $_.Name -replace '\.template$', '' }
```

Depois edite cada arquivo com suas informações reais.

## Templates incluídos

| Arquivo | Quem lê | O que contém |
|---|---|---|
| `project_thesis.md` | todos os agentes | tema, pergunta, objetivos do mestrado |
| `project_methodology.md` | methodology-advisor, peer-reviewer | desenho metodológico escolhido |
| `citation_style.md` | academic-writer, citation-manager | norma (ABNT/APA/Vancouver) |
| `user_writing_voice.md` | voice-humanizer, ai-pattern-auditor | perfil de voz autoral |
| `feedback_writing.md` | todos | correções acumuladas ao longo do tempo |

## Privacidade

- Estes templates **não** contêm dados pessoais — são genéricos
- Seu `memory/` real **não deve** entrar em git público (já está no `.gitignore`)
- Se quiser versionar para backup, use **repositório privado separado**
