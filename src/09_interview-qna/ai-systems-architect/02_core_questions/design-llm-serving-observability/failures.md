# Failure scenarios: LLM serving and observability

- **GPU / replica saturation** — **queue** depth grows; **SLO** miss; need **autoscale** and **admission** control.
- **Bad deploy** (weights, tokenizer) — **silent** quality drop; **offline** eval + **canary** traffic split.
- **Tracing overhead** — high-cardinality **prompt** tags blow up costs; **sample** and **hash** prompts.
- **Cold start** on serverless GPU — **p99** spikes; **warm pools** or **min replicas**.
- **Data drift** in features feeding router — wrong **model** selected; **monitor** business KPIs tied to model choice.
- **Observability without action** — dashboards exist but **no** alerts tied to **latency**, **error budget**, **cost** per request.
