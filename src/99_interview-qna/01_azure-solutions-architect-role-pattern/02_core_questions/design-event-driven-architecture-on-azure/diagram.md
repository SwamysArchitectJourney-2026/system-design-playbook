---
learning_level: "Advanced"
estimated_time: "5 minutes"
---

# Diagrams: event-driven architecture on Azure

## Narration (interview order)

1. **Produce:** Services publish to **Event Hubs** (partitioned stream, replay).
2. **Process:** **Functions** or **AKS** consumers read partitions; checkpoint offsets.
3. **Hand off:** Optional **Service Bus** for per-task work, **DLQ**, sessions.
4. **Persist:** **Operational DB** for state; **Data Lake** for analytics / replay-derived loads.

```mermaid
flowchart LR
  P[Producers]
  EH[Azure Event Hubs]
  F[Functions or AKS consumers]
  SB[Service Bus optional]
  W[Workers]
  DB[(Operational DB)]
  L[Data Lake Gen2]
  P --> EH
  EH --> F
  F --> SB
  SB --> W
  F --> DB
  W --> DB
  F --> L
```

**ASCII**

```text
Producer -> Event Hubs -> Consumer -> (Service Bus) -> Worker -> DB
                        \-> Data Lake (analytics path)
```
