---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "Event-driven architecture on Azure"
---

# Design event-driven architecture on Azure

## 1. Clarify requirements

**Functional**

- Producers emit **business events**; multiple consumers process asynchronously; some workflows need **reliable handoff** to workers.

**Non-functional**

- **High throughput** streaming ingest (order-of-magnitude: **100K events/s** in a hard loop—confirm).
- **Loose coupling** between producers and consumers.
- **At-least-once** delivery acceptable with **idempotent** consumers unless interviewer demands exactly-once (then outline transactional outbox + dedupe).
- Average event **~1 KB** (tune with interviewer).

## 2. Scale estimation

- **100K events/s** peak → plan **partitions** (Event Hub) to spread load; watch **TU/PU** or **processing units** limits vs cluster sizing.
- Storage growth: events/sec × size × retention for replay/analytics.

## 3. High-level architecture

**Ingest:** **Azure Event Hubs** (Kafka API optional) for high-volume ordered streams per partition.

**Compute:** **Azure Functions** (event-driven) or **AKS** consumers for heavier processing; **Dedicated** or **Premium** plans when cold start or VNET integration matters.

**Work queues / commands:** **Azure Service Bus** (queues or topics) when you need **competing consumers**, **sessions**, **DLQ**, and **per-message** semantics distinct from raw streaming.

**Storage / analytics:** **Azure Data Lake Gen2** for landing; **Synapse** / Spark / Fabric for batch/stream processing as evolution; operational store (Cosmos/SQL) for materialized state.

**Flow (typical):**

`Producer → Event Hubs → Stream processor → Service Bus (optional) → Workers → DB / Lake`

See `diagram.md`.

## 4. Deep dives

### Event Hubs vs Service Bus

- **Event Hubs:** throughput, replay, partitions, streaming pipelines.
- **Service Bus:** brokered messaging, DLQ, sessions, transactional sends in some patterns.

Many designs use **both**: Event Hubs for firehose; Service Bus for work distribution.

### Idempotency

- **Event ID** or **business key** in idempotency store (Cosmos/SQL/Redis) with TTL; safe retries from at-least-once.

### Schema

- **Schema registry** discipline (Evolution, compatibility) to avoid breaking consumers.

## 5. Failure handling

- **Retry** with backoff in Functions/consumers; **DLQ** on Service Bus; **poison** handling and replay tooling.
- **Consumer lag** alerting; autoscale consumer units on Event Hubs processor.

## 6. Trade-offs

- **Event-driven:** scalability and decoupling vs **debuggability** and distributed tracing needs.
- **Functions vs AKS:** ops simplicity vs control and long-running jobs.

## 7. Evolution

1. **MVP:** Event Hubs + single consumer group + one Function app + SQL operational store.
2. **10×:** More partitions, multiple consumer groups, fan-out to Service Bus, schema governance.
3. **Advanced:** Stream analytics / Spark, replay pipelines, contract testing between teams.

## 8. Observability and security

- **Application Insights** + correlation IDs propagated through events (baggage / envelope metadata).
- **Managed identities** for EH/SB/Storage; **private endpoints** where required.
