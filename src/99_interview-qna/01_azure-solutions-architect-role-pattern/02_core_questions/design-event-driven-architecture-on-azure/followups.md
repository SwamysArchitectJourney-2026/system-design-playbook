---
learning_level: "Advanced"
estimated_time: "15 minutes"
---

# Follow-ups: event-driven on Azure

Bank: `../../01_templates/followup-attack-bank.md`.

## Data consistency

**Q: Are events ordered globally?**

- No—**per partition** only. Strict per-entity order → partition by `entityId`; accept hot-key limits.

**Q: Consumer crashes after processing but before checkpoint?**

- At-least-once → **reprocess**; **idempotency** store or deterministic writes.

## Failure and resilience

**Q: Bad payload forever failing?**

- **DLQ** or quarantine; alert; fix; controlled replay.

**Q: Producers spike 10×—downstream cannot keep up?**

- Lag metrics; scale consumers; throttle producers if allowed; autoscale on lag.

## Scalability and load

**Q: What breaks first at 10× event rate?**

- EH throughput / partition limits, consumer CPU, downstream DB 429, SB throttling—pick for your numbers.

## Security

**Q: How do producers authenticate to Event Hubs?**

- **Managed identity** or SAS with rotation; network restrictions where required.

## Cost

**Q: Biggest cost driver?**

- EH capacity + **retention** storage; SB premium; Function execution at scale.

## Azure depth

**Q: Event Hubs vs Service Bus for ingest?**

- EH for stream throughput + replay; SB for brokered tasks—see `service-selection-guide.md`.

**Q: Why not Kafka?**

- Skills, ops, cost; EH Kafka API as compromise—justify.

## Debugging

**Q: Trace one business transaction?**

- **Correlation ID** in envelope; tracing; no PII in logs.
