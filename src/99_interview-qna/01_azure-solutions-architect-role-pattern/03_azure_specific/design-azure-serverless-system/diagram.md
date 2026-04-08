# Diagram: Azure serverless

```mermaid
flowchart LR
  APIM[API Management]
  FH[HTTP Functions]
  Q[Service Bus Queue]
  FC[Queue-trigger Functions]
  DB[(SQL or Cosmos)]
  APIM --> FH
  FH --> Q
  Q --> FC
  FC --> DB
```
