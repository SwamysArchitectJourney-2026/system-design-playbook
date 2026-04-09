# Follow-ups: payments on Azure

Use as **interviewer attack** prompts. Drill pack: `../../../payment-system-interview/04_follow-ups-and-grill-payment-system.md`.

## Scalability attacks

- Flash sale: what **rate limits** where (edge vs APIM vs orchestrator)? How do you avoid **retry storms** to the processor?
- Hot merchant key: how do you **partition** the ledger and SB subscriptions to avoid **head-of-line blocking**?

## Failure and resilience attacks

- Processor returns **timeout** after debit—what is the **user-visible** state? How long until reconciliation?
- **Service Bus** consumer bug poison-messages the queue—how do users and finance **not** double-settle on replay?

## Data consistency attacks

- **Double charge** prevention end-to-end: idempotency keys, DB constraints, processor guarantees—which **three layers**?
- **Multi-region:** where is the **single writer** for capture? What happens in a **partition**?

## Security attacks

- **Webhook** signature verification, replay, and **clock skew**—full path.
- **GDPR** delete vs **ledger immutability**—legal retention vs technical anonymization.

## Cost attacks

- Cosmos **hot partition** on one large tenant—what design change **first**?
- Reconciliation **full table scans** daily—how do you bound **SQL/Cosmos** cost?

## Azure depth attacks

- **Service Bus vs Event Hub** for capture notifications—defend in one sentence each way, then pick.
- **APIM vs only AKS ingress** for external PSP webhooks—trade-offs?
