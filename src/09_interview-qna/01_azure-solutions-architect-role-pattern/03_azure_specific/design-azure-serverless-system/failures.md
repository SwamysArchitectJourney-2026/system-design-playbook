# Failure scenarios: Azure serverless

- **Function cold start** → Premium plan, min instances, warmup for critical paths.
- **Queue depth backlog** → Scale out; fix slow downstream; DLQ poison messages.
- **SQL connection storm** from scaled Functions → Limit concurrency per instance; pooler/Hyperscale.
- **Durable Functions** history store throttling → Partition management; scale storage.
- **Secret / MI** misconfiguration → Auth spike of failures; fix RBAC and retry.
