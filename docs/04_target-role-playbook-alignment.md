---
learning_level: "Intermediate"
prerequisites:
  - "../src/09_interview-qna/README.md"
estimated_time: "20 minutes"
learning_objectives:
  - "Map common target role profiles to existing interview tracks"
  - "Name cross-cutting gaps to close with deliberate practice or new packs"
related_topics:
  - "docs/01_road-map.md"
  - "src/CONTENT_INDEX.md"
---

# Target roles ↔ playbook alignment

This note **synthesizes** recurring themes from **external job profiles** you may be pursuing (cloud platform leadership, hands-on architecture, AI platform ownership). It does **not** reproduce postings verbatim. Use it to **route prep**: pick a track, run the shared [interview-execution](../src/09_interview-qna/interview-execution/README.md) spine, then drill `02_core_questions/` packs.

**Canonical track index:** [src/09_interview-qna/README.md](../src/09_interview-qna/README.md).

---

## Personas (compressed)

| Persona | Typical bar | What interviewers probe |
|---------|-------------|-------------------------|
| **P1 — Platform AI / enterprise AI architect (Azure-first)** | Staff+ judgment | Landing zones, multi-BU governance, RAG/LLM paths, AKS for inference, FinOps, security with private data |
| **P2 — Azure Solutions Architect (broad)** | Deep Azure + trade-offs | HA, multi-region, events, data stores, cost, security, hybrid integration |
| **P3 — Hands-on technical lead (.NET + cloud)** | Ship + own | Services, messaging, SQL/data access patterns, containers, IaC, on-call realism |
| **P4 — Director / head of engineering (delivery org)** | Scale people + portfolio | Metrics, CI/CD culture, risk, stakeholder comms; lighter whiteboard, heavier stories |
| **P5 — “AI-first delivery” leader (non-Azure-primary)** | Cloud + GenAI productivity | AWS-heavy estates, SDLC acceleration with coding agents, TDD/regression culture |

---

## Coverage legend

- **Strong** — First-class packs or templates under `09_interview-qna/` (or consolidated `complete.md` where noted).
- **Partial** — Mentioned or adjacent; defensible if you bring your own war stories.
- **Gap** — No dedicated pack; add external reading, mocks, or a future synthesized pack.

---

## P1 — Platform AI / enterprise AI architect (Azure-first)

| Theme | Primary tracks | Coverage |
|-------|----------------|----------|
| Enterprise AI platform (OpenAI-class, Search, AML, Foundry) | `09_solution-architect-platform-ai-azure/` | **Strong** |
| RAG, cost incidents, private paths, AKS spikes | `09_` `02_core_questions/` | **Strong** |
| LLMOps, lifecycle, governance | `07_gen-ai-lead-role-pattern/`, `05_ai-solution-architect-production-sdlc-profile/` | **Strong** |
| Agents + orchestration | `04_agentic-ai-lead-competency-profile/` | **Strong** |
| Spark / Ray–style distributed training clusters | Mentioned in passing (e.g. Databricks optional in `09_`) | **Partial** / **Gap** for deep probes |

**Suggested drill order:** `09_` whiteboard + principal pack → `enterprise-rag-platform-principal` → `security-review-rag-no-public-paths` → `openai-cost-explosion` → `07_` lifecycle pack.

---

## P2 — Azure Solutions Architect (broad)

| Theme | Primary tracks | Coverage |
|-------|----------------|----------|
| Global web, multi-region API, events | `01_azure-solutions-architect-role-pattern/` | **Strong** |
| Data platform, serverless | `01_` `03_azure_specific/` | **Strong** |
| Cross-domain (payments, AI on Azure) | `01_` `04_cross_domain/` | **Strong** |
| GraphQL-first API design | REST/APIM heavy | **Partial** |
| Kafka vs native Azure (deep compare) | EH/SB/Queue in templates | **Partial** |

**Suggested drill order:** `answer-format-enforcement.md` once → `design-global-web-app-on-azure` → `design-event-driven-architecture-on-azure` → one `04_cross_domain/` pack.

---

## P3 — Hands-on technical lead (.NET + cloud)

| Theme | Primary tracks | Coverage |
|-------|----------------|----------|
| B2B APIs, APIM, .NET shape | `02_dotnet-application-architect-azure-stack/` | **Strong** |
| Messaging (cloud-native brokers) | `01_` event-driven + service selection | **Strong** |
| Angular/SPA + BFF patterns | `02_` templates | **Partial** |
| EF Core / LINQ / SQL tuning as interview depth | System-design focus elsewhere | **Gap** (bring concrete stories) |
| Alternative OSS brokers (e.g. RabbitMQ ops) | Azure broker emphasis | **Partial** / **Gap** |
| Vertical domain (e.g. manufacturing, supply chain) | Generic playbook | **Gap** |

**Suggested drill order:** `02_` B2B pack → `01_` event-driven → `03_azure-engineering-lead-platform-pattern/` if you own AKS/GitOps.

---

## P4 — Director / head of engineering

| Theme | Primary tracks | Coverage |
|-------|----------------|----------|
| Portfolio modernization, EA-style narrative | `06_enterprise-principal-genai-and-ea-themes/`, `enterprise-system-architect/complete.md` | **Partial** / **Strong** (narrative breadth) |
| People, budget, WIP, vendor | Not drill-first in technical packs | **Gap** — use behavioral prep |
| Multi-cloud naming | `enterprise-system-architect/complete.md` | **Partial** |

---

## P5 — AI-first delivery leader (often AWS-leaning job posts)

| Theme | Primary tracks | Coverage |
|-------|----------------|----------|
| Azure AI platform | `09_`, `01_` | **Strong** |
| AWS-native architecture | `enterprise-system-architect/complete.md` (multi-cloud Q&A) | **Partial** — no AWS-only mirror of `01_` |
| Coding-agent SDLC (tooling names change fast) | Little fixed corpus | **Gap** — speak principles: review, tests, evals, supply chain |

---

## Cross-cutting gaps (prioritize deliberately)

1. **Non-Azure-primary cloud** — Add **your own** one-page service mapping (e.g. control plane ↔ Azure equivalent) or a short mock “design on AWS” session; the repo stays **Azure-first** by design.
2. **Message broker diversity** — If interviews insist on **AMQP/RabbitMQ**, prepare failure modes and bridge patterns beyond Service Bus/Event Hubs.
3. **GraphQL at scale** — Prepare federation, N+1, caching, and APIM-style governance verbally; no single atomic pack today.
4. **Batch / Ray / Spark** — Skim how your target employer uses batch ML; tie to **data pipelines + governance** narratives in `09_` until a dedicated pack exists.
5. **Regulated domains** (health, payments) — Use **payment** pack and **zero-trust B2B** pack as analogs; add domain SLOs and compliance language yourself.

---

## Redundancy you can ignore (vs consolidate)

- Repeated **section headings** across many `answer.md` files (e.g. “Based on Template v1.1”) are **intentional** template conformity — see [review-reports/01_duplicate-markdown-headings-scan.md](review-reports/01_duplicate-markdown-headings-scan.md).
- Large **consolidated** Q&A files overlap **role tracks** by design; prefer **tracks** for timed drills and **`complete.md`** for breadth reading.

---

## Next actions (for you)

1. Pick **one persona** closest to your next loop.
2. Open that track’s `README.md` and run **Path A or B** there.
3. For each **Gap** row touching your next interview, schedule **one** 25-minute spoken drill with a friend or recorder.
