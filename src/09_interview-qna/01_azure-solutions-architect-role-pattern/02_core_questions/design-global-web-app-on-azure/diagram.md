---
learning_level: "Advanced"
estimated_time: "8 minutes"
---

# Diagrams: global HA web app on Azure

## Narration (use this order in the interview)

1. **Entry:** User hits **Azure Front Door** (TLS, WAF, routing to nearest healthy origin).
2. **Gateway:** Traffic hits **API Management** for auth, quotas, and optional caching.
3. **Compute:** **App Service** (or AKS) runs stateless APIs.
4. **Fast path:** **Redis** for hot reads; on miss, **Cosmos DB** or **Azure SQL**.
5. **Media:** Large objects to **Blob Storage** (not through DB).

## Request flow (read path)

```mermaid
flowchart LR
  subgraph clients [Clients]
    W[Web]
    M[Mobile]
  end
  subgraph edge [Edge]
    FD[Azure Front Door]
    CDN[CDN]
  end
  subgraph compute [Compute]
    APIM[API Management]
    API[App Service or AKS APIs]
  end
  subgraph data [Data]
    R[Azure Redis]
    C[(Cosmos DB or Azure SQL)]
    B[Blob Storage]
  end
  W --> FD
  M --> FD
  FD --> CDN
  FD --> APIM
  APIM --> API
  API --> R
  R -->|miss| C
  API --> B
```

## Multi-region (evolution)

```mermaid
flowchart TB
  FD[Front Door]
  FD --> R1[Region A - Primary]
  FD --> R2[Region B - Secondary or active]
  R1 --> C1[(Cosmos / SQL)]
  R2 --> C2[(Replica / secondary region)]
  C1 -.geo replication.-> C2
```

**ASCII**

```text
Client -> Front Door -> APIM -> API -> Redis -> DB
                              \-> Blob
```
