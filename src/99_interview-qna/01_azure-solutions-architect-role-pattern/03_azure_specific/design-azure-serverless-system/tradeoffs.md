# Trade-offs: serverless on Azure

- **Consumption** — cheap burst, cold start risk.
- **Premium** — predictable latency, VNET, higher floor cost.
- **Durable Functions** — great orchestration; operational complexity and history store sizing.
- **Monolithic Function app** — simple deploy; noisy neighbor inside app; prefer split by domain at scale.
