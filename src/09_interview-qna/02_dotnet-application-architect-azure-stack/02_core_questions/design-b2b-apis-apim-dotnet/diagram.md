# Diagram: B2B APIs .NET

```mermaid
flowchart LR
  P[Partners]
  APIM[Azure API Management]
  API[ASP.NET Core APIs]
  SB[Service Bus]
  DB[(Azure SQL)]
  P --> APIM --> API --> DB
  API --> SB
  SB --> P
```
