# Diagram: MCP gateway

```mermaid
flowchart LR
  A[Agent / client]
  GW[MCP gateway]
  R[Tool registry]
  T1[Tool server A]
  T2[Tool server B]
  A --> GW
  GW --> R
  GW --> T1
  GW --> T2
```
