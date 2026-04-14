# .github/skills/ — GitHub Copilot Skill Definitions

Skill definitions that describe specific repeatable capabilities in this repository.
Each skill file specifies: what it does, when to use it, how to invoke it, and what
output to expect.

---

## Skills

| File | Capability |
|------|-----------|
| `content-review.md` | Review educational content against playbook quality standards |
| `structure-update.md` | Apply structure changes with the correct four-file sync protocol |

---

## How Skills Differ from Agents

| | Skills (`.github/skills/`) | Agents (`.github/agents/`) |
|-|---------------------------|---------------------------|
| **Purpose** | Define a reusable capability with a clear invocation contract | Provide full context for coding agent task execution |
| **Format** | Invocation syntax, input/output contract, checks performed | Operating rules, what to do, what NOT to do |
| **Used by** | Copilot chat, Copilot completions, inline suggestions | Copilot coding agent assigned to issues |

---

## Relationship to Other Config

- `.github/agents/` — Full instruction sets for coding agent tasks
- `.cursor/agents/` — Cursor/Claude Code equivalents
- `.github/prompts/skill.md` — Older, more general skill definition (repo educator role)
- `CLAUDE.md` — Authoritative operating contract
