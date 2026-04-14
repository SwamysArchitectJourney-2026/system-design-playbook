# Diagram: payment E2E (Azure)

Azure-specific rendering of the payment flow. Extend in the room — add Private Endpoints on adapter, Managed Identity on Key Vault access, or zone-redundant SQL replicas as depth demands.

Generic component-level diagram (non-Azure): [`../../01_foundations/02_component-model-and-data-flow.md`](../../01_foundations/02_component-model-and-data-flow.md).

```mermaid
---
config:
  theme: mc
  layout: dagre
---
flowchart TD
  classDef clientStyle fill:#EAF4FF,stroke:#9BBCE0,color:#1F3A5F,stroke-width:1px;
  classDef edgeStyle fill:#F3E8FF,stroke:#B9A0D9,color:#4A3568,stroke-width:1px;
  classDef coreStyle fill:#FFF4E6,stroke:#D9B38C,color:#6A4A2F,stroke-width:1px;
  classDef asyncStyle fill:#FDECEF,stroke:#D9A6B0,color:#6A3D47,stroke-width:1px;
  classDef dataStyle fill:#F5F5F5,stroke:#B8B8B8,color:#333333,stroke-width:1px;
  subgraph edge [Azure Edge]
    FD[Azure Front Door\nWAF + CDN + Global LB]
    APIM[APIM\nAuthn / Rate limit / Routing]
  end
  subgraph core [Payment Platform]
    ORCH[Orchestrator\nState machine + Idempotency]
    KV[Key Vault\nToken vault + Signing keys]
    RISK[Risk / Fraud]
    ADAPT[PSP Adapter\nRetry + timeout]
  end
  subgraph data [Data Tier]
    SQL[(Azure SQL\nIntents + Ledger\nstrong consistency)]
    READDB[(Cosmos DB\nRead projections\neventual)]
    BLOB[(Blob Storage\nReceipts / Audit logs)]
  end
  subgraph async [Async Tier]
    SB[Service Bus\nCapture / Notify / Recon\nDLQ + sessions]
    NOTIF[Notification svc\nEmail / SMS / Push]
    RECON[Reconciliation jobs\nPSP statements vs ledger]
  end
  CLIENT[Client\nWeb / Mobile]
  PSP[External PSP\nStripe / Adyen / etc.]
  CLIENT --> FD --> APIM --> ORCH
  ORCH --> RISK
  ORCH --> KV
  ORCH --> ADAPT
  ADAPT --> PSP
  PSP --> ADAPT
  ADAPT --> ORCH
  ORCH --> SQL
  SQL --> READDB
  ORCH --> SB
  SB --> NOTIF
  NOTIF --> BLOB
  SB --> RECON
  class CLIENT clientStyle
  class FD,APIM edgeStyle
  class ORCH,KV,RISK,ADAPT coreStyle
  class SQL,READDB,BLOB dataStyle
  class SB,NOTIF,RECON asyncStyle
```

## Azure service decisions at each tier

| Tier | Service | Why over generic |
|------|---------|-----------------|
| Edge | **Front Door** | Global anycast, WAF, CDN for static assets — single entry replaces regional load balancer + CDN stacks |
| API | **APIM** | Managed OAuth2/JWT validation, rate limiting per subscription, API versioning, developer portal |
| Vault | **Key Vault** | Hardware-backed HSM tier for PAN token encryption keys; Managed Identity access — no secrets in config |
| Money path | **Azure SQL** | ACID guarantees for ledger posts; zone-redundant replicas; row-level security for PCI isolation |
| Read path | **Cosmos DB** | Multi-region reads for history/receipts; tunable consistency (session for post-payment UX, eventual for analytics) |
| Async | **Service Bus** | Sessions = per-account ordering for ledger events; DLQ for stuck captures; exactly-once with peek-lock |
| Receipts | **Blob Storage** | Immutable storage tier for audit; lifecycle rules for retention; CDN-served receipts |

## Failure angles specific to this diagram

See [`03_failures.md`](03_failures.md) for scenario-by-scenario Azure breakdown (Key Vault degradation, Service Bus DLQ, regional failover dual-capture risk).
