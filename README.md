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

## 📌 Disclaimer

This is **Swamy's personal playbook and reference workspace**, not official course material or a packaged curriculum.

* It reflects evolving understanding and real-world thinking
* It is not intended to be a step-by-step tutorial
* Content is refined for clarity, not completeness

---

## 🗂 Repository Structure

> Full structure: [`docs/02_repository-structure.md`](docs/02_repository-structure.md)

To export the full folder and file structure to a text file, run:

```powershell
tree /f -I 'node_modules|bin|dist' > folderstructure.txt
Get-ChildItem -Exclude "source-material" | Tree
```

```text
system-design-playbook/
│
├── src/01_foundations/           → Design, tradeoff & failure frameworks
├── src/02_patterns/              → Caching, rate-limiting, retries, messaging
├── src/03_distributed-systems/   → Notification, chat, URL shortener
├── src/04_ai-ml-platforms/       → MLOps, observability, AI security
├── src/05_architecture-deep-dives/ → Consistency, partitioning, scaling
├── src/06_decision-frameworks/   → When-to-use-what decision guides
├── src/07_case-studies/          → End-to-end case studies
└── src/99_interview-qna/         → Interview prep (active; `99_` after `07_`) — README workflow, `01_interview-prep-conventions.md`, role tracks, `interview-execution/`, career-orientation
```

**`.archive/`** at repo root holds **historical** trees and snapshots preserved for migration reference. It is **not** part of the active curriculum; prefer `src/` paths above for new work.

---

## 🚀 How to Use This Repository

### Build Thinking

Start with:

* `src/01_foundations/design-framework.md` *(once populated)*

This defines the **default approach to any system design problem**.

---

### Learn Patterns

Pick a pattern and understand:

* What problem it solves
* Trade-offs
* Failure modes
* When **not** to use it

---

### Practice System Design

Pick a system and:

* Break down requirements
* Design architecture
* Explain trade-offs
* Identify bottlenecks and failures

---

## 🧠 Core Principles

### Trade-offs Over Perfection

Every system design is a compromise.

---

### Failure-First Thinking

Design assuming components will fail.

---

### Clarity Over Complexity

If you cannot explain it simply, you don’t understand it.

---

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

---

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
