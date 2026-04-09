---
learning_level: "Advanced"
estimated_time: "5 minutes"
---

# Diagrams: multi-region API on Azure

## Narration (interview order)

1. **Global entry:** **Front Door** picks region by health/latency policy.
2. **Per region:** **API Management** enforces OAuth, quotas, policies.
3. **Compute:** **App Service** / **AKS** / **Container Apps** serves APIs locally.
4. **Data:** Regional or replicated store (**Cosmos** multi-region or **SQL** failover)—state consistency model aloud.

```mermaid
flowchart TB
  FD[Azure Front Door]
  subgraph r1 [Region West Europe]
    APIM1[API Management]
    API1[AKS or App Service]
    DB1[(Regional data)]
  end
  subgraph r2 [Region North Europe]
    APIM2[API Management]
    API2[AKS or App Service]
    DB2[(Regional or replicated)]
  end
  FD --> APIM1
  FD --> APIM2
  APIM1 --> API1
  APIM2 --> API2
  API1 --> DB1
  API2 --> DB2
  DB1 -.replication.-> DB2
```
