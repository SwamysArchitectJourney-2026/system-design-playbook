---
learning_level: "Advanced"
prerequisites:
  - "01–03 foundation modules in this track"
estimated_time: "45 minutes"
topic: "End-to-end payment narrative (Azure-oriented)"
learning_objectives:
  - "Narrate an end-to-end Azure payment design covering identity, payment flow, idempotency, and ledger"
  - "Quote Azure services (Front Door, APIM, Service Bus, SQL, Cosmos DB) with rationale at each tier"
related_topics:
  prerequisites:
    - ../../01_clarifying-requirements-for-payment-systems.md
    - ../../02_component-model-and-data-flow.md
    - ../../03_idempotency-ledger-and-failure-handling.md
  builds_upon: []
  enables:
    - diagram.md
    - failures.md
  cross_refs: []
---

# Payment processing — end-to-end interview narrative

This file is the **spoken spine**. Deep modules live in the **track root** (sibling of `02_core_questions/`): `01`–`04` `*.md` files. System-specific failures: `failures.md`.

## 1. Clarify

Instruments, regions, **PCI** expectations, **idempotency**, sync vs async UX, chargeback/refund scope.

## 2. Estimate

Peak payment TPS, history read QPS, storage for ledger + audit.

## 3. High level

Front Door + WAF → APIM → **orchestrator** → **vault/adapter** → processor; **SQL/Cosmos** for intents + ledger; **Service Bus** for async capture, notifications, reconciliation jobs.

## 4. Deep dives (pick 2)

- Idempotency + outbox
- Read vs write split for history
- Webhooks from processor

## 5–8. Failures, trade-offs, evolution, security

Align with `../../03_idempotency-ledger-and-failure-handling.md` and the Azure cross-domain pack `../../../01_azure-solutions-architect-role-pattern/04_cross_domain/payment-processing-on-azure/answer.md` (same shape as this folder: answer, diagram, tradeoffs, followups, failures).
