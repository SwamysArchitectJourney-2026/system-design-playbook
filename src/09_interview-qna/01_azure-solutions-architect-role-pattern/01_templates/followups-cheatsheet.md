---
learning_level: "Advanced"
estimated_time: "12 minutes"
---

# Follow-ups cheat sheet (Azure interviews)

Memorize **mechanisms**, not slogans. Cross-check with `../../interview-execution/02_follow-up-grill-layer.md`.

## Availability & regions

- What happens if a **region** fails? (Traffic Manager / Front Door routing, health probes, data failover RPO/RTO.)
- What if **one AZ** fails within a region? (Zonal redundancy, load spread.)
- How do you avoid **split-brain** during failover?

## Data

- **Partition key** for Cosmos (or sharding key for SQL): hot partitions, fan-out queries.
- **Consistency level** for Cosmos vs user-visible behavior.
- **Replication lag**: what does the user see after a write?

## Scale

- What breaks at **10×** RPS? (DB connections, cache miss storm, APIM throttling, downstream quotas.)
- How do you **throttle** fairly per tenant?

## Messaging / async

- **At-least-once** delivery and duplicate handling (idempotent consumers, dedupe keys).
- **DLQ** policy: when to replay vs quarantine.
- **Ordering**: per-partition only—where is that insufficient?

## Security

- **Private endpoints**, **managed identities**, secret rotation, **WAF** at edge.
- **Tenant isolation** in multi-tenant APIs.

## Observability

- **SLOs**, burn rate, distributed tracing across **Functions** / **AKS** / **Service Bus**.
- How you detect **silent data drift** between regions.

## Cost

- Biggest **monthly bill** drivers for this design and one concrete optimization.
