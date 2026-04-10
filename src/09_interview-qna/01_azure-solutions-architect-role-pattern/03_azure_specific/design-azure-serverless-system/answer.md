---
learning_level: "Advanced"
estimated_time: "30 minutes"
topic: "Serverless system on Azure"
---

# Design a serverless system on Azure (Functions-first)

## Based on Template v1.1

Companion: `failures.md`, `diagram.md`, `tradeoffs.md`, `followups.md`, `../../01_templates/service-selection-guide.md`.

## 1. Clarify requirements

- **Triggers:** HTTP, queue, timer, Event Hubs, blob; sync vs async UX.
- **Latency SLO:** if **strict cold-start** budget, Consumption may be wrong default.
- **Network:** VNET integration, private SQL/Service Bus, hybrid connectivity.
- **Stateful workflows:** **Durable Functions** vs external orchestrator vs saga in Service Bus.
- **Compliance:** PII in payloads, data residency, audit of executions.

## 2. Scale estimation (back-of-envelope)

- Invocations/day, **concurrent executions**, p99 duration, payload sizes.
- Downstream **DB RPS** and pool limits; **Service Bus** messages/sec; **Event Hubs** partitions if streaming.

## 3. High-level architecture

- **API path:** **API Management** → **HTTP Functions** (or App Service if team avoids Functions for core CRUD).
- **Async path:** **Service Bus** queue/topic → **Functions** consumers; **Storage Queues** only if cost/feature trade acceptable.
- **Orchestration:** **Durable Functions** for long workflows; **Functions** activity functions as workers.
- **Data:** **Cosmos** or **SQL** with connection discipline; **Blob** + **claim-check** for large messages.
- **Identity:** **managed identities** to Key Vault, Service Bus, SQL, storage—no secrets in app settings where avoidable.

### 3.1 Decision: Consumption vs Premium vs Dedicated

- **Chosen: Consumption** for spiky, cost-sensitive, tolerant of cold start.
- **Chosen: Premium** when **VNET**, **min instances**, or predictable latency matters.
- **Rejected: Consumption for sub-second always** — cold start and scale lag break the story.

### 3.2 Decision: Service Bus vs Storage Queues

- **Chosen: Service Bus** for **DLQ**, sessions, duplicate detection, enterprise patterns.
- **Rejected: Storage Queues** when you need rich **dead-letter** workflows and per-message TTL semantics at scale (team-dependent).

## 4. Deep dives (pick 2–3 in the room)

- **Plan choice** and **always-ready** / min instances for critical paths.
- **Idempotency** and **retry** storms on poison messages.
- **Partition count** (EH) vs **Service Bus** throughput units and message size limits → **claim-check** pattern.

## 5. Failure scenarios and mitigations

1. **Poison message** → **DLQ**, alert, replay with controls after fix.
2. **Downstream DB unavailable** → backoff, circuit break, shed load at APIM.
3. **Duplicate delivery** → idempotent handlers keyed by message id / business key.
4. **Durable orchestration stuck** → monitoring, manual restart with **deterministic** replay awareness.
5. **Quota / regional limit** → split Function apps by blast radius; second subscription only as last resort.

(See `failures.md`.)

## 6. What breaks first?

1. **SQL connection pool** or **Cosmos 429** under bursty parallel Function scale-out.
2. **Service Bus** throttling or **oversized messages** without claim-check.
3. **APIM + Function** chain under **retry amplification** from a bad downstream.
4. **Cold start** on Consumption if traffic pattern is **step** not smooth.
5. **Operational visibility** — missing per-execution **correlation** → cannot debug “flaky” serverless.

## 7. Key design decisions

| Area | Chosen | Rejected | Because |
|------|--------|----------|---------|
| Async broker | **Service Bus** | Storage Queue | DLQ, sessions, enterprise semantics |
| Latency-sensitive | **Premium Functions** | Consumption | Cold start + VNET |
| Large payloads | **Blob claim-check** | big SB messages | Size limits + cost |
| Long workflows | **Durable Functions** | ad-hoc timers | State + replay model |

## 8. Trade-offs summary

- **More granularity (many apps)** → ops overhead; **fewer apps** → blast radius and noisy neighbor.
- **Pure serverless** vs **hybrid** App Service for stable APIs — flip when cold start and limits hurt SLOs.

## 9. Evolution strategy (MVP → scale → global)

- **MVP:** one Function app + Service Bus + SQL + APIM; baseline dashboards.
- **10×:** split apps, Premium plan on hot paths, partition tuning, DLQ runbooks.
- **Global:** multi-region **read** APIs; async **regional** namespaces; central observability; data residency per region.

## 10. Security architecture

**Entra ID** at APIM; **managed identities**; **Key Vault** references; **private endpoints** to data plane when required; least privilege on triggers.

## 11. Observability and operations

**Application Insights** + **live metrics**; **correlation** from APIM through Function to downstream; alerts on **DLQ depth**, error rate, duration p99.

## 12. Cost considerations

Consumption **per execution** vs Premium **fixed** cost breakeven; Service Bus **tier**; **EH** if present; log **ingestion** volume; minimize redundant serializations in hot paths.
