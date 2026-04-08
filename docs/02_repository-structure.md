# Repository Structure

**Version**: 3.7
**Last Updated**: April 8, 2026
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
│   └── 99_interview-qna/                  # ✅ Interview prep and Q&A (see README)
│       ├── README.md                      # Master index
│       ├── interview-execution/           # Shared golden template + grill + cross-domain prompts
│       ├── ai-systems-architect/          # complete.md + templates + 02_core_questions/
│       ├── enterprise-system-architect/   # complete.md + templates + 02_core_questions/
│       ├── payment-system-interview/      # Modular 01–04 + templates + 02_core_questions/
│       ├── 01_azure-solutions-architect-role-pattern/   # templates + answer-format enforcement + decision/service guides + question packs
│       ├── 02_dotnet-application-architect-azure-stack/
│       ├── 03_azure-engineering-lead-platform-pattern/
│       ├── 04_agentic-ai-lead-competency-profile/
│       ├── 05_ai-solution-architect-production-sdlc-profile/
│       ├── 06_enterprise-principal-genai-and-ea-themes/
│       └── career-orientation/
├── claude.md                              # Claude Code instructions
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

### Interview question packs (`99_interview-qna/`)

Role tracks use **`01_templates/`**, **`02_core_questions/<slug>/`** with `answer.md`, `diagram.md`, `tradeoffs.md`, `followups.md`. Do **not** use a `00_` prefix (use `01_` and above). The Azure track adds **`03_azure_specific/`** and **`04_cross_domain/`**.

---

## Update Protocol

1. ✅ **Update this file first**
2. ✅ Update `.github/copilot-instructions.md`
3. ✅ Update `.cursor/rules/02_repository-structure.mdc`
4. ✅ Update `README.md`

**Self-Check**: "Did I update `docs/02_repository-structure.md` first?" — If no, STOP.
