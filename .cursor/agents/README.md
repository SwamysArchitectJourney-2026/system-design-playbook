# .cursor/agents/ — Agent Instruction Files

Instruction files for specialized agents operating in this repository.
Each file defines a focused role with explicit rules, triggers, and output format.

---

## Agents

| File | Role | Trigger |
|------|------|---------|
| `01_content-reviewer.md` | Reviews educational content for quality, YAML, zero-copy, naming | "review", "audit", "check quality" |
| `02_structure-updater.md` | Handles file/folder additions, renames, and the four-file sync chain | "add", "rename", "move", "reorganize" |

---

## Related: Cursor Skills

For the same capabilities in **Cursor skill** format (`name` + `description` frontmatter), see [`.cursor/skills/`](../skills/README.md).

---

## How Agents Work in This Repo

Agents read `.cursor/rules/*.mdc` for detailed policies. The key files are:

- `01_educational-content-rules.mdc` — Content quality bar
- `03_quality-assurance.mdc` — QA checklist
- `04_markdown-standards.mdc` — Markdown and YAML standards
- `05_primary-directives.mdc` — Automation and structure update protocol
- `08_source_material_rules.mdc` — Staging hygiene

The operating contract for all agents is `CLAUDE.md` (repo root) → `## Agent Instructions` section.

---

## Adding a New Agent

1. Create `NN_agent-name.md` in this directory (use next available number)
2. Create `.cursor/skills/<slug>/SKILL.md` if Cursor should auto-route to this capability (see [`.cursor/skills/README.md`](../skills/README.md))
3. Create `.github/agents/agent-name.md` for the GitHub Copilot coding agent equivalent
4. Optionally create `.github/skills/agent-name.md` for a Copilot invoke contract
5. Add rows to the tables in this README and in `CLAUDE.md` (`## Agent Instructions`)
6. If you add a **new** top-level folder under `.cursor/`, extend the `.cursor/` tree in `docs/02_repository-structure.md`
