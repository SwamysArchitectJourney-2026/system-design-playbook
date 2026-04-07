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
│       ├── 01_ai-systems-qna-part1.md     # AI & Architecture Foundations (Q1–Q20)
│       ├── 01_ai-systems-qna-part2.md     # Agentic Systems & MLOps (Q21–Q40)
│       ├── 01_ai-systems-qna-part3.md     # AIOps, DevSecOps, Final Master (Q41–Q60)
│       ├── 01_ai-systems-qna-part4.md     # Speak-Ready: Role Clarity & Agentic AI
│       ├── 01_ai-systems-qna-part5.md     # Speak-Ready: RAG & LLMOps
│       ├── 01_ai-systems-qna-part6.md     # Speak-Ready: AIOps, DevSecOps, Architect
│       ├── 01_ai-systems-qna-part7.md     # Speak-Ready: Gap Analysis & Enterprise Architecture
│       ├── 01_ai-systems-qna-part8.md     # Speak-Ready: Cloud & Governance
│       ├── 01_ai-systems-qna-part9.md     # Speak-Ready: Leadership & GenAI Leadership
│       ├── 01_ai-systems-qna-part10.md    # Speak-Ready: Integration & Data Architecture
│       ├── 01_ai-systems-qna-part11.md    # Speak-Ready: Platform, DevOps & Cost Engineering
│       ├── 01_ai-systems-qna-part12.md    # Speak-Ready: Failures, Trade-offs & Storytelling
│       ├── 01_ai-systems-qna-part13.md    # Top 10 Speak-Ready Architect Answers
│       ├── 02_architect-prep-qa-part1.md  # Gen AI Lead Q1–Q10 (long-form)
│       ├── 02_architect-prep-qa-part2.md  # SA Q11–Q20 + EA Q21–Q30 (Batch 1)
│       ├── 02_architect-prep-qa-part3.md  # All roles Q31–Q60 (Batch 2)
│       └── 02_architect-prep-qa-part4.md  # All roles Q61–Q100 + Final Advice (Batches 3–4)
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
- Max ≤ 150 lines per file — split rather than trim

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
