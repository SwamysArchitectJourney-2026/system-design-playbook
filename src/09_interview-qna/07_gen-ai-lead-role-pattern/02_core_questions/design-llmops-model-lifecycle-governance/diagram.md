# Diagram: LLMOps lifecycle and governance

```mermaid
flowchart TB
  subgraph ingest [Data and prompts]
    D[Curated datasets]
    P[Prompt / adapter configs]
  end
  subgraph build [Build]
    T[Training or adaptation jobs]
    E[Offline evaluation]
  end
  R[Model registry]
  subgraph deploy [Deploy]
    C[Canary router]
    S[Serving tier]
  end
  subgraph ops [Operate]
    M[Metrics and cost]
    G[Governance and audit]
  end
  D --> T
  P --> T
  T --> E
  E --> R
  R --> C
  C --> S
  S --> M
  S --> G
```

## Narration walkthrough

1. **Inputs:** Approved **datasets** and **configs** feed training or **adapter** jobs (not ad-hoc laptops for prod).
2. **Build:** Jobs write **versioned** artifacts; **offline eval** must pass before registry promotion.
3. **Registry:** Single source of truth for **which artifact** is **candidate** vs **production** and **who signed off**.
4. **Deploy:** **Canary** sends a slice of traffic to the new version; **rollback** is a routing change.
5. **Operate:** **Metrics** (latency, errors, cost, quality proxies) and **governance** (policy, audit) close the loop.
