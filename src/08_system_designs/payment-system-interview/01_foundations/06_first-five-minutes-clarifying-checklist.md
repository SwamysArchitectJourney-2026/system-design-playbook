---
learning_level: "Intermediate"
prerequisites: ["01_clarifying-requirements-for-payment-systems.md"]
estimated_time: "5 minutes"
learning_objectives:
  - "Run a complete opening clarification pass in under five minutes"
  - "Avoid single-dimension scoping (users only) in payment rounds"
related_topics:
  prerequisites:
    - 01_clarifying-requirements-for-payment-systems.md
  builds_upon:
    - 05_mock-round-after-action.md
  enables: []
  cross_refs: []
---

# First five minutes — clarifying checklist (payment design)

**Narrative:** “Before I sketch anything, I want to align on scope and SLOs—I'll state assumptions where you want me to move fast.”

Longer context and interviewer tips: [01 — Clarifying requirements](01_clarifying-requirements-for-payment-systems.md). This page is the **short script** to memorize or tape to your monitor.

---

## Scale and traffic

- [ ] **Registered users** (order of magnitude) and **growth** horizon you should design for.
- [ ] **Average and peak TPS** for **payment submits** (not just “active users”).
- [ ] **Peak concurrent checkout** or burst behavior (events, sales windows).
- [ ] **Read vs write** — Is history/balance lookup heavier than new payments? (If unknown, state both assumptions.)

---

## Money and product behavior

- [ ] **Instruments in scope** — Cards only, bank transfer, wallets, regional rails; **guest vs logged-in only**.
- [ ] **Lifecycle** — Authorize/capture split, partial capture, voids, **refunds** (in scope for v1 or explicitly later), **chargebacks/disputes** (at least acknowledged).
- [ ] **Balances** — User-visible balance, holds, settlement to merchant—what must be **strongly consistent** vs **eventually** visible?

---

## Experience and reliability

- [ ] **Latency** — Acceptable wait for “submit” vs “confirmed”; mobile vs web expectations.
- [ ] **Availability / SLO** — Uptime target; degraded mode (e.g. history readable when processor degraded).
- [ ] **Correctness invariant** — Your words: no double charge; ambiguous processor responses handled how?

---

## Security and compliance

- [ ] **PCI / card data** — Does raw PAN ever touch our services? **Tokenization / vault** expectations?
- [ ] **Fraud / abuse** — In scope for this round or out of scope?
- [ ] **Audit** — Who needs immutable trails (finance, regulators)?

---

## Geography and platform

- [ ] **Regions / currencies** (single country vs multi-region).
- [ ] **Channels** — Web, mobile, both; any **third-party** callbacks or webhooks assumed?

---

## Exit line

“With that, I'll assume **[one sentence recap]** and draw **[N] main components** next—stop me if any dimension should change.”
