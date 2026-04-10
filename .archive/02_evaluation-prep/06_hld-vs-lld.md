---
learning_level: "Beginner"
prerequisites: []
estimated_time: "20 minutes"
learning_objectives:
  - "Explain what High-Level Design (HLD) and Low-Level Design (LLD) mean in evaluations"
  - "Use HLD to establish architecture clarity and LLD to prove execution depth"
  - "Choose the right component for a deep dive and cover scale, correctness, and failures"
related_topics:
  prerequisites: []
  builds_upon:
    - "01_getting-ready.md"
  enables:
    - "04_mock-interviews.md"
  cross_refs:
    - "../03_foundations/06_c4-diagrams-part1.md"
    - "../07_case-studies/05-url-shortener/03_high-level-design.md"
    - "../07_case-studies/05-url-shortener/04_low-level-design.md"
---

# High-Level vs Low-Level Design (HLD vs LLD)

System design evaluations reward two different kinds of clarity:

- **HLD**: Can you structure a system that meets requirements?
- **LLD**: Do you understand the mechanics of what you proposed?

A strong evaluation performance moves smoothly between both.

---

## High-Level Design (HLD)

### What HLD is

High-Level Design describes the system’s **major components**, **boundaries**, and **end-to-end data flow**. It stays intentionally abstract: enough detail to be credible, not so much that you’re implementing.

### What HLD must answer

- What are the core components and their responsibilities?
- What are the read/write paths?
- Where do we handle scale (caching, sharding, async)?
- Where do we handle reliability (retries, timeouts, redundancy)?

### What evaluators look for

Positive signals:

- Starts simple, then evolves based on requirements
- Uses standard building blocks appropriately
- States assumptions and makes trade-offs explicit

Negative signals:

- Over-engineering immediately
- Hand-waving data flow (“it just works”)
- Ignoring failure modes or non-functional requirements

---

## Low-Level Design (LLD)

### What LLD is

Low-Level Design zooms into **one or two critical components** and explains how they actually work.

LLD is selective: you do not design every class. You show depth where it matters.

### When to switch to LLD

Switch after HLD alignment, when:

- The evaluator asks for a deep dive
- Correctness depends on details (idempotency, ordering, consistency)
- Scale depends on details (indexes, partitioning, caching strategy)

### A practical LLD checklist

Cover these, as applicable:

- **API contracts**: endpoints, request/response, idempotency, pagination
- **Data model**: keys, indexes, constraints, partitioning/sharding strategy
- **Caching**: cache keys, TTL, invalidation, read/write strategy
- **Concurrency**: race conditions, optimistic concurrency, dedupe
- **Failures**: timeouts, retries, circuit breaker, DLQ (if async)

---

## HLD → LLD: How to transition cleanly

Use a simple sentence to bridge:

> “If you’re good with the high-level architecture, I’ll deep dive into the most critical component: X.”

Pick **X** based on impact:

- For feeds: fanout pipeline + timeline store
- For URL shortener: ID generation + redirect hot path
- For payments: ledger invariants + idempotency + reconciliation

---

## Quick comparison

| Aspect | HLD | LLD |
| --- | --- | --- |
| Scope | Whole system | One/few components |
| Focus | Architecture | Mechanics |
| Artifacts | Block / C4 | Sequence / data flow + schema |
| Evaluation signal | Senior-level reasoning | Execution depth |

---

## Key takeaway

- **HLD builds trust**.
- **LLD earns conviction**.

If you can explain *why* a design exists (HLD) and *how* it behaves under pressure (LLD), you'll read as senior in both evaluations and production.
