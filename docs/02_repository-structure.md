# Repository Structure

**Version**: 3.0
**Last Updated**: April 7, 2026
**Purpose**: Single source of truth for repository structure

> When the structure changes, update **this file first**, then update references in
> `.github/copilot-instructions.md`, `.cursor/rules/02_repository-structure.mdc`, and `README.md`.

---

## Complete Repository Structure

```text
system-design-in-practice/
├── .cursor/rules/                         # Cursor AI project rules
├── .github/                               # GitHub configuration
│   ├── workflows/                         # CI/CD workflows
│   ├── ISSUE_TEMPLATE/                    # Issue templates
│   ├── copilot-instructions.md            # GitHub Copilot instructions
│   └── prompts/                           # Reusable prompt templates
├── docs/                                  # Documentation
│   ├── 01_road-map.md                     # Learning path and roadmap
│   ├── 02_repository-structure.md         # THIS FILE — single source of truth
│   ├── 03_case-study-template.md          # Case study authoring template
│   ├── images/                            # Diagrams and images
│   └── review-reports/                    # Review and migration reports
├── source-material/                       # Staging area (git-ignored)
├── src/                                   # All playbook content
│   ├── CONTENT_INDEX.md                   # Content index and status tracker
│   ├── 01_core/                           # 🔲 Scaffold — design, tradeoff, failure frameworks
│   ├── 02_patterns/                       # 🔲 Scaffold — caching, rate-limiting, retries, messaging
│   ├── 03_systems/                        # 🔲 Scaffold — notification, chat, url-shortener
│   ├── 04_deep-dives/                     # 🔲 Scaffold — consistency, partitioning, scaling
│   ├── 05_ai-ml-systems/                  # 🔲 Scaffold — mlops, observability, security
│   ├── 06_decision-trees/                 # 🔲 Scaffold — when-to-use-what guides
│   ├── 07_case-studies/                   # 🔲 Scaffold — end-to-end case studies
│   └── 99_interview-qna/                  # ✅ Interview Q&A material
│       ├── ai-systems-qna/                # AI systems interview track
│       │   └── complete.md                # Consolidated AI systems interview Q&A
│       └── architect-prep-qa/             # Architect prep long-form track
│           └── complete.md                # Consolidated architect prep Q&A
├── CLAUDE.md                              # Claude Code instructions
├── CONTRIBUTING.md                        # Contribution guidelines
├── CODE_OF_CONDUCT.md                     # Code of conduct
├── LICENSE                                # MIT License
└── lychee.toml                            # Link checker configuration
```

---

## Structure Notes

### Scaffold Folders (`01_core/` → `07_case-studies/`)

Folders marked 🔲 contain only `.gitkeep` — content is added progressively as learning deepens.
**Do not delete `.gitkeep` files** — they hold the folder in git.

### File Naming Rules

- Zero-padded numeric prefix: `01_`, `02_`, etc. — **never `00_`**
- Hyphens for multi-word names: `01_modern-system-design.md`
- Split files: `-part1`, `-part2` suffix (never `A/B/C`)
- Max ≤ 1000 lines per file — split rather than trim

### Case Study Structure (when populated)

Each case study under `07_case-studies/` must include:
`requirements.md`, `high-level-design.md`, `low-level-design.md`,
`scalability.md`, `trade-offs.md`, `diagrams/`

---

## Update Protocol

1. ✅ **Update this file first**
2. ✅ Update `.github/copilot-instructions.md`
3. ✅ Update `.cursor/rules/02_repository-structure.mdc`
4. ✅ Update `README.md`

**Self-Check**: "Did I update `docs/02_repository-structure.md` first?" — If no, STOP.
