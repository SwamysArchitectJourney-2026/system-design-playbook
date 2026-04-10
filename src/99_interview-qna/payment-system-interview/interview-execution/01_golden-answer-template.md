---
learning_level: "Advanced"
prerequisites: ["Payment flows basics (auth, capture, settlement)"]
estimated_time: "25 minutes"
learning_objectives:
  - "Run one repeatable arc for payment system design rounds"
  - "Pause cleanly for PCI, idempotency, and processor deep dives"
topic: "Payment system interview spine"
---

# Golden answer template — payment system design

Use this as the **spine** for a 35–45 minute **payment** round (checkout, P2P, billing, or B2B payables). The interviewer will interrupt; each section should stand alone.

**Drill first:** `../01_clarifying-requirements-for-payment-systems.md` → `../03_idempotency-ledger-and-failure-handling.md`. **Executable pack:** `../02_core_questions/design-payment-azure-e2e/answer.md`.

## 0. Contract with the interviewer (30 seconds)

- Restate the problem (who pays whom, which instruments, online vs in-person if relevant).
- Say you will cover **requirements and compliance scope**, **money path and ledger**, **trade-offs**, then **evolution**.

## 1. Clarify requirements

**Functional** — happy path (authorize, capture, refund, void); **out of scope** for v1 (subscriptions, split pay, marketplace).

**Non-functional** — peak **payment TPS** vs **read QPS** (history/receipts); **latency** for user-facing authorize; **availability** (can you degrade to queued capture?); **consistency** (what must be immediate vs eventual).

**Compliance and risk** — **PCI DSS** scope (what touches PAN, who tokenizes), **regional** rules, **chargeback** handling depth, **fraud** ownership (sync score vs async).

**UX** — sync “approved/declined” vs async **pending**; how **retries** appear to the user.

Pause for confirmation or numbers.

## 2. Back-of-envelope (2–4 minutes)

- **Writes:** authorizations and captures per second; **idempotency** key cardinality.
- **Storage:** ledger + **immutable audit** growth per year; retention for disputes.
- **External:** processor **RPS** limits and **timeout** budgets; **webhook** volume.
- **Dominant risk:** usually **double charge**, **partial processor failure**, or **reconciliation drift**—name yours.

## 3. High-level design (8–12 minutes)

- **Edge:** API gateway / WAF, **authn** (customer session vs API keys for merchants).
- **Core:** **orchestrator** (state machine), **vault or token service**, **processor adapter** (PSP); clear **ownership** of each write.
- **Data:** **ledger** or **double-entry** narrative; **outbox** or queue for **async** capture, notifications, **settlement** jobs.
- **Reads:** receipt/history path (CQRS OK if justified).

Offer **Mermaid or whiteboard** when asked (`../02_core_questions/design-payment-azure-e2e/diagram.md` as a starting sketch).

## 4. Deep dives (prepare 2–3)

Pick payment-native angles:

- **Idempotency and dedupe** — keys, TTL, **exactly-once intent** with **at-least-once** transport.
- **Outbox / inbox** — no lost money messages; **consumer** idempotency.
- **Ledger and reconciliation** — internal truth vs processor statements; **break glass** for mismatches.
- **Webhooks** — signature verification, replay, ordering, **DLQ**.
- **Read vs write** — scaling history without starving the hot **money** path.

For each: happy path, **failure** path, **metric** or **alert** you’d watch.

## 5. Bottlenecks and failure modes

- What breaks first at **10×** TPS?
- Processor **slow** or **down** — queue, **circuit breaker**, user-visible **pending**?
- **Broker** backlog — **outbox** monotonicity, **poison** messages on money topics.

## 6. Trade-offs

At least **two** real forks, for example:

- **Sync authorize + capture** vs **async capture** for UX vs complexity.
- **SQL** (strong ledger story) vs **Cosmos**/NoSQL (regional scale) for **your** consistency needs.
- **Build** processor abstraction vs **lock-in** to one PSP for speed.

## 7. Evolution

- **MVP** — single region, minimal PCI surface, one PSP, manual reconciliation if needed.
- **10×** — partition ledger, **async** everywhere it belongs, **replay-safe** pipelines.
- **Global** — **currency** and **settlement** windows, **data residency**, **multi-PSP** routing.

## 8. Close

- **Invariants:** e.g. **no double capture** for same idempotency key; **no silent money loss**; **audit** for state transitions.
- **First production validation:** reconciliation job accuracy, **idempotency** chaos test, processor **timeout** behavior.

## Optional: mirror this spine in files

```text
02_core_questions/<your-slug>/
├── answer.md
├── diagram.md
├── failures.md
├── tradeoffs.md
└── followups.md   # attacks from ./02_follow-up-grill-layer.md
```

**Azure-shaped narrative:** `../../01_azure-solutions-architect-role-pattern/04_cross_domain/payment-processing-on-azure/` (from `99_interview-qna/`).

**Generic (non-payment) spine:** [`../../interview-execution/01_golden-answer-template.md`](../../interview-execution/01_golden-answer-template.md).
