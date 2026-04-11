---
learning_level: "Advanced"
estimated_time: "12 minutes"
---

# Follow-ups: multi-region API

Bank: `../../01_templates/followup-attack-bank.md`.

## Security

**Q: JWT validation in each region?**

- JWKS cache, clock skew, rotation; validate at APIM or API; short-lived tokens.

**Q: GDPR / data residency?**

- Route + store in allowed regions; control replication; DLP on logs.

## Failure and resilience

**Q: Cross-region write conflict?**

- LWW only if acceptable; else **etag** / home-region writes.

**Q: APIM config drift?**

- IaC, automated promotion, canary region first.

## Scalability and load

**Q: What metric proves multi-region health?**

- Error budget per region, P99 by geo, failover drill success.

## Cost

**Q: Hidden cost?**

- Cross-region **egress**; duplicated regional stacks; multi-region Cosmos RU.

## Azure depth

**Q: Stamps per region vs one APIM?**

- Latency + blast radius vs operational complexity—justify.
