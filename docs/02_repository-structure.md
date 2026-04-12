# Repository Structure

**Version**: 3.27
**Last Updated**: April 12, 2026
**Purpose**: Single source of truth for repository structure

> When the structure changes, update **this file first**, then update references in
> `.github/copilot-instructions.md`, `.cursor/rules/02_repository-structure.mdc`, and `README.md`.

---

## Complete Repository Structure

```text
system-design-in-practice/
├── .cursor/                               # Cursor AI project config
│   ├── rules/                             # Project rules (*.mdc)
│   └── skills.md                          # Agent index — rules, entry points, tooling (no staging content)
├── .github/                               # GitHub configuration
│   ├── workflows/                         # CI/CD workflows
│   ├── ISSUE_TEMPLATE/                    # Issue templates
│   ├── copilot-instructions.md            # GitHub Copilot instructions
│   └── prompts/                           # Reusable prompt templates
├── docs/                                  # Documentation
│   ├── 01_road-map.md                     # Learning path and roadmap
│   ├── 02_repository-structure.md         # THIS FILE — single source of truth
│   ├── 03_case-study-template.md          # Case study authoring template
│   ├── 04_target-role-playbook-alignment.md  # Synthesized target roles ↔ interview tracks + gaps
│   ├── images/                            # Diagrams and images
│   └── review-reports/                    # Review and tooling reports
│       └── 01_duplicate-markdown-headings-scan.md  # Find-DuplicateContent.ps1 output (src, docs, .archive)
├── .archive/                              # Historical snapshots (not active curriculum; see root README)
├── src/                                   # All playbook content
│   ├── CONTENT_INDEX.md                   # Content index and status tracker
│   ├── 01_foundations/                    # 🔲 Scaffold — design, tradeoff, failure frameworks
│   ├── 02_patterns/                       # 🔲 Scaffold — caching, rate-limiting, retries, messaging
│   ├── 03_distributed-systems/            # 🔲 Scaffold — notification, chat, url-shortener
│   ├── 04_ai-ml-platforms/                # 🔲 Scaffold — MLOps, observability, AI security
│   ├── 05_decision-frameworks/            # 🔲 Scaffold — when-to-use-what guides
│   ├── 06_architecture-deep-dives/        # 🔲 Scaffold — consistency, partitioning, scaling
│   ├── 07_case-studies/                   # 🔲 Scaffold — end-to-end case studies
│   ├── 08_system_designs/                 # Interview-style forward designs — README + `_template/` golden scaffold
│   └── 09_interview-qna/                  # ✅ Interview prep and Q&A (see README)
│       ├── README.md                      # Master index + daily workflow
│       ├── 01_interview-prep-conventions.md   # Duplication policy + track contract
│       ├── interview-execution/           # Shared golden template + grill + cross-domain prompts
│       ├── ai-systems-architect/          # complete.md + templates + 02_core_questions/
│       ├── enterprise-system-architect/   # complete.md + templates + 02_core_questions/
│       ├── payment-system-interview/      # Modular 01–06 (incl. mock after-action + 5-min clarify drill) + interview-execution/ (payment-tuned) + templates + 02_core_questions/
│       ├── 01_azure-solutions-architect-role-pattern/   # templates + answer-format enforcement + decision/service guides + question packs
│       ├── 02_dotnet-application-architect-azure-stack/
│       ├── 03_azure-engineering-lead-platform-pattern/
│       ├── 04_agentic-ai-lead-competency-profile/
│       ├── 05_ai-solution-architect-production-sdlc-profile/
│       ├── 06_enterprise-principal-genai-and-ea-themes/
│       ├── 07_gen-ai-lead-role-pattern/   # LLMOps + model lifecycle + responsible AI (Gen AI lead)
│       ├── 08_ai-engineer-role-pattern/   # IC AI engineer — shipping LLM-backed features end-to-end
│       ├── 09_solution-architect-platform-ai-azure/  # Platform AI SA — Azure AI + Foundry + data/ML + IaC/GitOps
│       └── career-orientation/            # skill maps + role compasses (orientation only)
├── claude.md                              # Claude Code instructions
├── CONTRIBUTING.md                        # Contribution guidelines
├── CODE_OF_CONDUCT.md                     # Code of conduct
├── LICENSE                                # MIT License
└── lychee.toml                            # Link checker configuration
```

---

## Structure Notes

### Scaffold Folders (`01_foundations/` → `07_case-studies/`)

Folders marked 🔲 are populated progressively as learning deepens; many currently hold only `.gitkeep`.
**Do not delete `.gitkeep` files** where they anchor an empty scaffold.

**`08_system_designs/`** is not an empty shell: it always carries [`README.md`](../src/08_system_designs/README.md) and [`_template/`](../src/08_system_designs/_template/README.md) as the contract for new designs.

**Pedagogical order:** foundations → patterns → distributed systems → AI/ML platforms → **decision frameworks** → **architecture deep dives** → **`07_case-studies/`** (analyze existing systems) → **`08_system_designs/`** (construct interview-style designs) → **`09_interview-qna/`** (defend in loop). *Legacy:* interview prep used to live under `99_interview-qna/` to sort after `07_` without an `08_` slot; the tree now uses sequential **`08` → `09`**.

### File Naming Rules

- Zero-padded numeric prefix: `01_`, `02_`, etc. — **never `00_`**
- Hyphens for multi-word names: `01_modern-system-design.md`
- Split files: `-part1`, `-part2` suffix (never `A/B/C`)
- Max ≤ 1000 lines per file — split rather than trim

### Case Study Structure (when populated)

Each case study under `07_case-studies/` must include:
`requirements.md`, `high-level-design.md`, `low-level-design.md`,
`scalability.md`, `trade-offs.md`, `diagrams/`

### Case studies vs system designs (`07_` vs `08_`)

| Folder | Intent | Mode | Content rule |
|--------|--------|------|--------------|
| `07_case-studies/` | Understand **existing** or canonical systems | Reverse engineering / analysis | Flexible narrative depth; prioritize **explanation** of how the real system behaves. |
| `08_system_designs/` | **Practice** designing from a prompt | Forward construction / interview-ready | **Must** follow the scaffold in `src/08_system_designs/_template/` (requirements → HLD → trade-offs → failures + `diagrams/`). |

**Placement rule:** Do **not** copy a `07_` study into `08_` with minor edits. *“How Netflix/YouTube works”* → `07_`. *“My design for a notification service in 45 minutes”* → `08_`.

**Template:** `src/08_system_designs/_template/README.md` — copy to a new sibling folder per design.

### Interview question packs (`09_interview-qna/`)

**Active prep** — not an archive. See **`README.md`** (workflow) and **`01_interview-prep-conventions.md`** (duplication policy, embedded vs shared `interview-execution/`).

Role tracks use **`01_templates/`**, **`02_core_questions/<slug>/`** with `answer.md`, `diagram.md`, `tradeoffs.md`, `followups.md`. Do **not** use a `00_` prefix (use `01_` and above). The Azure track adds **`03_azure_specific/`** and **`04_cross_domain/`**. **`07_gen-ai-lead-role-pattern/`** — LLMOps, lifecycle, governance. **`04_agentic-ai-lead-competency-profile/`** — RAG + agents at lead depth. **`08_ai-engineer-role-pattern/`** — individual-contributor scope for shipping one LLM-backed product feature (API, retrieval slice, eval, ops).

**`09_solution-architect-platform-ai-azure/`** — Solution Architect **Platform AI** on Azure: landing zones for AI workloads, **Azure OpenAI / AI Search / AML / Foundry**, optional **Databricks**, **AKS**, **IaC/GitOps**, DevSecOps/compliance-as-code; includes **whiteboard**, **principal/enterprise interview pack** (broken-enterprise scenarios), **troubleshooting** drills, **`01_templates/senior-ai-platform-architect-interviewer-guide.md`**, and **`02_core_questions/enterprise-rag-platform-principal/architecture.md`** (principal RAG reference) (not trivia-first).

**`career-orientation/`** — short orientation docs (e.g. production AI skill map, Gen AI lead / GenAI architect compasses), not full question banks.

---

## Update Protocol

1. ✅ **Update this file first**
2. ✅ Update `.github/copilot-instructions.md`
3. ✅ Update `.cursor/rules/02_repository-structure.mdc`
4. ✅ Update `README.md`

**Self-Check**: "Did I update `docs/02_repository-structure.md` first?" — If no, STOP.
