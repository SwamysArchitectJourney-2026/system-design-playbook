# Content Index

> Status legend: ✅ Has content | 🔲 Scaffold (`.gitkeep` — content coming)

---

## Playbook Sections

| Folder | Topic | Status | Planned Content |
|--------|-------|--------|-----------------|
| `01_foundations/` | Core frameworks | 🔲 | design-framework, tradeoff-framework, failure-framework |
| `02_patterns/` | Architectural patterns | 🔲 | caching, rate-limiting, retries, messaging |
| `03_distributed-systems/` | System designs | 🔲 | notification-system, chat-system, url-shortener |
| `04_ai-ml-platforms/` | AI & ML platforms | 🔲 | mlops-agents, observability, security |
| `05_decision-frameworks/` | Decision guides | 🔲 | when-to-use-what |
| `06_architecture-deep-dives/` | Deep dives | 🔲 | consistency, partitioning, scaling |
| `07_case-studies/` | Case studies | 🔲 | end-to-end designs |
| `08_system_designs/` | Forward designs | ✅ | [`README.md`](08_system_designs/README.md) + [`_template/`](08_system_designs/_template/README.md) (interview-style construction; not a duplicate of `07_`) · Active track: [`payment-system-interview/`](08_system_designs/payment-system-interview/README.md) (`01_foundations/` modules 01–06, `02_core_questions/design-payment-azure-e2e/` numbered pack, `03_interview_execution/`, `_templates/`) |

---

## Interview Q&A (`09_interview-qna/`)

**Index:** `09_interview-qna/README.md` · **Conventions:** `09_interview-qna/01_interview-prep-conventions.md`

**Shared layer:** `interview-execution/` (golden template, grill layer, cross-domain prompts).

**Role tracks** (`01_`–`09_` folders): each has `README.md`, `01_templates/`, `02_core_questions/<design>/` with `answer.md`, `diagram.md`, `tradeoffs.md`, `followups.md`. Azure track also has `03_azure_specific/` and `04_cross_domain/`. **`07_gen-ai-lead-role-pattern/`** — LLMOps, lifecycle, governance. **`08_ai-engineer-role-pattern/`** — IC scope, shipping one LLM-backed feature. **`09_solution-architect-platform-ai-azure/`** — Platform AI SA: Azure AI + Foundry + AML/Search + IaC/GitOps + optional Databricks.

**Consolidated Q&A:** `ai-systems-architect/complete.md`, `enterprise-system-architect/complete.md` (each track also has templates + one `02_core_questions/` pack).

**Payments:** `payment-system-interview/README.md` — foundations `01`–`04`, mock debrief **`05`**, opening drill **`06`**, + **`interview-execution/`** (payment-tuned spine/grill) + `02_core_questions/design-payment-azure-e2e/`.

**Career:** `career-orientation/README.md` — `01`–`04` orientation compasses (incl. Platform AI SA on Azure).

---

## Docs

| File | Purpose |
|------|---------|
| `docs/01_road-map.md` | Learning path and roadmap |
| `docs/02_repository-structure.md` | Authoritative repo structure (update first) |
| `docs/03_case-study-template.md` | Template for case study authoring |
| `docs/04_target-role-playbook-alignment.md` | Target role personas ↔ `09_interview-qna` tracks + gaps (synthesized) |
| `docs/review-reports/01_duplicate-markdown-headings-scan.md` | Duplicate-heading scan (`Find-DuplicateContent.ps1`) for `src/`, `docs/`, `.archive/` |
