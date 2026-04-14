# System design template (payments)

**How to use:** Copy this file to `02_core_questions/<your-slug>/` and fill each section out loud then in writing. Sections should stand alone — the interviewer will interrupt.

**Spine:** [`../03_interview_execution/01_golden-answer-template.md`](../03_interview_execution/01_golden-answer-template.md) (payment-specific; generic: `../../../09_interview-qna/interview-execution/01_golden-answer-template.md`).

**Non-negotiables:** idempotency key, **payment state machine**, ledger or double-entry story, **reconciliation**, PCI scope, user-visible **pending vs success** distinction.

**Grill:** [`../01_foundations/04_follow-ups-and-grill-payment-system.md`](../01_foundations/04_follow-ups-and-grill-payment-system.md) and [`../03_interview_execution/02_follow-up-grill-layer.md`](../03_interview_execution/02_follow-up-grill-layer.md).

---

## 0. Contract with the interviewer (30 seconds)

<!-- Who pays whom? Instruments in scope? Online / in-person? State your invariant upfront. -->
<!-- Example invariant: "Processor timeout must never produce a double charge." -->

**Problem restatement:**

**Invariant I will defend:**

---

## 1. Clarify requirements

**Functional (happy path + boundaries):**

- Instruments in scope (v1):
- Lifecycle (authorize / capture / refund / void / chargeback):
- Notifications to users:
- Admin / support tooling (ack or defer):

**Non-functional:**

- Peak payment TPS + read QPS (history/balance):
- Latency target (authorize UX):
- Availability / degraded mode:
- Consistency (what must be immediate vs eventual):

**Compliance / risk:**

- PCI scope — does raw PAN touch our services?
- Fraud scoring — sync in hot path or async / shadow?
- Audit trail requirements:

**UX:**

- Sync "approved/declined" vs async "pending → final":
- Retry UX for the user:

---

## 2. Back-of-envelope

- **Write TPS** (payment submits at peak):
- **Read QPS** (history / balance lookups):
- **Idempotency key cardinality** (per day / week):
- **Ledger growth** (entries / year × row size):
- **Dominant risk** (double charge / processor partial failure / reconciliation drift):

---

## 3. High-level design

<!-- Mermaid: start from `02_diagram.md` and annotate. Verbal fallback: name ≥7 boxes. -->

**Diagram or verbal walkthrough:**

**Edge (Front Door / APIM / WAF):**

**Core — orchestrator (state machine + idempotency):**

**Core — vault / token service:**

**Core — PSP adapter (retry, timeout ownership):**

**Data — write path (ledger, strong consistency):**

**Data — read path (projections / replicas):**

**Async — queue / broker (capture, notify, reconcile):**

---

## 4. Deep dives (prepare 2–3)

Pick from: idempotency + outbox · webhook handling + dedupe · ledger vs read replica · multi-region · PCI boundary.

### Deep dive 1: <!-- topic -->

- Happy path:
- Failure path:
- Metric / alert I'd watch:

### Deep dive 2: <!-- topic -->

- Happy path:
- Failure path:
- Metric / alert I'd watch:

### Deep dive 3 (optional): <!-- topic -->

---

## 5. Bottlenecks and failure modes

<!-- Expand with `./03_failures.md` for Azure-specific angles. -->

- At 10× TPS, what breaks first?
- Processor slow / down — user-visible behavior:
- Broker backlog — outbox monotonicity:

---

## 6. Trade-offs

| Decision | Option A | Option B | My choice + reason |
|----------|----------|----------|--------------------|
| Authorize UX | Sync confirm | Async pending | |
| Money-path DB | Azure SQL (ACID) | Cosmos DB (regional) | |
| PSP coupling | Single PSP fast | Adapter + multi-PSP | |

<!-- See `./05_tradeoffs.md` for starter list. -->

---

## 7. Evolution

- **MVP** (single region, one PSP, minimal PCI surface):
- **10×** (partitioned ledger, async everywhere it belongs):
- **Global** (multi-region ledger, data residency, multi-currency):

---

## 8. Close — invariants and first production validation

**Invariants I held throughout:**

1.
2.

**First production validation I'd run:**

- Reconciliation job accuracy (day 1 batch vs PSP statement):
- Idempotency chaos test (duplicate submits at load):
- Processor timeout behavior (what the DB row shows):
