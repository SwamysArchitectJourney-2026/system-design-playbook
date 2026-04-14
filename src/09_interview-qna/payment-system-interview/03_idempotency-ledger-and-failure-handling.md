---
learning_level: "Advanced"
prerequisites: ["Payment component model and request flow"]
estimated_time: "25 minutes"
learning_objectives:
  - "Explain idempotency keys and safe retries for payments"
  - "Contrast sync vs async confirmation and user-visible states"
  - "Outline reconciliation and failure handling beyond user notification"
related_topics:
  prerequisites:
    - 02_component-model-and-data-flow.md
  builds_upon: []
  enables:
    - 04_follow-ups-and-grill-payment-system.md
  cross_refs: []
---

# Idempotency, ledger, and failure handling

These topics separate **junior** sketches from **staff/principal** answers in payment design.

## Idempotency

- Clients (or your API) send an **idempotency key** with each submit operation.
- The server persists it with the payment intent; **duplicate submits** with the same key return the **same outcome** (no second charge).
- Retries from mobile flaky networks, gateway timeouts, or worker crashes must all respect the same key.

State this explicitly in interviews: *“Every payment submission is idempotent; duplicates are deduplicated at the orchestration layer.”*

## Payment state machine

Payments are not simple CRUD. Name a small set of states, for example:

- Initiated / pending
- Authorized
- Captured / settled
- Failed
- Refunded (partial or full)

Explain **who** transitions state (orchestration vs webhook from processor) and **where** persistence happens.

## Ledger vs “balance column”

For principal depth, prefer describing **double-entry or append-only ledger entries** tied to accounts and payment IDs—money is neither created nor lost, and audits are easier. Even a short explanation beats only storing a single balance field.

## Sync vs async processing

| Approach | User experience | Engineering cost |
|----------|-----------------|------------------|
| Synchronous confirmation | Clear immediate outcome | Long tail latency; brittle under processor slowness |
| Async processing | Fast acknowledgement; later final status | State complexity, reconciliation, user trust |

A strong answer is often **hybrid**: quick acknowledgement with an honest status (**received / processing**), then transition to **succeeded** or **failed** when the processor result is known—without implying success before authorization.

## When the user was told “received” but payment later fails

Notification (SMS, email, push) is necessary but **not sufficient**. Also cover:

- Persist **failed** state and visible history.
- **Release holds** or reverse reservations if your model uses them.
- **Safe retries** with idempotency; no duplicate capture.
- **Reconciliation jobs** comparing your ledger to processor reports.
- **Support playbooks** for stuck or ambiguous states (timeout after auth, etc.).

## Messaging layer

If you introduce a queue or bus, mention:

- **Producers and consumers** (who enqueues payment work).
- **At-least-once** delivery and idempotent consumers.
- **Dead-letter queues** and replay.
- **Ordering**—whether you need per-user or per-account ordering guarantees.

## Deep-dive prompt: schema

Be ready to name core entities, for example:

- **Payment** — id, user, amount, currency, status, idempotency key (unique), processor references, timestamps.
- **Ledger entry** — links to payment and accounts, debit/credit, immutable append.

You do not need full SQL in a verbal round; you need **clear keys and invariants**.
