# Diagram: LLM serving

```mermaid
flowchart LR
  C[Clients]
  G[Gateway]
  Q[Queue]
  W[Inference workers]
  M[Model / API]
  R[Redis cache]
  C --> G
  G --> R
  G --> Q --> W --> M
```
