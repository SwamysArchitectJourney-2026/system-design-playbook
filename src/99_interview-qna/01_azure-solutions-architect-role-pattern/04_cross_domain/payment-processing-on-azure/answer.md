---
learning_level: "Advanced"
estimated_time: "45 minutes"
topic: "Payment processing on Azure"
---

# Design payment processing on Azure

## Clarify

- Instruments (cards, wallets, ACH); **PCI** scope; **multi-currency**; **idempotency** requirements; **SLA** for authorize vs capture.

## Estimate

- Peak TPS, settlement batch sizes, storage for ledger rows and audit logs.

## Architecture

- **Edge:** Front Door + **WAF** + **APIM** (auth, rate limits, **idempotency key** handling at API or dedicated service).
- **Core:** **Payment orchestration** service (App Service/AKS) with **state machine**; **token vault** / **payment processor** adapter (Stripe/Adyen/issuer APIs).
- **Data:** **Azure SQL** or **Cosmos** for intents + **append-only ledger** pattern; **Service Bus** for async capture/settlement and notifications.
- **Secrets:** Key Vault; **private endpoints**; **Entra ID** for admin; no PAN in logs.
- **Observability:** trace per `payment_id`; reconciliation jobs comparing processor files vs ledger.

## Deep dives

- **Outbox** pattern for reliable messaging from DB commit.
- **Exactly-once user effect** via idempotency + dedupe store.
- **PCI scope reduction**—tokenization, hosted fields, delegated vault.

## Failures

- Processor timeout—unknown state; **safe retry**; **reconciliation**; never double-settle.

## Evolution

- Single region MVP → HA SQL/Cosmos → multi-region read paths with careful **strong consistency** for money.

**Foundations in this repo:** `../../payment-system-interview/` (requirements, components, idempotency, grill).
