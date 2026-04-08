---
learning_level: "Advanced"
estimated_time: "10 minutes"
---

# Follow-ups: multi-region API

**Q: How do you handle JWT validation in each region?**

- JWKS caching, clock skew, key rotation; APIM or API validates signature; short-lived access tokens.

**Q: APIM config drift between regions?**

- **Infrastructure as code**, automated promotion, canary in one region first.

**Q: Cross-region write conflict?**

- Last-write-wins only if business accepts; otherwise **optimistic concurrency** (`etag`), or **home region** write model.

**Q: GDPR / data residency?**

- Route and **store** data in allowed regions; avoid accidental replication across borders; DLP on logs.

**Q: What metric proves multi-region is working?**

- Regional error budget, P99 latency by geography, successful failover drill outcomes.
