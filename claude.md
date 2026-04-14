# CLAUDE.md — System Design in Practice

## Repository Purpose

Swamy's personal system design playbook. A **thinking system**, not a notes repo. Focused on structured reasoning, reusable architectural patterns, and production-grade decision-making.

---

## Critical Rules

### Naming (Files, Folders & Topics)

- **NEVER** use `00_` prefix on any file, folder, or topic name — use `01_` and above, no exceptions
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
| `src/01_foundations/` | Design, tradeoff & failure frameworks |
| `src/02_patterns/` | Caching, rate-limiting, retries, messaging |
| `src/03_distributed-systems/` | Notification, chat, URL shortener |
| `src/04_ai-ml-platforms/` | MLOps, observability, AI security |
| `src/05_decision-frameworks/` | When-to-use-what decision guides |
| `src/06_architecture-deep-dives/` | Consistency, partitioning, scaling |
| `src/07_case-studies/` | End-to-end case studies |
| `src/08_system_designs/` | Interview-style forward designs (`README.md`, `_template/`) |
| `src/09_interview-qna/` | Interview prep (`README.md` workflow, `01_interview-prep-conventions.md`, role tracks `01_`–`09_`, `interview-execution/`, career orientation) |
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

---

## Agent Instructions

This section defines how AI agents (Claude Code, GitHub Copilot coding agent, Cursor agent)
should operate in this repository.

### Read These First

Before any task, agents must read:

| File | What it defines |
|------|----------------|
| `.cursor/skills.md` | Repository operating index — rules, entry points, scripts |
| `.cursor/rules/01_educational-content-rules.mdc` | Content quality bar (zero-copy, YAML, 1000-line rule) |
| `.cursor/rules/03_quality-assurance.mdc` | QA checklist — use for content + technical review |
| `.cursor/rules/04_markdown-standards.mdc` | Markdown and YAML frontmatter standards |
| `.cursor/rules/08_source_material_rules.mdc` | Staging hygiene — never reference source-material/ in docs |

### Available Specialized Agents

| Agent | Location | When to use |
|-------|----------|-------------|
| Content Reviewer | `.cursor/agents/01_content-reviewer.md` | Reviewing/auditing educational content |
| Structure Updater | `.cursor/agents/02_structure-updater.md` | Adding/renaming/moving files or folders |
| Content Review (GitHub) | `.github/agents/content-review.md` | GitHub Copilot coding agent — review tasks |
| Structure Update (GitHub) | `.github/agents/structure-update.md` | GitHub Copilot coding agent — structure tasks |

### Reasoning Framework (Mandatory)

All design decisions must show explicit reasoning. Use these patterns:

**Chain-of-Thought (CoT)** — For design decisions:

```text
1. UNDERSTAND: What problem does this solve?
2. DECOMPOSE: What are the building blocks?
3. ANALYZE: What are the trade-offs?
4. SYNTHESIZE: How do parts work together?
5. VALIDATE: Does this meet requirements?
```

**ReAct** — For iterative or investigative tasks:

```text
THOUGHT: Why is this the right approach given the constraints?
ACTION:  Apply the change with documented rationale
OBSERVE: Does the result align with quality standards?
REPEAT:  Until all requirements are met
```

### Non-Negotiable Rules for All Agents

1. **Never use `00_` prefix** — on any file, folder, or topic name. Use `01_` and above.
2. **Always update `docs/02_repository-structure.md` first** before any sync-chain file.
3. **Never copy staging content** — synthesize from `source-material/`; don't paste into tracked docs.
4. **Never reference `source-material/`** in `README.md`, `src/**`, or `docs/**/*.md`.
5. **Split, never trim** — if a file exceeds 1000 lines, split into `-part1`, `-part2`.
6. **Run markdownlint** before committing: `npx markdownlint-cli2 "**/*.md"`.

### CI Stack (this repo has no application code)

- `markdownlint-cli2` — only markdown lint
- Lychee — only link checker
- **No** Python lint (black, flake8), no Node lint (ESLint/TypeScript), no test runner

### How to Create New Agent Instructions

To add a new agent to this repo:

1. Create `.cursor/agents/NN_agent-name.md` — for Cursor/Claude Code
2. Create `.github/agents/agent-name.md` — for GitHub Copilot coding agent
3. Optionally create `.github/skills/agent-name.md` — for a skill definition (how to invoke it)
4. Reference the new agent in this `CLAUDE.md` table above
5. Do **not** update `docs/02_repository-structure.md` for agent config files
   (these live in `.cursor/` and `.github/` which are config, not content)
