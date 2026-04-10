# Core questions — Platform AI Solution Architect (Azure)

Each subfolder contains a complete drill for one interview scenario. Companion files follow a standard contract.

---

## Scenario index

| Folder | Scenario | Bar | Time |
|--------|----------|-----|------|
| `design-azure-ai-platform-landing-zone/` | Design an enterprise AI platform landing zone on Azure | Senior / Staff+ | 50 min |
| `enterprise-rag-platform-principal/` | Design an enterprise RAG platform (principal depth) | Principal | 35 min |
| `aks-inference-under-spikes/` | AKS inference under spikes — autoscaling, KEDA, SNAT, egress | Staff+ | 30 min |
| `security-review-rag-no-public-paths/` | Security review: RAG platform with zero public data paths | Principal | 30 min |
| `openai-cost-explosion/` | OpenAI cost explosion post-go-live: diagnosis and remediation | Staff+ | 25 min |

---

## Standard file contract per folder

| File | Purpose |
|------|---------|
| `answer.md` | Full structured answer with chain-of-thought |
| `diagram.md` | Mermaid diagrams with narration |
| `failures.md` | Failure scenario catalogue |
| `followups.md` | Attack questions by category |
| `tradeoffs.md` | Decision table: choice / upside / downside / flip trigger |
| `architecture.md` | Combined answer + diagram (principal-bar scenarios) |

> The `enterprise-rag-platform-principal/` folder uses `architecture.md` as the primary entry point (combines narrative and diagrams at principal density). Companion `failures.md`, `followups.md`, and `tradeoffs.md` are split out separately.

---

## Prep path

| Sequence | File | Why |
|----------|------|-----|
| 1 | `design-azure-ai-platform-landing-zone/answer.md` | Foundation: hub/spoke, identity, Private Link, IaC |
| 2 | `design-azure-ai-platform-landing-zone/diagram.md` | Practice drawing all 7 diagrams |
| 3 | `enterprise-rag-platform-principal/architecture.md` | Principal bar: retrieval quality + governance |
| 4 | Any `failures.md` | Rapid incident reasoning |
| 5 | Any `followups.md` | Rehearse attack Q&A |
| 6 | Any `tradeoffs.md` | Decision table recall |

---

*Cross-references: `../01_templates/` for whiteboard exercises, troubleshooting drills, and evaluation rubric.*
