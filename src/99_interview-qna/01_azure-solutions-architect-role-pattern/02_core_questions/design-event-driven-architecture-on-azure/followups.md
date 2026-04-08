---
learning_level: "Advanced"
estimated_time: "12 minutes"
---

# Follow-ups: event-driven on Azure

## Ordering

**Q: Are events ordered globally?**

- No—**per partition** only. If you need strict per-entity order, key by `entityId` to partition and accept throughput limits on hot keys.

## Duplicates

**Q: Consumer crashes after processing but before checkpoint—what happens?**

- At-least-once: **reprocess**; idempotency store or deterministic writes prevent double effect.

## Poison messages

**Q: Bad payload forever failing?**

- DLQ (Service Bus) or **quarantine** topic; alert; tooling to inspect and replay after fix.

## Backpressure

**Q: Producers spike 10×—downstream cannot keep up?**

- Lag grows; scale consumers; consider **throttling** producers; **autoscale** rules on CPU/lag metrics.

## Debugging

**Q: How do you trace one business transaction?**

- **Correlation ID** in event envelope; end-to-end tracing; structured logs; avoid logging PII payloads.

## Kafka vs Event Hubs

**Q: Why not managed Kafka?**

- Team skill, ecosystem, and cost; Event Hubs with Kafka API as middle ground—justify with requirements.
