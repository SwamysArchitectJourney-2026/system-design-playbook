---
learning_level: "Advanced"
estimated_time: "20 minutes"
---

# Follow-up attack bank (categorized)

Use to structure every `followups.md`: copy relevant bullets into the question file and **write your answer** in your own words. Prefer **“… attacks”** headings (Template v1.1) for faster recall under pressure.

## Scalability attacks

- What breaks first at **10×** traffic?
- What metric do you watch in the **first 60 seconds** of an incident?
- **Autoscale** lag—how do you still meet SLO?
- **Hot tenant** or **hot key**—detection and mitigation?

## Failure and resilience attacks

- **Region** down—RPO/RTO and user experience?
- **Dependency** slow (not down)—timeouts, hedging, bulkhead?
- **Cache** cold after deploy or failover?
- **Thundering herd** after incident—how do you prevent it?

## Data consistency attacks

- **Read after write**—why might user see stale data?
- **Idempotency** on retries—where is the key stored?
- **Ordering**—global vs per-partition?
- **Exactly-once**—do you claim it? If not, what semantics?

## Messaging / async attacks

- **Duplicate** messages—safe or not?
- **DLQ** policy—when to replay vs discard?
- **Backpressure**—producer faster than consumer?

## Security attacks

- **AuthN vs AuthZ** boundary—where enforced?
- **Managed identity** path from compute to data?
- **Private endpoints**—what still must be public?
- **Secrets** rotation without downtime?

## Cost attacks

- Biggest **monthly** driver in this design?
- **Reserved** vs **pay-as-you-go** trade-off?
- **Cosmos RU** or **Redis tier** mistake you’d avoid?

## Azure depth attacks

- **Event Hubs vs Service Bus** for this workload?
- **Cosmos partition key**—what if wrong?
- **AKS vs App Service**—why here?

## Evolution attacks

- What do you **not** build in **MVP**?
- What changes at **global** scale that you ignored earlier?
