---
learning_level: "Advanced"
prerequisites: ["System design basics"]
estimated_time: "20 minutes"
learning_objectives:
  - "Use one repeatable narrative arc for staff+ system design rounds"
  - "Know where to pause for interviewer steering and deep dives"
---

# Golden answer template (staff / principal system design)

Use this as the **spine** for a 35–45 minute round. The interviewer will interrupt; each section should stand alone so you can resume.

## 0. Contract with the interviewer (30 seconds)

- Restate the problem in your words.
- State what you will cover first (requirements and assumptions), then design, then trade-offs and evolution.

## 1. Clarify requirements

**Functional** — actors, core flows, explicit out-of-scope for v1.

**Non-functional** — scale (users, QPS, growth), latency, availability SLO, consistency needs, compliance (payments, PII, region), cost sensitivity.

**Usage shape** — read-heavy vs write-heavy vs mixed; peaks; batch vs online.

Pause for confirmation or numbers from the interviewer.

## 2. Back-of-envelope (2–4 minutes)

- Orders of magnitude: requests per second, storage per year, bandwidth.
- Identify the **dominant cost or risk** (e.g. DB writes, fan-out, external API quotas).

## 3. High-level design (8–12 minutes)

- Named components and **one** primary request path (verbal “boxes and arrows”).
- API style at the boundary (REST/GRPC/events); authn/z and rate limiting placement.
- Data ownership: which service owns which writes.

Offer a **Mermaid or whiteboard** sketch when asked.

## 4. Deep dives (interviewer-driven; you prepare 2–3 candidates)

Pick from:

- **Storage** — schema, hot keys, sharding, replication, consistency model.
- **Caching** — what to cache, TTL, invalidation, stampede.
- **Async** — queues, outbox, idempotency, ordering, DLQ.
- **Search or analytics** — separate path if relevant.

For each deep dive: happy path, failure path, observability.

## 5. Bottlenecks and failure modes

- What breaks first under load?
- What breaks when a dependency (DB, broker, third party) is slow or down?
- Degradation strategy: fail closed vs open, quotas, circuit breakers.

## 6. Trade-offs

Give **at least two** real alternatives (not strawmen) and why you chose one given stated requirements.

## 7. Evolution (L6+ signal)

Short arc:

- **MVP** — smallest correct system; what you defer.
- **10×** — what you add or split (read replicas, partitioning, regional).
- **100× / global** — consistency, data placement, org and platform boundaries.

## 8. Close

- Recap invariants (e.g. no double charge, no data loss for committed writes).
- One sentence on what you would validate first in production (metrics, load test, chaos).

## Optional: per-question folder layout

For a single design question you maintain in this repo, mirror the spine in files, for example:

```text
<question-slug>/
├── answer.md             # narrative: clarify → scale → HLD → deep dives → failures → what breaks first → decisions → evolution → security → cost
├── diagram.md            # Mermaid + numbered narration
├── failures.md           # system-specific (not only generic catalog)
├── tradeoffs.md
└── followups.md          # “attack” categories; see ../interview-execution/02_follow-up-grill-layer.md
```

Azure SA track uses **`01_azure-solutions-architect-role-pattern/01_templates/answer-format-enforcement.md` (Template v1.1)** for the same spine with explicit **security** vs **cost** headings.

Diagrams stay **markdown-native** (Mermaid) unless you add binary assets deliberately.
