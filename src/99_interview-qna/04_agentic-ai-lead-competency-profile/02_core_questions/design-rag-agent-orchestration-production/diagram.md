# Diagram: RAG + agent

```mermaid
flowchart LR
  U[User]
  G[Gateway]
  O[Orchestrator]
  L[LLM]
  V[Vector index]
  T[Tools / MCP]
  U --> G --> O
  O --> L
  O --> V
  O --> T
```
