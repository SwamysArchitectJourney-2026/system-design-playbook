# Skill: Structure Update

**Version**: 1.0
**Repository**: `system-design-in-practice`

---

## Description

Handles all repository structure changes in this playbook, including adding new files or folders,
renaming, reorganizing, and keeping the four-file sync chain consistent. Ensures the structure
update protocol is always followed.

---

## When to Use

- Adding a new module, role track, case study, or design pack
- Renaming or moving files or folders
- Reorganizing content into a new hierarchy
- When asked to "update the structure", "add a new track", or "rename"

---

## How to Invoke

```text
Add a new design pack for [system-name] to src/08_system_designs/
Rename [old-folder] to [new-folder] and update all references
Create a new role track [name] in src/09_interview-qna/
```

---

## The Sync Chain (enforced in this order)

1. `docs/02_repository-structure.md` — update FIRST (single source of truth)
2. `.github/copilot-instructions.md` — update second
3. `README.md` — update third
4. `.cursor/rules/02_repository-structure.mdc` — update last

**Red line**: Never update step 2, 3, or 4 before completing step 1.

---

## Naming Rules Enforced

- Numeric prefix: `01_`, `02_`, ... — **`00_` is forbidden, no exceptions**
- Hyphens in slugs: `01_topic-name.md` (not underscores in the slug part)
- Split files: `-part1`, `-part2` (not `-A`, `-B`)
- New design pack files always numbered: `01_answer.md`, `02_diagram.md`, etc.

---

## Post-Change Validation

```powershell
# Must return empty
Get-ChildItem -Recurse -Filter "*00_*"

# Validate all references
.\\tools\\psscripts\\Validate-FileReferences.ps1

# Lint check
npx markdownlint-cli2 "**/*.md"
```

---

## References

- `docs/02_repository-structure.md` — Authoritative structure
- `.cursor/rules/05_primary-directives.mdc` — Structure update protocol
- `.cursor/rules/07_file-naming-conventions.mdc` — Naming rules
- `.github/agents/structure-update.md`
