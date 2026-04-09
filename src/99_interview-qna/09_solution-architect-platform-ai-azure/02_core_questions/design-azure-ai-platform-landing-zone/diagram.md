# Diagram: Azure AI platform landing zone

```mermaid
flowchart TB
  subgraph mgmt [Management groups]
    M[Policies and budgets]
  end
  subgraph hub [Hub subscription]
    FW[Azure Firewall / DNS]
    APIM[API Management]
  end
  subgraph spoke [Spoke subscription — AI workload]
    AKS[AKS optional]
    AOAI[Azure OpenAI]
    AIS[Azure AI Search]
    AML[Azure Machine Learning]
    FP[AI Foundry project boundary]
    ST[Storage private endpoints]
  end
  subgraph data [Data plane optional]
    DB[Databricks / Lake]
  end
  M --> hub
  FW --> spoke
  APIM --> AKS
  APIM --> AOAI
  AKS --> AIS
  FP --> AOAI
  FP --> AIS
  AML --> ST
  ST --> DB
```

## Narration walkthrough

1. **Management groups** push **Azure Policy**, tags, and **Defender** baselines.
2. **Hub** provides **shared** egress, **DNS**, and optional **APIM** / **Front Door** entry.
3. **Spoke** hosts **AI** resources in a **project** or **RG** boundary with **Private Link** to PaaS where required.
4. **AML** and **storage** feed **training**; **optional Databricks** extends **lakehouse** and **Spark** analytics with governance story.
5. **GitOps / IaC** owns drift; **identity** is **workload-based** into **Key Vault** and **Azure RBAC**.
