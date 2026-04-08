---
learning_level: "Advanced"
estimated_time: "5 minutes"
---

# Diagrams: global HA web app on Azure

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

ASCII fallback:

```text
Client -> Front Door -> APIM -> API -> Redis -> DB
                              \-> Blob
```
