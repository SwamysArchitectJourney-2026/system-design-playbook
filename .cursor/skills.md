# Cursor — repository skills index

Short map for **how to operate in this playbook repo**. This file does **not** embed raw staging content; it points to policies and entry points.

**Cursor Skills (bundles):** project skills with `SKILL.md` live under [`.cursor/skills/`](skills/README.md) (`content-reviewer`, `structure-updater`). This file is the **navigation index**; each `SKILL.md` carries the **machine-facing `description`** used for skill discovery.

---

## Rules (read in this order when unsure)

| Topic | Location |
|-------|-----------|
| Rule index | [.cursor/rules/README.md](rules/README.md) |
| Educational content + quality bar | [.cursor/rules/01_educational-content-rules.mdc](rules/01_educational-content-rules.mdc) |
| Markdown standards | [.cursor/rules/04_markdown-standards.mdc](rules/04_markdown-standards.mdc) |
| QA checklist (lint, refs, naming) | [.cursor/rules/03_quality-assurance.mdc](rules/03_quality-assurance.mdc) |
| Automation + structure update protocol | [.cursor/rules/05_primary-directives.mdc](rules/05_primary-directives.mdc) |
| **Staging + zero-copy** (no paste into `src/` / `docs/`) | [.cursor/rules/08_source_material_rules.mdc](rules/08_source_material_rules.mdc) |
| Authoritative tree (update **this doc first** on structure changes) | [docs/02_repository-structure.md](../docs/02_repository-structure.md) |
| Cursor mirror of structure | [.cursor/rules/02_repository-structure.mdc](rules/02_repository-structure.mdc) |

---

## Authoritative entry points

| Purpose | Path |
|---------|------|
| Human + agent operating contract | [CLAUDE.md](../claude.md) (repo root) |
| Content status | [src/CONTENT_INDEX.md](../src/CONTENT_INDEX.md) |
| Interview prep workflow | [src/09_interview-qna/README.md](../src/09_interview-qna/README.md) |
| Learning path | [docs/01_road-map.md](../docs/01_road-map.md) |
| Target roles ↔ playbook alignment (synthesized) | [docs/04_target-role-playbook-alignment.md](../docs/04_target-role-playbook-alignment.md) |

---

## Automation (Windows / PowerShell)

Scripts live under [tools/psscripts/](../tools/psscripts/). Prefer them over one-off commands for repeated checks.

| Script | Use |
|--------|-----|
| `Quick-HealthCheck.ps1` | Folder presence + quick markdown counts |
| `Validate-FileReferences.ps1` | Broken `prerequisites` / relative file links in markdown |
| `Run-MarkdownLintAndLychee.ps1` | Local lint / link workflow when configured |
| `Find-DuplicateContent.ps1` | Duplicate markdown **headings** (≥3 files by default) |

**CI (GitHub Actions):** markdownlint-cli2 + Lychee per `.github/workflows/ci-documentation.yml` — there is **no** Python or Node application lint job in this repo.

---

## When adding new tracked docs

1. Update [docs/02_repository-structure.md](../docs/02_repository-structure.md) **first** if the tree changes.
2. Then sync [README.md](../README.md), [.github/copilot-instructions.md](../.github/copilot-instructions.md), and [.cursor/rules/02_repository-structure.mdc](rules/02_repository-structure.mdc).
3. Run `npx markdownlint-cli2` on touched paths (see workflow for globs).
