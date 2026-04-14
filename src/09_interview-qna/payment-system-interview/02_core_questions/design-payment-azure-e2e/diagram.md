---
learning_level: "Advanced"
prerequisites:
  - "answer.md"
estimated_time: "5 minutes"
learning_objectives:
  - "Read the payment E2E topology at a glance and extend it verbally in the room"
related_topics:
  prerequisites:
    - answer.md
  builds_upon: []
  enables:
    - failures.md
  cross_refs:
    - ../../../01_azure-solutions-architect-role-pattern/04_cross_domain/payment-processing-on-azure/diagram.md
---

# Diagram: payment E2E

Reuse and extend: `../../../01_azure-solutions-architect-role-pattern/04_cross_domain/payment-processing-on-azure/diagram.md`.

```mermaid
flowchart LR
  C[Client]
  FD[Front Door]
  APIM[APIM]
  PO[Orchestrator]
  P[Processor adapter]
  DB[(Ledger DB)]
  SB[Service Bus]
  C --> FD --> APIM --> PO --> P
  PO --> DB
  PO --> SB
```
