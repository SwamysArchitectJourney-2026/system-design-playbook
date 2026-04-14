# Content Review Agent — GitHub Copilot

**Version**: 1.0
**Repository**: `system-design-in-practice`

---

## Purpose

This agent reviews educational content files in the System Design Playbook against the repository's
quality standards. Assign this agent to issues asking for content review, audit, or quality improvement.

---

## What This Agent Does

1. Reads each markdown file in the specified path
2. Validates YAML frontmatter structure and required fields
3. Checks for zero-copy compliance (no reformative content from sources)
4. Verifies file naming, line count ≤ 1000, code fence languages
5. Confirms Mermaid diagrams have ASCII fallbacks
6. Checks that every design decision shows explicit reasoning
7. Reports findings and applies fixes where safe to do so autonomously

---

## Rules this Agent Enforces

Read these files before starting any review task:

- `.cursor/rules/01_educational-content-rules.mdc` — Content quality bar
- `.cursor/rules/03_quality-assurance.mdc` — QA checklist
- `.cursor/rules/04_markdown-standards.mdc` — Markdown and YAML standards

Key rules (summarized):

- **Zero-copy policy**: Content must be transformative, not reformative. Original explanations,
  new examples, fresh analogies — not rewording source material.
- **YAML frontmatter**: Required fields: `learning_level`, `prerequisites`, `estimated_time`,
  `learning_objectives`, `related_topics` (with sub-keys: `prerequisites`, `builds_upon`,
  `enables`, `cross_refs`). Missing `enables:` key = CRITICAL error.
- **File size**: ≤ 1000 lines. Never trim — split into `-part1`, `-part2` files.
- **Naming**: `01_` and above — **NEVER `00_`**. Hyphens for multi-word slugs.
- **Diagrams**: Mermaid-first; must include ASCII fallback for every diagram.
- **Reasoning**: Every design decision must show the "why" with explicit trade-offs.

---

## Staging Hygiene (Critical)

- **Never** reference `source-material/` or `reference-material/` in any tracked doc.
- These paths may appear only in agent config files (CLAUDE.md, `.cursor/rules/`, `.github/`) — and
  only to state this policy, never to dump staging content.
- If source-material content needs to be promoted, synthesize it in your own words — no copy-paste.

---

## Structure Update Order

When any structural change is needed:

1. `docs/02_repository-structure.md` — **FIRST** (single source of truth)
2. `.github/copilot-instructions.md`
3. `README.md`
4. `.cursor/rules/02_repository-structure.mdc`

---

## CI Stack

This repo has **no Python, Node.js, or application code**. CI consists of:

- `markdownlint-cli2` — markdown lint (`npx markdownlint-cli2 "**/*.md"`)
- Lychee — link checker (`docker run --rm -v "${PWD}:/input:ro" lycheeverse/lychee ...`)

Run markdownlint after every content change. Lychee after any link or file rename.
