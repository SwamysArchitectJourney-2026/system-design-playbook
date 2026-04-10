# Failure scenarios: payment processing on Azure

- **Processor timeout / unknown state** → No success until reconciled; idempotent retry; never double-settle.
- **Service Bus / outbox stuck** → DLQ; replay with dedupe; alert on lag.
- **Key Vault / HSM latency** → Timeouts; circuit break; degrade non-critical paths only.
- **Regional isolation during split** → Single writer for ledger; forbid dual capture.
- **Webhook replay attack** → Signature + nonce + idempotency on event ID.

Also drill: `../../../payment-system-interview/04_follow-ups-and-grill-payment-system.md`.
