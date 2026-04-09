---
learning_level: "Advanced"
estimated_time: "8 minutes"
---

# Trade-offs: multi-region API

## Single global APIM vs regional stamps

| Global / external tier | Regional stamps |
|------------------------|-----------------|
| Simpler config surface | Lower latency to local backends; smaller blast radius |
| May centralize policy risk | More drift without GitOps automation |

## User-partitioned regions vs replicated global data

| Partition users | Global replicated DB |
|-----------------|------------------------|
| Fewer write conflicts | Better perceived latency everywhere |
| Complex routing / travel edge cases | Higher cost and consistency nuance |

## Strong consistency across regions

- Expensive latency; often scope **strong** only to financial or inventory-critical operations; use **eventual** for dashboards and recommendations.
