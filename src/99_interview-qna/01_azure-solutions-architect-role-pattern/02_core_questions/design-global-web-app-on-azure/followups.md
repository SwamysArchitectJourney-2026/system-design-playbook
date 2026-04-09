---
learning_level: "Advanced"
estimated_time: "20 minutes"
---

# Follow-ups: global HA web app on Azure

Bank of patterns: `../../01_templates/followup-attack-bank.md`.

## Scalability and load

**Q: What breaks at 10× RPS?**

- DB connection pools, APIM throttles, Redis CPU, downstream SaaS quotas; autoscale lag—name **which metric** you open first.

**Q: Traffic spikes 10× for 10 minutes—what throttles first?**

- Often **APIM 429** or **Cosmos 429** before App Service CPU; confirm with dashboards.

## Failure and resilience

**Q: Region A dies—what happens?**

- Front Door routes away; data RPO from Cosmos/SQL story; cache cold—mitigate with single-flight.

**Q: How do you test failover?**

- Chaos / game days; synthetic probes; documented drill with rollback.

**Q: Front Door shows healthy but users fail?**

- Shallow probe vs deep probe; add **synthetic transactions**.

## Data consistency

**Q: How do you pick a Cosmos partition key?**

- Avoid hot tenants; often `userId`; cross-partition query cost.

**Q: User just wrote; why stale read?**

- Replica lag or Redis; **read-your-writes** strategy (bypass cache, version check, sticky to primary for that read).

**Q: Client retries POST—double resource?**

- **Idempotency-Key** on mutating APIs.

## Security

**Q: How do APIs call the database?**

- **Managed identity**; no connection strings in code; **private endpoints** where required.

**Q: Where is WAF?**

- **Front Door** (or regional App Gateway if that’s the chosen pattern—stay consistent with `answer.md`).

## Cost

**Q: Biggest bill and one fix?**

- Often Cosmos RU or over-provisioned compute; autoscale RU, cache reads, **reserved** instances for steady APIM/App Service.

## Azure depth

**Q: Cosmos vs SQL here—defend in one sentence.**

- Global write latency + elastic partitions vs relational transactions—tie to clarified requirements.

**Q: Why Front Door over Traffic Manager only?**

- Need L7 + WAF + path routing; TM alone is DNS-level only.
