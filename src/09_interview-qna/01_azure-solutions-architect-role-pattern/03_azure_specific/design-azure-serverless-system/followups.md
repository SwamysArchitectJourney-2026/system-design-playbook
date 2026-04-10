# Follow-ups: serverless

- Cold start mitigation (Premium, always-ready instances, warmup)?
- Long-running work over **15 minutes** (move to Container Apps / AKS / Durable)?
- **Connection storms** to SQL under autoscale—use pooling gateway (Hyperscale, PgBouncer pattern) or throttle concurrency per instance.
- How do you **version** Functions with zero downtime?
