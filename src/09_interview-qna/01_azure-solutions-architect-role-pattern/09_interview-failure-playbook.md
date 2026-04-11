---
learning_level: "Advanced"
estimated_time: "10 minutes"
---

# Interview failure playbook (instant recall)

**If** Cosmos returns **429** → backoff + jitter; raise RU / autoscale; fix hot partition; temporarily serve stale reads only if product allows.

**If** **Redis** is down or evicting → bypass cache to origin; degrade latency SLO; protect DB with concurrency limits + circuit breaker.

**If** **queue backlog** grows → scale consumers; check DB/processor bottleneck; pause producers if contract allows.

**If** **poison message** → DLQ; alert; fix schema/handler; replay from DLQ with idempotency.

**If** **region** fails → Front Door shifts; execute data failover runbook; expect cache miss storm—single-flight.

**If** **Front Door** shows healthy but users fail → synthetic canary; compare shallow vs deep health.

**If** **Event Hubs** consumer lags → add partitions / scale processing units; fix slow handler; check downstream 429.

**If** **Service Bus** throttles → batching, premium tier, partition workloads, claim-check large payloads.

Details and Azure context: `01_templates/failure-scenario-catalog.md` and per-question `failures.md`.
