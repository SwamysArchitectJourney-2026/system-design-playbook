# Diagram: AKS platform

```mermaid
flowchart TB
  G[Git repo]
  GO[GitOps Argo/Flux]
  AKS[AKS cluster]
  ACR[ACR]
  KV[Key Vault]
  G --> GO --> AKS
  ACR --> AKS
  KV --> AKS
```
