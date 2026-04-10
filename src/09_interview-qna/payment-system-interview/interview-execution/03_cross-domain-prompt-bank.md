---
learning_level: "Advanced"
prerequisites: ["Payment golden template + grill (this folder)"]
estimated_time: "20 minutes"
learning_objectives:
  - "Stress-test payment prep with adjacent-domain prompts"
topic: "Payment cross-domain prompts"
---

# Cross-domain prompt bank — payments

Use these to practice **integration-style** questions that still **center money movement**—not generic CRUD. Each line can be a **full** design or a **deep dive** on top of a checkout you already sketched.

## Payments + fraud / ML

- **Fraud scoring** in the authorization path: latency budget (e.g. &lt; 100 ms), **shadow** vs **blocking**, fallback when the model host is down.
- **Feature store** freshness for payment risk: **OLTP** events → **online** features without leaking labels across merchants.
- **Explainability** for analysts when a transaction is blocked (audit vs model IP).

## Payments + data / analytics

- **Reconciliation pipeline:** PSP files + internal ledger → **data warehouse**; detect **drift**; **replay** without double-posting.
- **Real-time dashboards** for **GMV** and **decline rates** without overloading the **transactional** DB.

## Payments + platform / APIs

- **Merchant-facing API** with **idempotent** POST semantics, **versioning**, and **webhook** delivery **SLA**.
- **Self-service** API keys and **sandbox** vs **prod** isolation; **blast radius** when one merchant is compromised.

## Payments + cloud / reliability

- **Multi-AZ** payment API: **exactly-once** user experience with **at-least-once** internals—spell the **dedupe** layer.
- **Regional** failure: **read-only** receipt mode vs **hard fail** for new charges; **compliance** of **data** copy.

## Payments + compliance and identity

- **Strong customer authentication** (SCA / 3DS) in the flow: **redirect** vs **embedded**; mobile **app** constraints.
- **Cross-border:** **currency** conversion timing, **FX** source of truth, **statement** descriptors.

## Payments + GenAI (edge cases)

- **Support copilot** that can **see** transaction history: **PII** redaction, **no** PAN in prompts, **human** approval for refunds suggested by the model.
- **Dispute intake** with **RAG** over policy docs: **citations** required; **no** auto-binding **money** actions from LLM output.

## How to practice

1. Pick **one** prompt.
2. Run it through [`01_golden-answer-template.md`](01_golden-answer-template.md).
3. Add **five** follow-ups from [`02_follow-up-grill-layer.md`](02_follow-up-grill-layer.md) **specific** to that prompt (e.g. webhook replay, model outage, warehouse lag).

**Broader (non-payment-heavy) prompts:** [`../../interview-execution/03_cross-domain-prompt-bank.md`](../../interview-execution/03_cross-domain-prompt-bank.md).
