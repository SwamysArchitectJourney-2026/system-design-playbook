---
learning_level: "Intermediate"
prerequisites: ["Basic distributed systems", "HTTP APIs"]
estimated_time: "20 minutes"
learning_objectives:
  - "Enumerate functional and non-functional dimensions for payment systems in interviews"
  - "Separate user scale from traffic, money-movement, and compliance constraints"
related_topics:
  prerequisites: []
  builds_upon: []
  enables:
    - 02_component-model-and-data-flow.md
    - 06_first-five-minutes-clarifying-checklist.md
  cross_refs: []
---

# Clarifying requirements: payment systems (interview opening)

In a payment or money-movement design round, interviewers reward **structured clarification**. Volume of users alone is not enough; you need a short checklist you can run in the first five minutes.

## Functional dimensions

Ask or state assumptions about:

- **Identity and sessions** — Registration, login, MFA, device binding, session revocation.
- **Who can pay** — Authenticated users only, guest checkout, corporate accounts.
- **Payment instruments** — Cards, bank transfer, wallets, regional rails; which are in scope for v1.
- **Lifecycle** — Authorize vs capture, partial capture, voids, **refunds**, chargebacks/disputes (even if “later,” acknowledge they exist).
- **History and statements** — Per-user transaction history, exports, search, retention.
- **Notifications** — Email, SMS, push when status changes (submitted, succeeded, failed).
- **Admin and operations** — Support tooling, manual adjustments, reconciliation views (often skipped in mock rounds but good to mention).

## Non-functional dimensions

- **Correctness** — No double charge; clear semantics when a gateway times out; idempotency expectations.
- **Consistency** — Strong consistency for balances and ledger posts vs eventual consistency for analytics or read replicas (call the trade-off).
- **Latency** — P50/P99 for “submit payment” vs “confirm cleared”; mobile UX expectations.
- **Availability and SLOs** — Uptime targets; degraded mode (read-only history when payment API is down).
- **Throughput** — Average and **peak** TPS, seasonal spikes, batch settlement windows.
- **Security** — AuthN/Z, rate limiting, abuse/fraud signals, encryption, **PCI DSS scope** (minimize raw card data in your services).
- **Compliance** — PCI, local payment regulations, audit logs, data residency if relevant.
- **Read vs write profile** — History and balance checks can dominate reads; writes are fewer but heavier.

## Usage-pattern question

Expect: *Is this read-heavy, write-heavy, or balanced?*

A crisp answer pattern:

- **Writes** — Payment intents, captures, refunds drive the authoritative transactional store.
- **Reads** — History, receipts, and balance views may be much higher QPS; candidates often isolate these on replicas, search indexes, or CQRS-style projections **while** explaining lag and what the user must never see wrong (posted balance vs “pending”).

## Interview tip

State one **invariant** early—for example: *if an external processor is unavailable, we must not mark a payment as succeeded, and retries must not create a second charge.* That signals you understand the domain before drawing boxes.
