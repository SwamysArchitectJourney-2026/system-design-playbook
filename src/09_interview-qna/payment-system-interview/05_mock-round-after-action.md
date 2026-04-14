---
learning_level: "Intermediate"
prerequisites: ["01_clarifying-requirements-for-payment-systems.md"]
estimated_time: "8 minutes"
learning_objectives:
  - "Debrief a payment mock using failure-oriented language"
  - "Lock three behaviors before the next session: clarify, diagram, money path"
related_topics:
  prerequisites:
    - 01_clarifying-requirements-for-payment-systems.md
  builds_upon:
    - 04_follow-ups-and-grill-payment-system.md
  enables: []
  cross_refs:
    - 02_core_questions/design-payment-azure-e2e/answer.md
---

# Mock round — after-action (failures-style debrief)

Use this after a **payment system design** mock when the session felt fuzzy or scored weak on structure. It is a **personal drill contract**, not a transcript archive.

---

## Failure modes to recognize (common in early payment mocks)

- **Clarification tunnel vision** — Only user count (or one dimension) is clarified; TPS, peaks, latency, refunds/chargebacks, and consistency expectations stay implicit.
- **Correctness without mechanics** — “Never wrongly charge” is stated, but **idempotency**, **state transitions**, **ledger vs balance column**, and **reconciliation** never appear.
- **Generic middleware story** — Flow stops at “API gateway → middle tier → service bus → database” without **orchestrator**, **gateway adapter**, **ledger**, **fraud/risk**, **notifications**, or **reconciliation jobs**.
- **Diagram dodge** — Interviewer asks for a sketch; response is a placeholder or a vague sentence instead of **named boxes and arrows** (even verbally).
- **Async without trade-offs** — Async is chosen for UX, but **user-visible status semantics** (“received” vs “authorized/captured”), **retry safety**, and **failure after ack** are not tied to state + idempotency + reconciliation.
- **Failure path = notify only** — When payment fails after an earlier acknowledgement, only **SMS/email/push** is mentioned; **ledger state**, **compensation**, **retries with same idempotency key**, and **gateway reconciliation** are missing.
- **Read/write split hand-wavy** — CQRS or replica idea appears, but **replication lag**, **what the user must never see wrong** (balance vs pending), and **write-path strong consistency** for money are not spelled out.
- **Security at slogans** — Auth and rate limits appear, but **PCI scope**, **tokenization/vaulting**, **encryption in transit/at rest**, and **audit trail** stay thin.

If several of these showed up, treat the next session as a **repeat of the same problem** until the checklist below is automatic.

---

## Commit before the next session (minimum bar)

1. **Open with a matrix, not one question** — Run the [first-five-minutes checklist](06_first-five-minutes-clarifying-checklist.md) aloud (or from memory) before drawing.
2. **State three concrete nouns early** — **Idempotency key**, **payment state machine** (initiated → pending → authorized/captured/failed/refunded), **ledger** (or double-entry intent)—even if you simplify later.
3. **Verbal diagram discipline** — If you cannot draw, say: *“Box A: … → Box B: … → …”* with **at least seven** named components including **orchestrator**, **gateway adapter**, **ledger**, **external processor**, **outbox/queue**, **notification**, **read path** (replica/index) if you split reads.
4. **Every async claim gets a correctness pair** — What **status** does the user see, what **DB row** exists, what happens on **timeout** and on **duplicate submit**.
5. **Failure question → system then human** — After internal state and reconciliation, add notifications.

Deepen from: [03 — Idempotency, ledger, failure handling](03_idempotency-ledger-and-failure-handling.md), [02 — Component model](02_component-model-and-data-flow.md), and the pack [failures.md](02_core_questions/design-payment-azure-e2e/failures.md).

---

## One-line mantra for the next mock

**Clarify in a grid, draw in boxes, money flows through states and keys.**
