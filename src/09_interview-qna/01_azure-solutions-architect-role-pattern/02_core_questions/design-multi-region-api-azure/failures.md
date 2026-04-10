# Failure scenarios: multi-region API on Azure

## Edge and routing

| Scenario | Mitigation |
|----------|------------|
| One region origins unhealthy | Front Door shifts; verify data readiness in survivor |
| Asymmetric config between regions | IaC + staged promotion; config drift tests |
| False healthy | Synthetic canaries on critical APIs |

## APIM

| Scenario | Mitigation |
|----------|------------|
| Policy CPU saturation | Simplify policies; scale tier; split APIs |
| Token validation latency | JWKS cache tuning; regional JWKS copy where safe |

## Data

| Scenario | Mitigation |
|----------|------------|
| Cross-region write conflict | Home-region writes, etags, or CRDT—pick one explicitly |
| Cosmos 429 | RU autoscale; partition fix |
| SQL failover RPO | Failover groups; practice RTO |

## Tenant / abuse

| Scenario | Mitigation |
|----------|------------|
| Noisy neighbor on shared gateway | Per-tenant quotas; bulkhead backends |
