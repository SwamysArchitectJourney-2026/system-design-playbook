# System Design Playbook

[![License](https://img.shields.io/badge/License-MIT-purple)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active-success)](https://github.com/SwamysArchitectJourney-2026/system-design-playbook)
[![System Design](https://img.shields.io/badge/System-Design-orange)](https://github.com/SwamysArchitectJourney-2026/system-design-playbook)
![Format](https://img.shields.io/badge/Format-25%20Minutes-yellow)
![Built with](https://img.shields.io/badge/Built%20with-GitHub%20Copilot-brown)
[![Maintainer](https://img.shields.io/badge/Maintainer-Viswanatha%20Swamy%20P%20K-blue)](https://github.com/SwamysArchitectJourney-2026)

---

> ⚠️ **IMPORTANT**: This is NOT an official course or syllabus. This is Swamy's personal playbook and reference workspace.

---

## 🧠 What This Repository Is

A **curated system design playbook** focused on:

* Designing scalable distributed systems
* Making architectural decisions with clarity
* Understanding trade-offs and failure modes
* Building reusable mental models and frameworks

> This is **not a notes repository**.
> This is a **thinking system for system design**.

---

## 🎯 Purpose

This repository exists to:

* Develop **structured system design thinking**
* Capture **reusable architectural patterns**
* Practice **clear articulation of complex systems**
* Build **production-grade decision-making ability**

---

## 👥 Who This Is For

* Engineers preparing for **system design and architecture interviews**
* Architects who want sharper **tradeoff and failure-mode** muscle
* Developers moving into **distributed systems** ownership
* Anyone who learns best by **iterating** between theory, analysis, and timed defense

---

## 📌 Disclaimer

This is **Swamy's personal playbook and reference workspace**, not official course material or a packaged curriculum.

* It reflects evolving understanding and real-world thinking
* It is not intended to be a step-by-step tutorial
* Content is refined for clarity, not completeness

---

## 🗂 Repository Structure

> Full structure: [`docs/02_repository-structure.md`](docs/02_repository-structure.md)

**AI agents:** Cursor prompts in [`.cursor/agents/`](.cursor/agents/README.md) and skills in [`.cursor/skills/`](.cursor/skills/README.md); Copilot coding-agent tasks in [`.github/agents/`](.github/agents/README.md) and [`.github/skills/`](.github/skills/README.md). Root contract: [`claude.md`](claude.md) → **Agent Instructions**.

To export the full folder and file structure to a text file, run:

```powershell
Get-ChildItem -exclude ".archive", ".github", ".copilot", ".cursor", "source-material" | Tree /f /a > folderstructure.txt
```

```text
system-design-playbook/
│
├── src/01_foundations/            → Core mental models (design, tradeoff, failure thinking)
├── src/02_patterns/               → Reusable building blocks (caching, rate limiting, messaging)
├── src/03_distributed-systems/    → System-level patterns (example problem domains)
├── src/04_ai-ml-platforms/        → AI/ML platform architecture (MLOps, observability, security)
├── src/05_decision-frameworks/    → When-to-use-what (tradeoff-driven decisions)
├── src/06_architecture-deep-dives/ → Advanced topics (consistency, partitioning, scaling)
├── src/07_case-studies/           → Analyze existing systems (reverse engineering / exploration)
├── src/08_system_designs/         → Structured walkthroughs (forward construction, interview-style); first active: payment-system-interview/
└── src/09_interview-qna/          → Interview execution layer — drills, templates, role tracks
```

### `07_case-studies/` vs `08_system_designs/`

| Folder | Purpose | Mode |
|--------|---------|------|
| `07_case-studies/` | Learn how a real or canonical system works | Reverse engineering |
| `08_system_designs/` | Practice designing from a prompt, step by step | Forward construction |

**Rule of thumb:** “How YouTube/Uber works” → `07_`. “My design for notifications in 45 minutes” → `08_` (use [`src/08_system_designs/_template/`](src/08_system_designs/_template/README.md)). Details: [`docs/02_repository-structure.md`](docs/02_repository-structure.md).

**`.archive/`** at repo root holds **historical** trees and snapshots preserved for migration reference. It is **not** part of the active curriculum; prefer `src/` paths above for new work.

---

## 🧭 Start Here (Recommended Path)

**Next 30–60 minutes** — work top to bottom; many `01_`–`07_` leaves are still scaffolds (`.gitkeep`) until you add notes—treat links as **targets**, not blockers.

1. **Thinking model** — [`src/01_foundations/`](src/01_foundations/) *(populate or skim your own spine)*
2. **Patterns** — [`src/02_patterns/`](src/02_patterns/)
3. **Distributed intuition** — [`src/03_distributed-systems/`](src/03_distributed-systems/)
4. **AI/ML platforms** *(when relevant)* — [`src/04_ai-ml-platforms/`](src/04_ai-ml-platforms/)
5. **Decision making** — [`src/05_decision-frameworks/`](src/05_decision-frameworks/) *(before deep dives)*
6. **Deep dives** — [`src/06_architecture-deep-dives/`](src/06_architecture-deep-dives/)
7. **Analyze** — [`src/07_case-studies/`](src/07_case-studies/)
8. **Build** — [`src/08_system_designs/`](src/08_system_designs/) *(copy `_template/` when you run a forward design)*
9. **Defend** — [`src/09_interview-qna/`](src/09_interview-qna/)

---

## 🎯 Interview Preparation System

[`src/09_interview-qna/`](src/09_interview-qna/) is an **active interview execution layer**, not a loose Q&A dump. It includes:

* Shared **answer spine** and **follow-up grill** ([`interview-execution/`](src/09_interview-qna/interview-execution/README.md))
* **Role-specific** tracks (templates, core questions, Azure / AI / platform depth where built out)
* **Failure** and **tradeoff** drills aligned with real architect-level loops
* **Conventions** so templates do not fork and drift ([`01_interview-prep-conventions.md`](src/09_interview-qna/01_interview-prep-conventions.md))

Use it to **simulate** timed defense, not only to read theory.

**Route target profiles to tracks** (synthesized, zero-copy): [`docs/04_target-role-playbook-alignment.md`](docs/04_target-role-playbook-alignment.md). **Heading dedupe scan** (tooling report): [`docs/review-reports/01_duplicate-markdown-headings-scan.md`](docs/review-reports/01_duplicate-markdown-headings-scan.md).

---

## 🧠 How to Read This Repository

Do **not** assume a single linear read.

* Jump between **patterns** and **case studies** when a question exposes a gap
* Revisit **decision frameworks** whenever you catch yourself choosing tech by habit
* Use **`09_interview-qna/`** to **test** whether the rest of the tree stuck

This repo is built for **spiral / iterative** learning, not cover-to-cover reading.

---

## 🚀 How to Use This Repository

### Build Thinking

Start with:

* `src/01_foundations/design-framework.md` *(once populated)*

This defines the **default approach to any system design problem**.

### Learn Patterns

Pick a pattern and understand:

* What problem it solves
* Trade-offs
* Failure modes
* When **not** to use it

### Practice System Design (Interview Mode)

Pick a system (or a prompt from `09_interview-qna/`) and:

1. Clarify requirements (functional + non-functional)
2. Sketch high-level architecture (boxes and arrows)
3. Name trade-offs and alternatives
4. Walk **failure** scenarios and user-visible behavior
5. Defend the design under **follow-up** questions (use the grill layer)

### Forward-design walkthroughs

When you are **building** a design from scratch (not analyzing a famous system), create a folder under [`src/08_system_designs/`](src/08_system_designs/) from [`_template/`](src/08_system_designs/_template/README.md).

---

## 🧠 Core Principles

### Trade-offs Over Perfection

Every system design is a compromise.

### Failure-First Thinking

Design assuming components will fail.

### Clarity Over Complexity

If you cannot explain it simply, you don’t understand it.

### Reusability

Patterns should apply across multiple systems.

---

## ✅ Quality Bar

Every document must satisfy:

> Can this be explained clearly and confidently in 5–10 minutes?

If not, it does not belong here.

---

## 🔁 Related Repository

### 🔬 engineering-learning-lab

* Exploration
* Experiments
* Raw thinking
* AI/ML/GenAI work

### 🧠 system-design-playbook (this repo)

* Structured thinking
* Refined insights
* Reusable patterns
* Clear articulation

### Workflow

```text
engineering-learning-lab → distillation → system-design-playbook
```

---

## 🚧 Status

Actively evolving as part of a continuous architecture and system design journey.

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).

---

## 👤 Author

Viswanatha Swamy P K

---

> “System design is not about knowing more patterns.
> It’s about knowing when to use them—and when not to.”
