---
learning_level: "Advanced"
prerequisites: ["Golden answer template (interview spine)"]
estimated_time: "25 minutes"
learning_objectives:
  - "Anticipate staff+ follow-ups by category"
  - "Answer with concrete mechanisms, not generic reassurance"
---

# Follow-up grill layer (interviewer attacks)

Staff+ rounds probe **mechanisms and failure**. For each topic below, prepare a **one-sentence thesis** plus **one example** from a system you know.

## Correctness and money / state

- **Double write / double charge** — idempotency keys, dedupe store, exactly-once vs at-least-once semantics; outbox pattern.
- **Partial failure** — timeout after debit but before credit; sagas, compensation, reconciliation jobs.
- **Ordering** — per-account serialization vs global ordering; when ordering is wrong to relax.

## Consistency and reads

- **Stale read after write** — replication lag; read-your-writes strategies; when to show “pending.”
- **Strong vs eventual** — what must be linearizable in this problem vs what can lag.

## Messaging and async

- **Broker down** — backlog in DB outbox, retry, DLQ, replay safety (idempotent consumers).
- **Duplicate messages** — consumer idempotency, natural keys, dedupe TTL.
- **Hot partitions** — skewed keys; mitigation (sub-sharding, random suffix, rate limits).

## Caching

- **Thundering herd** — single-flight, jitter, proactive invalidation vs TTL.
- **Cache inconsistency** — who invalidates; version stamps; accept staleness for which reads.

## External dependencies

- **Third-party SLA** — circuit breaker, bulkhead, fallback, graceful degradation; user-visible behavior.
- **Rate limits** — token bucket at edge, backoff, quota accounting per tenant.

## Security and abuse

- **AuthZ gaps** — tenant isolation, object-level checks, service-to-service identity.
- **DDoS / fraud** — rate limits, WAF, device signals, step-up auth for sensitive actions.

## Operations and observability

- **What you measure** — SLIs, SLOs, burn rate; tracing across async boundaries.
- **Incident response** — feature flags, kill switches, replay vs pause consumers.

## “Take the requirement away”

- “What if you only had one region?”
- “What if latency must be under 50 ms?”
- “What if you cannot use a message broker?”

Practice **re-scoping** the design in 60 seconds without apologizing.

## How to use this doc

For each system you prepare (payments, feed, RAG platform), copy the relevant bullets into a **question-specific** `04_followups.md` and write your answers in your own words.
