---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "Event-driven architecture on Azure"
answer_format: "01_templates/answer-format-enforcement.md"
---

# Design event-driven architecture on Azure

## Based on Template v1.0

Companion: `failures.md`, `../../01_templates/service-selection-guide.md` (Event Hubs vs Service Bus vs Queue).

## 1. Clarify requirements

**Functional**

- Producers emit **business events**; multiple consumers process asynchronously; some workflows need **reliable handoff** to workers.

**Non-functional**

- **High throughput** streaming ingest (order-of-magnitude: **100K events/s** in a hard loop—confirm).
- **Loose coupling** between producers and consumers.
- **At-least-once** delivery acceptable with **idempotent** consumers unless interviewer demands exactly-once (then outline transactional outbox + dedupe).
- Average event **~1 KB** (tune with interviewer).

## 2. Scale estimation (back-of-envelope)

- **100K events/s** peak → **Event Hubs** partition count and **processing units** / cluster sizing (confirm SKU with interviewer).
- Storage growth: events/sec × size × **retention** (replay vs cost).

## 3. High-level architecture

### 3.1 Ingest — decision

- **Choose:** **Azure Event Hubs** for the firehose.
- **Because:** throughput + partitioned ordering + replay for analytics and multiple consumer groups.
- **Vs:** **Service Bus** as primary ingest — rejected at this volume (wrong tool for raw stream ingest).
- **Breaks when:** **hot partition** (skewed partition key) or **quota** exhaustion—must design partition key and autoscale.

### 3.2 Work distribution — decision

- **Choose:** **Service Bus** (queue/topic) **after** stream processor when tasks need **DLQ**, **sessions**, competing consumers.
- **Because:** per-message broker semantics differ from Event Hubs offsets.
- **Vs:** **Storage Queues** — cheaper but fewer enterprise features (sessions, rich DLQ patterns).
- **Breaks when:** SB **throttling** or oversized messages—need claim check pattern to Blob.

### 3.3 Compute — decision

- **Choose:** **Functions** for light processors; **AKS** for heavy/long-running or custom networking.
- **Vs:** only Functions — rejected if processing exceeds duration limits or needs GPUs.

### 3.4 Analytics path

- **Data Lake Gen2** landing; optional Spark/Synapse/Fabric.

**Flow:** `Producer → Event Hubs → Stream processor → Service Bus (optional) → Workers → DB / Lake`

See `diagram.md`.

## 4. Deep dives (pick 2–3 in the room)

### Event Hubs vs Service Bus (when both)

- EH: streaming + replay; SB: tasks + DLQ + sessions.

### Idempotency

- Event ID / business key in dedupe store; at-least-once assumed.

### Schema

- Registry + compatibility mode to prevent consumer breaks.

## 5. Failure scenarios and mitigations

1. **Consumer crash after processing, before checkpoint:** duplicate delivery—**idempotent** writes.
2. **Poison message:** move to **DLQ**; alert; fix and replay with controls.
3. **Lag spike:** scale processors; check downstream DB **429** or SB throttling.
4. **Partition unavailable / EH issue:** rare—regional DR story; pause producers if needed (backpressure contract).
5. **Schema mismatch:** dead-letter or quarantine with **schema version** in envelope.

## 6. Trade-offs and decisions (why X over Y)

| Decision | Chosen | Rejected | Why | Breaks when |
|----------|--------|----------|-----|-------------|
| Ingest | Event Hubs | SB-only | Throughput + replay | Misused as task queue |
| Tasks | Service Bus | EH consumer only | DLQ / sessions | Message size / cost |
| Light compute | Functions | AKS | Speed to ship | Long jobs / cold start |
| Pattern | Event-driven | Sync RPC | Decoupling, burst | Debuggability—need tracing |

## 7. Evolution strategy (MVP → scale → global)

1. **MVP:** EH + one consumer group + Functions + SQL.
2. **10×:** more partitions, SB fan-out, schema governance, autoscale.
3. **Advanced:** Spark/stream analytics, replay pipelines, contract tests between teams.

## 8. Security, observability, and cost

**Security:** **Managed identities** for Event Hubs, Service Bus, Storage; **private endpoints** where required; avoid secrets in Function app settings—Key Vault references.

**Observability:** **Application Insights** + **correlation IDs** on event envelope; consumer **lag** metrics; DLQ depth alerts; end-to-end trace across Functions and SB.

**Cost:** **Event Hubs** throughput/processing units vs peak; **Service Bus** tier; **retention** duration (replay vs storage $); Functions **execution** and **Premium** plan when cold start unacceptable.
