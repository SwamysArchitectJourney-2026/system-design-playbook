# .github/agents/ — GitHub Copilot Coding Agent Instructions

Task-specific instruction files for the GitHub Copilot coding agent.
When Copilot's coding agent is assigned to an issue, it reads these files to understand
how to behave for that task type in this repository.

---

## Agents

| File | Task type |
|------|-----------|
| `content-review.md` | Review educational content for quality compliance |
| `structure-update.md` | Add, rename, or reorganize repository structure |

---

## Usage

When creating an issue, reference the appropriate agent in the issue body:

```text
Task type: content-review
Files to review: src/08_system_designs/payment-system-interview/01_foundations/
```

The Copilot coding agent will read `content-review.md` for context on the repo's
quality standards before generating any changes.

---

## Relationship to Other Config

- `.cursor/agents/` — Equivalent definitions for Cursor IDE and Claude Code
- `.github/skills/` — Skill definitions (how to invoke, input/output contract)
- `.github/copilot-instructions.md` — General Copilot instructions for all tasks
- `CLAUDE.md` — Authoritative operating contract (all agents read this)
