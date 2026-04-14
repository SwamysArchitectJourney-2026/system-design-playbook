---
learning_level: "Advanced"
prerequisites:
  - "answer.md"
  - "diagram.md"
estimated_time: "10 minutes"
learning_objectives:
  - "Recall six Azure-specific failure patterns for the payment flow"
  - "State the mitigation for each (DLQ, freeze+single writer, circuit breaker)"
related_topics:
  prerequisites:
    - answer.md
    - diagram.md
  builds_upon: []
  enables:
    - followups.md
  cross_refs:
    - ../../../01_azure-solutions-architect-role-pattern/04_cross_domain/payment-processing-on-azure/failures.md
---

# Failure scenarios: end-to-end payment narrative (Azure)

System-specific angles for “what fails in **this** flow?” — expand in the room from `../../../01_azure-solutions-architect-role-pattern/04_cross_domain/payment-processing-on-azure/failures.md`.

- **Processor ambiguous state** after timeout — user sees “pending”; finance needs **reconciliation** before retry.
- **Outbox / Service Bus** stuck — capture never completes; **DLQ** and **idempotent** replay.
- **Idempotency store** loss or mis-keying — **double effect** risk; defend with **DB uniqueness** + processor keys.
- **Webhook replay** — signature + **event id** dedupe at consumer.
- **Regional failover** — dual **capture** risk; **freeze** + **single writer** runbook.
- **Key Vault / HSM** degradation — signing or token fetch slow; **circuit break** non-critical paths only.
