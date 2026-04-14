---
learning_level: "Advanced"
prerequisites: ["Component model and data flow", "Idempotency, ledger, and failure handling"]
estimated_time: "45 minutes"
topic: "End-to-end payment narrative (Azure-oriented)"
learning_objectives:
  - "Deliver a structured 45-minute Azure payment narrative from clarify to close"
  - "Name Azure services at each tier: Front Door, APIM, Service Bus, SQL/Cosmos, Key Vault"
  - "Anchor failure handling to idempotency, ledger integrity, and processor reconciliation"
related_topics:
  prerequisites:
    - ../../01_foundations/02_component-model-and-data-flow.md
    - ../../01_foundations/03_idempotency-ledger-and-failure-handling.md
  builds_upon:
    - ../../01_foundations/04_follow-ups-and-grill-payment-system.md
  enables:
    - 02_diagram.md
    - 03_failures.md
  cross_refs:
    - ../../03_interview_execution/01_golden-answer-template.md
---

# Payment processing — end-to-end interview narrative

This file is the **spoken spine**. Deep modules live in the **track root** (sibling of `02_core_questions/`): `01`–`04` `*.md` files. System-specific failures: `03_failures.md`.

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

Align with `../../01_foundations/03_idempotency-ledger-and-failure-handling.md` and the Azure cross-domain pack `../../../../09_interview-qna/01_azure-solutions-architect-role-pattern/04_cross_domain/payment-processing-on-azure/answer.md` (same shape as this folder: answer, diagram, tradeoffs, followups, failures).
