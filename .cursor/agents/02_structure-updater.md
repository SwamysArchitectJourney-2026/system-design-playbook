# Structure Updater Agent

**Role**: Handles all repository structure changes with the correct sync protocol.

---

## Trigger Conditions

Activate when the user asks to:

- Add, rename, move, or delete a file or folder in `src/` or `docs/`
- Create a new design pack, case study, or role track
- Update the repository tree in any documentation file
- Rename a section or module

---

## The Structure Update Protocol (MANDATORY — Non-Negotiable)

**Self-check before every action**: "Did I update `docs/02_repository-structure.md` first?"
If no, STOP and do it first.

### Sync Chain (always in this order)

1. `docs/02_repository-structure.md` — **update this FIRST** (single source of truth)
2. `.github/copilot-instructions.md` — sync the Quick Overview section
3. `README.md` — sync the structure overview / directory table
4. `.cursor/rules/02_repository-structure.mdc` — sync the authoritative tree snapshot

Do NOT update README or copilot-instructions before `docs/02_repository-structure.md`.

---

## File Naming Rules (Enforced)

- **Numeric prefixes**: `01_`, `02_`, etc. — never `00_` (no exceptions, no edge cases)
- **Hyphens**: `01_topic-name.md` — no spaces, no underscores in the topic slug
- **Split files**: `-part1`, `-part2` — never `-A`, `-B`, `-C`
- **New design packs**: all content files numbered (`01_answer.md`, `02_diagram.md`, etc.)

### Verification Commands

```powershell
# Check for 00_ violations
Get-ChildItem -Recurse -Filter "*00_*"

# Validate file references
.\\tools\\psscripts\\Validate-FileReferences.ps1

# Quick health check
.\\Quick-HealthCheck.ps1
```

---

## After Any Rename

1. Run `Validate-FileReferences.ps1` to find all inbound references to the renamed file
2. Update ALL references across YAML frontmatter (`prerequisites`, `builds_upon`, `enables`)
   and markdown links throughout the repo
3. Run markdownlint: `npx markdownlint-cli2 "**/*.md"`
4. Update `src/CONTENT_INDEX.md` if needed

---

## What NOT to Do

- Do not update `README.md` or `.github/copilot-instructions.md` before updating
  `docs/02_repository-structure.md`
- Do not create files with `00_` prefix — not even temporarily
- Do not reference `source-material/` in any tracked docs
- Do not renumber existing files casually — it breaks all inbound links

---

## References

- `docs/02_repository-structure.md` — Authoritative structure (single source of truth)
- `.cursor/rules/05_primary-directives.mdc` — Automation and structure update protocol
- `.cursor/rules/07_file-naming-conventions.mdc` — Naming rules in detail
- `.cursor/rules/08_source_material_rules.mdc` — Staging hygiene
- `.cursor/skills.md` — Repository operating index
