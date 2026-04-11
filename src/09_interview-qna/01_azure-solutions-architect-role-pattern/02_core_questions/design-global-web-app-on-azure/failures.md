---
learning_level: "Advanced"
estimated_time: "15 minutes"
---

# Failure scenarios: global HA web app on Azure

Expand `answer.md` §5 during drills. Catalog: `../../01_templates/failure-scenario-catalog.md`. Instant recall: `../../09_interview-failure-playbook.md`.

## Region and edge

| Scenario | Detection | Mitigation | User-visible |
|----------|-----------|------------|--------------|
| Primary region unavailable | Front Door health, origin 5xx | Route to secondary origin; data failover per RTO | Brief errors or read-only if data not ready |
| False healthy origin | Errors while probe green | Deep health + synthetic transactions | Flaky UX—fix probes first |
| AZ failure | Zonal metrics | Zonal redundancy on App Service / spread pods | Retry storm—backoff |

## Data (Cosmos or SQL)

| Scenario | Detection | Mitigation | User-visible |
|----------|-----------|------------|--------------|
| Cosmos **429** throttling | Cosmos metrics, latency | Backoff, autoscale RU, partition fix | Slower writes; optional queued response |
| SQL connection pool exhausted | App errors, DB wait stats | Pool limits, scale compute, kill bad queries | 503 from API |
| Replication lag (read replica) | Stale reads reported | Read-your-writes path; bypass cache on critical read | Stale dashboard until caught up |

## Cache (Redis)

| Scenario | Detection | Mitigation | User-visible |
|----------|-----------|------------|--------------|
| Eviction / memory pressure | Evicted keys metric | TTL, single-flight, tier up | Latency spike to DB |
| Redis failover | Connection errors | Retry; treat cache miss; circuit break DB | Short errors or latency |
| Stampede after cold cache | DB CPU spike | Single-flight; warm keys; gradual rollout | Timeouts if unbounded |

## Gateway and compute

| Scenario | Detection | Mitigation | User-visible |
|----------|-----------|------------|--------------|
| APIM policy CPU / timeout | APIM diagnostics | Simplify policies; scale tier; cache at edge | 502/504 |
| App Service saturation | CPU, queue length | Autoscale; offload to queue | 503 + Retry-After |

## Security-related failures

| Scenario | Detection | Mitigation |
|----------|-----------|------------|
| Key Vault / MI misconfig | Auth errors burst | Fix RBAC; fallback break-glass procedure |
| WAF false positive | Legit traffic blocked | Tune rules; allowlist path |
