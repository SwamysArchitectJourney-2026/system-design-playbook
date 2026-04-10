---
learning_level: "Intermediate"
estimated_time: "15 minutes"
learning_objectives:
  - "Lock scope, scale, and correctness constraints before drawing components"
---

# Requirements — [system name]

## Problem (one paragraph)

What are we building, for whom, and what “done” means for this exercise?

## Functional scope

- Core user journeys:
- Explicit **out of scope** for v1:
- Idempotency / duplicate behavior (if money or side effects):

## Non-functional

- Scale: DAU, QPS, peak multiplier (state assumptions if unknown)
- Latency: P50/P99 targets where it matters
- Consistency: strong vs eventual (where; what the user must never see wrong)
- Availability / DR: RPO/RTO if relevant
- Compliance / security: PCI, PII, residency, etc.

## Back-of-envelope (10 lines max)

Orders of magnitude: storage per day, write QPS, read QPS, fan-out.

## Assumptions & open questions

- Assumptions:
- Questions you would still ask the interviewer:
