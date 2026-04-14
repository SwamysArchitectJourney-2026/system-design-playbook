# `.cursor/skills/` — Cursor project skills

Each subdirectory is one **Cursor skill**: a `SKILL.md` with YAML frontmatter (`name`, `description`) plus instructions. Cursor uses `description` to decide when the skill applies.

---

## Skills in this repo

| Directory | Purpose |
|-----------|---------|
| [`content-reviewer/`](content-reviewer/SKILL.md) | Audit `src/` and `docs/` markdown for zero-copy, YAML, naming, lint posture |
| [`structure-updater/`](structure-updater/SKILL.md) | Add/rename/move content and run the **four-file sync** from `docs/02_repository-structure.md` |

---

## Relationship to other config

| Location | Role |
|----------|------|
| [`.cursor/skills.md`](../skills.md) | **Index** — rules, scripts, entry points (not a skill bundle) |
| [`.cursor/agents/`](../agents/) | Long-form **agent** prompts (same two roles, more detail) |
| [`claude.md`](../../claude.md) | **Claude Code** contract — all agents should honor `## Agent Instructions` |
| [`.github/agents/`](../../.github/agents/) | GitHub Copilot **coding agent** task instructions |
| [`.github/skills/`](../../.github/skills/) | Copilot-oriented **skill** contracts (invoke phrases, I/O) |

---

## Adding a new skill

1. Create `.cursor/skills/<skill-slug>/SKILL.md` with valid frontmatter (`name` ≤64 chars, hyphenated; `description` ≤1024 chars, third person, trigger terms).
2. Add a matching row in this README.
3. Optionally add `.cursor/agents/NN_….md` and `.github/agents/*.md` / `.github/skills/*.md` if Copilot should share the same capability.
4. Register in [`claude.md`](../../claude.md) (`## Agent Instructions`) and, if you introduce a **new** top-level folder name, extend the `.cursor/` (or `.github/`) tree in [`docs/02_repository-structure.md`](../../docs/02_repository-structure.md).
