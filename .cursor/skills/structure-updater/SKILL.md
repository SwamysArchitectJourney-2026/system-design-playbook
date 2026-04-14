---
name: structure-updater
description: >-
  Adds, renames, or moves playbook files and folders while enforcing the structure sync chain
  (docs/02_repository-structure.md first). Use when the user asks to add a track, case study,
  design pack, rename folders, or reorganize src/ or docs/.
---

# Structure updater (playbook)

## Instructions

1. **Order is mandatory** — update in this sequence:
   1. [`docs/02_repository-structure.md`](../../../docs/02_repository-structure.md) **first**
   2. [`.github/copilot-instructions.md`](../../../.github/copilot-instructions.md)
   3. [`README.md`](../../../README.md)
   4. [`.cursor/rules/02_repository-structure.mdc`](../../rules/02_repository-structure.mdc)
2. Follow the detailed checklist in [`.cursor/agents/02_structure-updater.md`](../../agents/02_structure-updater.md).
3. After edits, run `.\tools\psscripts\Validate-FileReferences.ps1` and markdownlint on touched markdown.
4. Naming: `01_`+ prefixes, hyphens in slugs, splits as `-part1`/`-part2`; **never** `00_`.

## Output

Summarize **what** moved, **which sync-chain files** were updated, and **any** follow-up (CONTENT_INDEX, interview README) the user should do.

## Related

- GitHub skill contract: [`.github/skills/structure-update.md`](../../../.github/skills/structure-update.md)
