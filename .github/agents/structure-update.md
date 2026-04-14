# Structure Update Agent — GitHub Copilot

**Version**: 1.0
**Repository**: `system-design-in-practice`

---

## Purpose

This agent handles all repository structure changes: adding files, renaming, reorganizing folders,
and keeping the sync chain consistent. Assign to issues requesting structural additions or refactors.

---

## What This Agent Does

1. Reads the current `docs/02_repository-structure.md` for the authoritative state
2. Plans the structural change
3. Applies the change to files and folders
4. Updates the four-file sync chain in the correct order
5. Updates `src/CONTENT_INDEX.md` if tracked content was added or renamed
6. Runs reference validation to confirm no broken links

---

## Mandatory Sync Chain (ALWAYS in this order)

**Self-check**: "Did I update `docs/02_repository-structure.md` first?"
If no — STOP. Do it first before touching anything else.

1. `docs/02_repository-structure.md` — Single source of truth
2. `.github/copilot-instructions.md` — Quick Overview section
3. `README.md` — Directory table
4. `.cursor/rules/02_repository-structure.mdc` — Tree snapshot

---

## File Naming Rules

| Rule | Correct | Wrong |
|------|---------|-------|
| Numeric prefix | `01_topic.md` | `00_topic.md` (forbidden) |
| Multi-word | `01_topic-name.md` | `01_topic_name.md` |
| Split files | `01_topic-part1.md` | `01_topic-A.md` |
| Design packs | `01_answer.md`, `02_diagram.md` | `answer.md` (unnumbered) |

---

## After Any Rename or Move

1. Run: `.\\tools\\psscripts\\Validate-FileReferences.ps1`
2. Update every YAML `prerequisites`, `builds_upon`, `enables` reference to the renamed file
3. Update every markdown link pointing to the renamed file
4. Run: `npx markdownlint-cli2 "**/*.md"` — fix any issues
5. Run lychee if Docker is available

---

## Staging Hygiene

- Do **not** reference `source-material/` in `README.md`, `docs/**/*.md`, or any `src/**` file
- `source-material/` is git-ignored staging — synthesize content from it; never link to it

---

## CI Stack (no app code)

- `markdownlint-cli2` — always run after changes
- Lychee — run after renames or link changes
- No Python, Node.js, or backend tests in this repo

---

## Key Scripts

```powershell
# Check for 00_ violations (must return empty)
Get-ChildItem -Recurse -Filter "*00_*"

# Validate all file references
.\\tools\\psscripts\\Validate-FileReferences.ps1

# Quick health check
.\\Quick-HealthCheck.ps1

# Markdownlint
npx markdownlint-cli2 "**/*.md"
```
