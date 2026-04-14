---
learning_level: "Advanced"
prerequisites: ["Payment requirements checklist", "Idempotency and ledger basics"]
estimated_time: "25 minutes"
learning_objectives:
  - "Defend a payment design under common staff+ follow-ups"
  - "Tie answers to idempotency, ledger, messaging, and PCI boundaries"
related_topics:
  prerequisites:
    - 01_clarifying-requirements-for-payment-systems.md
    - 03_idempotency-ledger-and-failure-handling.md
  builds_upon: []
  enables:
    - 05_mock-round-after-action.md
  cross_refs:
    - interview-execution/02_follow-up-grill-layer.md
---

# Payment system: follow-ups and grill

Pair this with `01`–`03` in this folder and the payment grill in `interview-execution/02_follow-up-grill-layer.md` (generic sibling: `../interview-execution/02_follow-up-grill-layer.md`).

## Idempotency and duplicates

**Q: Client retries the same payment three times—what happens?**

- Idempotency key on submit; server returns same outcome for duplicate keys; store key → payment id mapping with TTL or lifecycle aligned to dispute windows.

**Q: Two different clients use the same idempotency key by mistake?**

- Scope key by **authenticated principal** or merchant + user; reject or namespace; never merge across tenants.

## Gateway and timeouts

**Q: Card gateway accepted auth but your process crashed before persisting—are we double charged?**

- Reconciliation: poll or webhook from gateway; internal state **unknown** until matched; never assume success on timeout; safe retry with same idempotency key toward **same** intent id.

**Q: How long do you wait on the gateway?**

- Bounded wait + async completion path; user sees **processing** with explicit states; callbacks/webhooks update ledger.

## Ledger and consistency

**Q: User sees balance in app but transaction list is empty—how?**

- Explain read path lag vs write path; separate **posted** vs **pending**; UI rules so money never looks “available” from unposted state incorrectly.

**Q: Why not just a balance column?**

- Append-only / double-entry ledger for audit, replay, and detecting inconsistency; balance as materialized view or derived.

## Messaging

**Q: Kafka is down—can users still pay?**

- Sync path for critical authorize if product requires; or queue in **transactional outbox** in primary DB until broker returns; define user-visible behavior when only outbox mode.

**Q: Consumer processes the same message twice?**

- Idempotent consumer keyed by processor reference or event id; dedupe store.

## PCI and data

**Q: Where does PAN live?**

- Prefer **tokenization / vault**; minimize PCI scope; TLS everywhere; no logging secrets; key rotation story.

## Fraud and risk (cross-domain hook)

**Q: Add ML fraud score in the hot path—how?**

- Latency budget; async vs sync block; shadow mode first; fallback when model serving fails (fail open vs closed—justify per product risk).

## Evolution

**Q: MVP for one country vs global—what changes?**

- Currency and settlement rails; data residency; id space and clock skew; multi-region active-active vs primary-secondary for ledger (often hardest part—give honest trade-off).

## Drill

Cover these in **under two minutes each** without slides—only mechanisms and trade-offs.
