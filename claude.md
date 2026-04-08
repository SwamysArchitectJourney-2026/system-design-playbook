# CLAUDE.md — System Design in Practice

## Repository Purpose

Swamy's personal system design playbook. A **thinking system**, not a notes repo. Focused on structured reasoning, reusable architectural patterns, and production-grade decision-making.

---

## Critical Rules

### File Naming

- **NEVER** use `00_` prefix — use `01_` and above, no exceptions
- Use zero-padded numeric prefixes: `01_`, `02_`, etc.
- Use hyphens for multi-word names: `01_modern-system-design.md`
- Split files use `-part1`, `-part2` (never `A/B/C`)

### File Size

- **≤ 1000 lines per file** — split into parts if exceeded; never trim or condense

### Content Policy

- **Zero-copy policy** — all content must be transformative, not reformative
- **Quality bar**: can it be explained clearly in 5–10 minutes?
- Chain-of-Thought reasoning required in every design decision — show the "why"
- **Staging hygiene**: Do **not** mention `source-material/` (or `reference-material/`) in `README.md`, public content folders, or `docs/**/*.md`. Synthesize into tracked docs; full rule: `.cursor/rules/08_source_material_rules.mdc`.

### Staging hygiene
- Do **not** mention source-material/ (or 
eference-material/) in README.md, public content folders, or docs/**/*.md. Synthesize into tracked docs; full rule: .cursor/rules/08_source_material_rules.mdc.

### Diagrams

- **Mermaid-first**, ASCII fallback — never embed copyrighted figures

---

## Structure Update Protocol

**When repository structure changes**:

1. Update `docs/02_repository-structure.md` **FIRST** (single source of truth)
2. Then update `.github/copilot-instructions.md`, `README.md`, `.cursor/rules/02_repository-structure.mdc`

Self-check: "Did I update `docs/02_repository-structure.md` first?" — If no, STOP.

---

## Key Directories

| Path | Purpose |
|------|---------|
| `src/01_core/` | Design, tradeoff & failure frameworks |
| `src/02_patterns/` | Caching, rate-limiting, retries, messaging |
| `src/03_systems/` | Notification, chat, URL shortener |
| `src/04_deep-dives/` | Consistency, partitioning, scaling |
| `src/05_ai-ml-systems/` | MLOps, observability, AI security |
| `src/06_decision-trees/` | When-to-use-what decision guides |
| `src/07_case-studies/` | End-to-end case studies |
| `src/99_interview-qna/` | Interview Q&A (role tracks `01_`–`08_`, execution layer, career orientation) |
| `docs/02_repository-structure.md` | Authoritative repo structure |
| `source-material/` | Staging area (git-ignored) |

---

## Case Study Structure

Each case study must include:
`requirements.md`, `high-level-design.md`, `low-level-design.md`, `scalability.md`, `trade-offs.md`, `diagrams/` (C4 + sequence diagrams)

---

## Workflow & Conventions

- **Branch naming**: `swamy/DDmon-work` (e.g., `swamy/07apr-work`)
- **Platform**: Windows 11, PowerShell — use PowerShell syntax in commands
- Update local `README.md` index and `src/CONTENT_INDEX.md` after adding/renaming files
- Run `npx markdownlint-cli2 "**/*.md"` before committing

---

## YAML Frontmatter (recommended for content files)

```yaml
---
learning_level: "Beginner" | "Intermediate" | "Advanced"
prerequisites: []
estimated_time: "25 minutes"
learning_objectives:
  - "Specific, measurable outcome"
---
```
