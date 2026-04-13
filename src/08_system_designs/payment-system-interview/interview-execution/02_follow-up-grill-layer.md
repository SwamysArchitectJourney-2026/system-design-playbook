---
learning_level: "Advanced"
prerequisites: ["Golden answer template — payment (this track)"]
estimated_time: "30 minutes"
learning_objectives:
  - "Anticipate payment interview follow-ups by category"
  - "Answer with ledger, idempotency, and PCI mechanisms"
topic: "Payment system grill layer"
---

# Follow-up grill layer — payment systems

Staff+ **payment** rounds probe **money correctness**, **compliance touchpoints**, and **operational reconciliation**. For each topic, prepare a **one-sentence thesis** plus **one concrete mechanism** (not “we’d monitor it”).

Use with `../04_follow-ups-and-grill-payment-system.md` and `./03_cross-domain-prompt-bank.md`.

## Correctness, money, and ledger

- **Double charge / duplicate capture** — idempotency key on **intent** (client or server generated); **dedupe** store TTL vs dispute window; **at-least-once** webhooks + **idempotent** handlers.
- **Partial failure** — authorized at PSP but **timeout** before you persist; **reconcile** against PSP; **compensation** (void) vs **retry** rules; **saga** boundaries.
- **Ordering** — per **merchant** or **account** serialization where the ledger requires it; when **global** order is unnecessary.
- **Ledger vs processor truth** — daily/hourly **reconciliation**; **adjustment** entries; who wins on mismatch.

## PCI, tokens, and trust boundaries

- **PAN handling** — what stays in **PSP** vs your vault; **token** only in app tier; **scope** reduction (hosted fields, redirect).
- **Secrets and keys** — webhook signing secrets, API keys; **rotation** without dropping events.
- **Insider / support tools** — who can **refund**; **dual control**; **audit** every money state change.

## Consistency and user-visible state

- **Stale read after pay** — user sees **pending** until **capture** confirmed; **read-your-writes** on session-scoped status.
- **Strong vs eventual** — what must be **consistent** before you show “paid” (your ledger + PSP acknowledgment policy).

## Messaging, async, and webhooks

- **Broker down** — **outbox** in DB; **ordering** per aggregate; **replay** idempotency.
- **Duplicate webhooks** — **natural keys** (PSP event id); **dedupe** table; **at-least-once** assumption.
- **Delayed settlement** — jobs vs streams; **SLA** for “money settled” vs “user charged.”

## Caching (payments)

- **What you must not cache wrong** — balances, **authorization** status; short TTL only if any.
- **Idempotency responses** — safe to cache **same key → same outcome** for **GET-style** replay semantics.

## External dependencies (PSP, banks, schemes)

- **PSP outage** — queue captures, **fail closed** on new auth if policy requires; **degrade** messaging.
- **Rate limits** — **token bucket** at edge; **per-merchant** quotas; **backoff** that does not amplify **retries** into double work.
- **Version upgrades** — PSP API **version** pin; **contract tests** before rollout.

## Fraud and abuse

- **Checkout abuse** — velocity limits, **device** / **IP** signals, **3DS** / SCA triggers.
- **Refund abuse** — **cooling off**, **manual** review thresholds, **link** to original **capture** id.

## Operations and observability

- **SLIs** — authorization success rate, **latency p99**, **reconciliation** lag, **webhook** age.
- **Incidents** — **pause** captures, **drain** queues, **replay** only with **idempotency** guarantees; **communicate** pending states.

## “Take the requirement away”

- “**No message broker** allowed” — **synchronous** capture only vs **DB outbox** polled workers.
- “**Single region only**” — **RTO/RPO** for ledger; **processor** as DR?
- “**Sub-200 ms** authorize UX” — **fewer hops**, **sync** fraud only, **defer** everything else.

Practice **re-scoping** in 60 seconds.

## How to use this doc

Copy bullets into `../02_core_questions/design-payment-azure-e2e/followups.md` (or your own slug) and **write answers in your own words** tied to **your** diagram.

**Generic grill (all domains):** [`../../interview-execution/02_follow-up-grill-layer.md`](../../interview-execution/02_follow-up-grill-layer.md).
