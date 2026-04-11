# Diagram: B2B zero-trust integration

```mermaid
flowchart LR
  P[Partners]
  WAF[WAF / Gateway]
  E[Event bus]
  S[Internal services]
  P --> WAF --> S
  WAF --> E --> S
```
