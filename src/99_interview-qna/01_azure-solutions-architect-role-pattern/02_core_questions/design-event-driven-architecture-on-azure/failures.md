# Failure scenarios: event-driven on Azure

Catalog: `../../01_templates/failure-scenario-catalog.md`. Playbook: `../../09_interview-failure-playbook.md`.

## Event Hubs

| Scenario | Mitigation |
|----------|------------|
| Hot partition | Fix partition key; scale processing units / EH cluster |
| Consumer lag | Scale processors; fix slow handler; check DB 429 |
| Throughput unit exhaustion | Autoscale / increase capacity; throttle producers if contract allows |

## Service Bus

| Scenario | Mitigation |
|----------|------------|
| Queue backlog | Scale workers; find bottleneck; DLQ growth alert |
| Poison message | DLQ; fix; controlled replay with idempotency |
| Message size too large | **Claim check** pattern to Blob |
| Throttling | Premium tier, batching, split topics |

## Functions / consumers

| Scenario | Mitigation |
|----------|------------|
| Duplicate processing | Idempotency store by event ID / business key |
| Cold start latency | Premium plan; min instances |
| Checkpoint failure | At-least-once semantics; safe retries |

## Schema / ops

| Scenario | Mitigation |
|----------|------------|
| Breaking schema change | Compatibility mode; quarantine bad events |
| Replay storm | Rate-limit replay job; idempotent sinks |
