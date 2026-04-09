---
learning_level: "Advanced"
estimated_time: "25 minutes"
---

# Failure scenario catalog (Azure + distributed systems)

Use to build **question-specific** `failures.md` files. Pair each scenario with **detection** + **mitigation** + **user-visible behavior**.

## Region and zone

- **Region loss** — Front Door / TM routes away; data RPO/RTO; runbook for cache cold in survivor region.
- **AZ failure within region** — zonal redundancy; PDBs on AKS; App Service zone redundancy.
- **Split-brain writes** — two regions both accepting writes without conflict model—avoid or use home-region routing.

## Data plane

- **Cosmos DB throttling (429)** — RU autoscale, partition key fix, backoff, shed load, cache read-heavy paths.
- **SQL connection exhaustion** — pool sizing, read replicas, gateway, kill runaway queries.
- **Replication lag** — stale reads after write; read-your-writes strategy; don’t claim “strong” globally without mechanism.
- **Hot partition / hot key** — skewed traffic; resharding, salting keys, rate limit per key.

## Cache

- **Redis failover** — treat as non-authoritative; brief errors; client retry; session loss if not replicated.
- **Eviction under memory pressure** — thundering herd on DB; single-flight; TTL discipline.
- **Cache stampede** — lock or probabilitistic early refresh; warm critical keys after deploy.

## Messaging

- **Queue backlog** — scale consumers; find slow downstream; DLQ growth alert.
- **Poison message** — DLQ; inspect; fix; controlled replay with idempotency.
- **Duplicate delivery** — at-least-once; idempotent consumers; dedupe store.
- **Ordering gap** — partition reassignment; design for per-partition order only.

## Edge and API

- **False healthy probe** — deep health; synthetic transactions; SLO on golden path.
- **APIM / gateway overload** — 429 + Retry-After; shed optional traffic; autoscale policy units.
- **DDoS / abuse** — WAF, rate limits, tenant quotas, bot management.

## Cost / ops surprises

- **Autoscale lag** — traffic spike wins before scale-out; over-provision min instances for SLO.
- **Egress bill** — cross-region chatter; topology fix; cache and CDN.

## Security failures

- **Credential leak** — Key Vault rotation; disable MI compromise path; audit.
- **Private endpoint misconfig** — accidental public exposure—policy + scanning.
