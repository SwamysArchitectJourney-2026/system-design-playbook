---
learning_level: "Advanced"
estimated_time: "10 minutes"
template_version: "1.1"
---

# Mandatory answer format (every `answer.md` in this track)

**Template version:** **v1.1** — state in every `answer.md` immediately under the title:

```markdown
## Based on Template v1.1
```

**Repo note:** Do not use a `00_` prefix. Templates live in `01_templates/`.

## Canonical references (say aloud in interview)

- **Service picks:** `service-selection-guide.md` (state *why* EH vs SB, Cosmos vs SQL, etc.).
- **Failures (deep):** `failure-scenario-catalog.md` + companion **`failures.md`** in the same folder as `answer.md`.
- **Grill categories:** `followup-attack-bank.md` → mirrored in `followups.md` using **Attack** headers (below).

## Atomic question pack (required files)

Each `02_core_questions/<slug>/`, `03_azure_specific/<slug>/`, `04_cross_domain/<slug>/` must contain:

| File | Purpose |
|------|---------|
| `answer.md` | Spoken spine (headings below) |
| `diagram.md` | Mermaid + **narration steps** (see below) |
| `failures.md` | Failure-first detail (system-specific; may overlap §5 but expanded) |
| `tradeoffs.md` | Extended trade-off defense |
| `followups.md` | Categorized interviewer attacks |

## Required section order in `answer.md`

1. `## Based on Template v1.1`
2. `## 1. Clarify requirements`
3. `## 2. Scale estimation (back-of-envelope)`
4. `## 3. High-level architecture` (include **3.x decision** subsections: choose / because / vs / breaks when)
5. `## 4. Deep dives (pick 2–3 in the room)`
6. `## 5. Failure scenarios and mitigations` (min **five** bullets; align with `failures.md`)
7. `## 6. What breaks first?` — ordered list under realistic spike (cache stampede, DB throttle, queue backlog, retry storm, etc.) **for this system**
8. `## 7. Key design decisions` — explicit **Chosen** vs **Rejected** rows for major forks (Azure: Event Hub vs Service Bus, Cosmos vs SQL, AKS vs App Service vs Functions, etc.)
9. `## 8. Trade-offs summary` — short table or bullets; may reference §7 but must name **when you would flip** a choice
10. `## 9. Evolution strategy (MVP → scale → global)` — **mandatory** three phases; label explicitly **MVP**, **10× / scale**, **global**
11. `## 10. Security architecture` — **not optional** on Azure tracks: PCI scope, tokenization, Entra ID / MI, Key Vault, private endpoints, secrets hygiene, webhook trust
12. `## 11. Observability and operations` — tracing per business key (`payment_id`, etc.), SLOs, reconciliation, alerting on lag/DLQ
13. `## 12. Cost considerations` — RU/autoscale, reserved capacity where applicable, egress, warm pools, FinOps guardrails

Sections **10–12** may be compressed into one paragraph each in the room; headings stay so you do not skip them under pressure.

## `diagram.md` — narration contract

Include a **numbered walkthrough** the interviewer can follow:

1. Entry (e.g. Front Door)
2. Routing / gateway
3. Compute
4. Data / cache
5. Async / side paths (if any)

## `followups.md` — category headers (Attack mode)

Use at least these level-2 sections (trim if irrelevant):

- `## Scalability attacks`
- `## Failure and resilience attacks`
- `## Data consistency attacks`
- `## Security attacks`
- `## Cost attacks`
- `## Azure depth attacks` (service selection spot checks)

Legacy synonyms (`Scalability and load`, etc.) are acceptable only during migration; prefer **Attacks** for recall under pressure.

## Interviewer signal

If §7 reads like a SKU list, rewrite using `07_interview-decision-cheatsheet.md` four-line rule.
