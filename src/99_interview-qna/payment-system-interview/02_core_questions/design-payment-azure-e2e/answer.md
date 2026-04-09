---
learning_level: "Advanced"
estimated_time: "45 minutes"
topic: "End-to-end payment narrative (Azure-oriented)"
---

# Payment processing — end-to-end interview narrative

This file is the **spoken spine**. Deep modules live in the parent folder (`01`–`04`). System-specific failures: `failures.md`.

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

Align with `../03_idempotency-ledger-and-failure-handling.md` and Azure cross-domain pack `../../01_azure-solutions-architect-role-pattern/04_cross_domain/payment-processing-on-azure/`.
