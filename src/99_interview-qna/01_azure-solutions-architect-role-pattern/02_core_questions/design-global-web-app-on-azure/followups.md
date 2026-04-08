---
learning_level: "Advanced"
estimated_time: "15 minutes"
---

# Follow-ups: global HA web app on Azure

## Availability

**Q: Region A dies—what happens?**

- Front Door stops routing to unhealthy origins; traffic fails over to region B; data RPO depends on Cosmos/SQL replication (state RTO/RPO explicitly). Runbooks for DNS/cache flush if needed.

**Q: How do you test failover?**

- Chaos / game days; synthetic probes; documented failover drill with rollback.

## Data

**Q: How do you pick a Cosmos partition key?**

- Avoid hot tenants; for user-owned data often `userId`; call out cross-partition query cost and pagination.

**Q: User just wrote; why do they see stale data?**

- Read replica lag or Redis TTL; define **read-your-writes** strategy (sticky to primary, or bypass cache briefly, or version check).

## Scale

**Q: What breaks at 10× RPS?**

- DB connection pools, APIM throttles, Redis CPU, downstream SaaS quotas; autoscale lag—answer with **which meter** you watch first.

## Security

**Q: How do APIs call the database?**

- Managed identity, no connection strings in code; private endpoints where policy requires.

## Cost

**Q: Biggest bill and one fix?**

- Often Cosmos RU or over-provisioned compute; autoscale RU, cache more read-heavy paths, reserved instances for steady APIM/App Service.
