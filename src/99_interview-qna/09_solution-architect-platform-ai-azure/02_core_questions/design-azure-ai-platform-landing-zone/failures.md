# Failure scenarios: Azure AI platform

- **Regional Azure OpenAI** degradation — **failover** region, **cached** responses where safe, **user-visible** degrade mode.
- **Misconfigured Private Link** — silent **timeouts**; **health** probes must hit **real** inference path.
- **Over-privileged** service principal — **blast radius** to all subscriptions; **narrow** RBAC + **PIM**.
- **IaC pipeline** compromise — **signed** modules, **protected** branches, **manual** approval for prod.
- **Databricks / AML** **network** path exposes **data** — **NSG** / **private** workspace + **exfiltration** monitoring.
- **Policy** blocks valid **preview** feature — **exception** process and **time-bounded** exemptions.
