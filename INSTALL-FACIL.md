# 🚀 Instalação Fácil — copie, cole, pronto

> **Para quem não programa**. Você não vai rodar nenhum comando técnico.
> Vai apenas copiar um texto, colar no Claude Code e responder algumas
> perguntas em português. O Claude faz o resto.

---

## ✅ Pré-requisito (uma única coisa)

Você precisa ter o **Claude Code** instalado. Se ainda não tem:

- **Versão app de computador (recomendada)**: https://claude.com/claude-code
  → baixe, instale, faça login
- **Versão web (qualquer navegador)**: https://claude.ai/code
  → faça login

> ⚠️ Não é o Claude.ai comum (chat). É o **Claude Code** (assistente
> de desenvolvimento). É gratuito para começar.

---

## 📋 Como usar este arquivo

1. Escolha **um** dos prompts abaixo (recomendo o "Padrão")
2. Clique no botão **"Copy"** (canto superior direito do bloco) ou
   selecione o texto e copie (Ctrl+C)
3. Abra o Claude Code
4. Cole no campo de mensagem (Ctrl+V) e dê **Enter**
5. Responda em português às 3-4 perguntas que ele fizer
6. Aguarde ~5 minutos enquanto ele trabalha
7. Pronto — você terá tudo configurado

---

## 🌟 Prompt PADRÃO (recomendado)

Cole isto no Claude Code:

```
Olá! Sou mestrando(a) e quero instalar o "Agent Study Assistant" na minha
máquina. O projeto está em https://github.com/byfabioviana/agent-study-assistant

Por favor, faça TODA a instalação para mim, em ordem:

1. Detecte automaticamente meu sistema operacional (Windows, Mac ou Linux)
2. Verifique se tenho git instalado — se não tiver, me oriente a instalar
3. Clone o repositório em ~/.claude/cache/agent-study-assistant/
4. Leia o arquivo commands/study-setup.md desse repositório e siga TODAS
   as etapas que estão lá descritas
5. Em particular:
   - Pergunte-me em português apenas o essencial: meu nome, tema do
     mestrado, norma de citação (ABNT padrão), onde criar minha pasta
     de trabalho
   - Instale os 9 agentes em ~/.claude/agents/
   - Instale o comando /study-setup em ~/.claude/commands/
   - Crie a estrutura completa de pastas (PARA + Zettelkasten) na minha
     pasta de trabalho
   - Inicialize meus arquivos de memória pré-preenchidos com meus dados
   - Valide a instalação ao final mostrando que está tudo ok
   - Faça o tour rápido pelos agentes me explicando o que cada um faz

IMPORTANTE: Sou leigo(a) em tecnologia. Não me peça para rodar comandos
no terminal por conta própria — você é quem deve executar. Use linguagem
simples, sem jargão. Confirme comigo antes de qualquer ação importante.
Se algo der errado, me explique em português claro o que houve e qual
o próximo passo.

Pode começar!
```

---

## ⚡ Prompt MÍNIMO (se você já entende um pouco)

Se você é mais experiente e quer um prompt curto:

```
Instale o Agent Study Assistant na minha máquina seguindo as instruções
do arquivo commands/study-setup.md em
https://github.com/byfabioviana/agent-study-assistant
Conduza em português, peça as informações necessárias, e faça o tour
final pelos 9 agentes.
```

---

## 🎯 Prompt DETALHADO (se quiser mais controle)

Se você já tem ideia clara do tema da pesquisa e quer pular perguntas:

```
Olá! Quero instalar o Agent Study Assistant
(https://github.com/byfabioviana/agent-study-assistant) com as seguintes
configurações já definidas — não precisa me perguntar:

- Meu nome: {SEU_NOME_AQUI}
- Tema do mestrado: {SEU_TEMA_AQUI}
- Norma de citação: ABNT
- Pasta de trabalho: {CAMINHO_DA_PASTA, ex: ~/Documents/Mestrado/}

Por favor:
1. Clone o repositório em ~/.claude/cache/agent-study-assistant/
2. Leia commands/study-setup.md e execute todas as etapas
3. Use as configurações acima para preencher os templates de memória
4. Faça o tour final pelos agentes em português

Sou leigo(a) tecnicamente — execute tudo automaticamente e me
informe ao final.
```

> ✏️ Lembre de **substituir** os campos `{SEU_NOME_AQUI}`,
> `{SEU_TEMA_AQUI}` e `{CAMINHO_DA_PASTA}` pelos seus valores antes
> de colar.

---

## 🔄 Já instalei antes — quero atualizar

Cole isto no Claude Code:

```
Atualize meu Agent Study Assistant para a versão mais recente. Faça
git pull no cache, reinstale os agentes preservando meu memory/, e
me mostre o que mudou no CHANGELOG. Se houver mudança que afete meu
fluxo, me alerte em português.
```

---

## 🆘 Algo deu errado durante a instalação

Cole isto no Claude Code (substituindo o texto entre colchetes):

```
Estou instalando o Agent Study Assistant e apareceu este erro:

[COLE AQUI A MENSAGEM DE ERRO QUE VOCÊ VIU]

Por favor, me explique em português claro o que houve, qual a causa
provável, e me guie passo a passo para resolver. Sou leigo(a) — use
linguagem simples e cuide você mesmo dos detalhes técnicos.
```

---

## ❓ Perguntas frequentes (FAQ)

### "Quanto tempo demora?"
Cerca de 5 minutos no total. A maior parte é o Claude trabalhando — você
só responde 3-4 perguntas curtas no início.

### "Vai mexer em alguma coisa importante do meu computador?"
Não. A instalação acontece em duas pastas isoladas:

- `~/.claude/agents/` (os 9 agentes)
- `~/.claude/commands/` (o comando `/study-setup`)
- A pasta de trabalho do seu mestrado (você escolhe onde)

Nenhum arquivo do seu sistema operacional é alterado. Você pode
desinstalar a qualquer momento e tudo volta ao estado anterior.

### "Posso usar isso de graça?"
**Sim**, este projeto é gratuito (licença MIT). O Claude Code tem nível
gratuito generoso para começar — só pague se ultrapassar.

### "Funciona em qual sistema operacional?"
Windows 10+, macOS 12+, Linux (Ubuntu 22+). O instalador detecta
automaticamente.

### "Preciso saber programar?"
**Não**. O propósito deste arquivo é justamente que você não precise.
Os agentes operam em linguagem natural — você conversa com eles em
português normal.

### "Onde fica meu material depois da instalação?"
Em uma pasta que **você escolhe**, por exemplo:
- `~/Google Drive/Mestrado-{Tema}/` (recomendado se você usa Google Drive)
- `~/Documents/Mestrado-{Tema}/`
- `~/OneDrive/Mestrado-{Tema}/`

Você acessa pelos seus apps de sempre (Explorer no Windows, Finder no
Mac). Os agentes trabalham sobre os mesmos arquivos que você vê ali.

### "E se meu orientador quiser ver?"
A pasta é sua — você compartilha como quiser (link do Drive,
exportação para Word/PDF, etc.).

### "Posso instalar em mais de um computador?"
Sim. Em cada máquina, repita o processo. Como sua pasta de trabalho
geralmente está em Drive/OneDrive sincronizados, o conteúdo da pesquisa
acompanha você automaticamente.

---

## 🆘 Precisa de ajuda?

- Issues no GitHub: https://github.com/byfabioviana/agent-study-assistant/issues
- Ou simplesmente cole no Claude Code: *"Tenho uma dúvida sobre o
  Agent Study Assistant: [sua pergunta]"* — ele tenta te ajudar.
