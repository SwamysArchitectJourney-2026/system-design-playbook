# Diagram: Azure data platform

```mermaid
flowchart LR
  S[Sources]
  L[Bronze ADLS]
  T[Spark transform]
  G[Gold ADLS]
  P[Power BI / SQL serve]
  S --> L
  L --> T
  T --> G
  G --> P
```
