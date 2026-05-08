# Queries Dataview prontas

Cole estas queries em qualquer nota Obsidian (com plugin Dataview ativo)
para transformar seu vault em uma interface de banco de dados.

> Sintaxe: blocos com ` ```dataview ` rodam em modo "live" e atualizam
> automaticamente quando você modifica os `.md` subjacentes.

---

## Visão geral / dashboards

### Dashboard de saúde do Zettelkasten

````markdown
```dataview
TABLE WITHOUT ID
  status as "Status",
  length(rows) as "Quantidade"
FROM "03_Resources/Notas-Atomicas/permanent"
GROUP BY status
SORT status
```
````

### Notas órfãs (sem links de saída)

````markdown
```dataview
LIST
FROM "03_Resources/Notas-Atomicas/permanent"
WHERE length(file.outlinks) = 0
SORT file.mtime DESC
```
````

### Notas mais conectadas (top 10)

````markdown
```dataview
TABLE
  length(file.outlinks) + length(file.inlinks) as "Total links",
  length(file.inlinks) as "Backlinks"
FROM "03_Resources/Notas-Atomicas/permanent"
SORT length(file.outlinks) + length(file.inlinks) DESC
LIMIT 10
```
````

### Atividade dos últimos 30 dias

````markdown
```dataview
TABLE file.mtime as "Modificada em", status, type
FROM "03_Resources" or "01_Projects"
WHERE file.mtime > date(today) - dur(30 days)
SORT file.mtime DESC
```
````

---

## Por projeto

### Status do projeto atual

````markdown
```dataview
TABLE
  type,
  status,
  file.mtime as "Modificada"
FROM "01_Projects/2026-Dissertacao"
SORT file.mtime DESC
```
````

### Drafts pendentes de humanização

````markdown
```dataview
LIST file.link
FROM "01_Projects"
WHERE type = "draft"
  AND (voice_calibrated = false OR voice_calibrated = null)
SORT file.mtime DESC
```
````

### Drafts com pendências `[CITAR:]` marcadas

````markdown
```dataview
TABLE WITHOUT ID
  file.link as "Draft",
  length(filter(file.lists, (l) => contains(l.text, "CITAR"))) as "Pendencias"
FROM "01_Projects"
WHERE type = "draft"
SORT length(filter(file.lists, (l) => contains(l.text, "CITAR"))) DESC
```
````

---

## Por tema / tag

### Notas de um tema específico (ex: Foucault)

````markdown
```dataview
TABLE
  status,
  length(file.outlinks) as "Conexoes saindo",
  file.mtime as "Modificada"
FROM "03_Resources/Notas-Atomicas/permanent"
WHERE contains(tags, "foucault")
SORT file.mtime DESC
```
````

### Cruzamento de duas tags (interseção)

````markdown
```dataview
LIST
FROM "03_Resources/Notas-Atomicas/permanent"
WHERE contains(tags, "vigilancia") AND contains(tags, "modulacao")
SORT file.name ASC
```
````

### Todas as tags do vault com contagem

````markdown
```dataview
TABLE WITHOUT ID
  key as "Tag",
  rows.file.link as "Notas"
FROM "03_Resources/Notas-Atomicas"
FLATTEN file.tags as tag
GROUP BY tag as key
SORT length(rows) DESC
```
````

---

## Bibliografia / fichamentos

### Fichamentos por status de leitura

````markdown
```dataview
TABLE
  citekey,
  status,
  read_date,
  length(file.outlinks) as "Notas atomicas geradas"
FROM "03_Resources/Bibliografia/Fichamentos"
SORT read_date DESC
```
````

### Fontes adicionadas mas ainda não fichadas

````markdown
```dataview
LIST
FROM "03_Resources/Bibliografia/PDFs"
WHERE !contains(file.outlinks, "Fichamentos")
LIMIT 20
```
````

### Autores mais citados nas suas notas

````markdown
```dataview
TABLE WITHOUT ID
  key as "Citekey",
  length(rows) as "Mencoes em notas atomicas"
FROM "03_Resources/Notas-Atomicas/permanent"
FLATTEN sources as source
GROUP BY source as key
SORT length(rows) DESC
LIMIT 15
```
````

---

## Workflow & cadência

### Inbox cheio (lembrete para processar)

````markdown
```dataview
TABLE file.ctime as "Capturado em", file.size as "Bytes"
FROM "00_Inbox"
SORT file.ctime ASC
```
````

### Notas que precisam ser promovidas raw → refined

````markdown
```dataview
LIST file.link
FROM "03_Resources/Notas-Atomicas"
WHERE status = "raw"
  AND file.ctime < date(today) - dur(7 days)
SORT file.ctime ASC
```
````

### Notas conectadas há mais de 6 meses sem revisão

````markdown
```dataview
LIST file.link
FROM "03_Resources/Notas-Atomicas/permanent"
WHERE status = "connected"
  AND file.mtime < date(today) - dur(180 days)
SORT file.mtime ASC
```
````

---

## Auditorias de IA & voz

### Histórico de auditorias do `ai-pattern-auditor`

````markdown
```dataview
TABLE
  audited as "Documento auditado",
  date as "Data"
FROM "01_Projects" and #ai-audit
SORT date DESC
```
````

### Drafts auditados com score médio alto (precisam atenção)

````markdown
```dataview
TABLE score_medio as "Score", criticos as "Críticos"
FROM "01_Projects" and #ai-audit
WHERE score_medio > 6
SORT score_medio DESC
```
````

---

## Métricas pessoais

### Notas atômicas criadas por mês

````markdown
```dataview
TABLE WITHOUT ID
  dateformat(file.ctime, "yyyy-MM") as "Mês",
  length(rows) as "Notas criadas"
FROM "03_Resources/Notas-Atomicas/permanent"
GROUP BY dateformat(file.ctime, "yyyy-MM")
SORT key DESC
LIMIT 12
```
````

### Crescimento da rede (notas criadas + conexões)

````markdown
```dataview
TABLE WITHOUT ID
  dateformat(file.ctime, "yyyy-'W'WW") as "Semana",
  length(rows) as "Notas",
  sum(rows.length(file.outlinks)) as "Conexoes"
FROM "03_Resources/Notas-Atomicas/permanent"
WHERE file.ctime > date(today) - dur(90 days)
GROUP BY dateformat(file.ctime, "yyyy-'W'WW")
SORT key DESC
```
````

---

## Como criar uma "Página Inicial" (Home)

Crie `📋 Home.md` na raiz do vault e cole **uma combinação** das queries
acima. Sugestão de estrutura:

````markdown
# 📋 Mestrado — Painel

## ⚡ Capturas pendentes

```dataview
LIST
FROM "00_Inbox"
SORT file.ctime ASC
```

## 📝 Drafts em andamento

```dataview
TABLE status, file.mtime as "Modificada"
FROM "01_Projects"
WHERE type = "draft"
SORT file.mtime DESC
```

## 🧠 Saúde do Zettelkasten

```dataview
TABLE WITHOUT ID
  status as "Status",
  length(rows) as "Quantidade"
FROM "03_Resources/Notas-Atomicas/permanent"
GROUP BY status
```

## 🔥 Notas mais ativas

```dataview
LIST
FROM "03_Resources/Notas-Atomicas/permanent"
WHERE file.mtime > date(today) - dur(7 days)
SORT file.mtime DESC
LIMIT 10
```

## 📚 Últimos fichamentos

```dataview
TABLE citekey, read_date
FROM "03_Resources/Bibliografia/Fichamentos"
SORT read_date DESC
LIMIT 5
```
````

Marque essa nota como **starred** (`Ctrl+Shift+S` no nome) e abra ela
sempre que iniciar uma sessão. Em 5 segundos você vê o estado da sua
pesquisa.
