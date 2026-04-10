# Diagram: AI on Azure

```mermaid
flowchart LR
  C[Client]
  FD[Front Door]
  APIM[API Management]
  ORCH[Orchestrator API]
  OAI[Azure OpenAI]
  S[AI Search]
  R[Redis cache]
  B[Blob docs]
  C --> FD --> APIM --> ORCH
  ORCH --> R
  ORCH --> S
  ORCH --> OAI
  S --> B
```
