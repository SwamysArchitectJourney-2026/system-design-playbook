# Failure scenarios: LLMOps platform

- **Promotion without eval** — quality regression; **mandate** gated pipelines and **rollback**.
- **Canary too small or too short** — rare failure modes undetected; **SLO** on canary duration and sample size.
- **Data leakage across tenants** — wrong **ACL** on index or fine-tune data; **audit** and **isolation** tests.
- **GPU node loss mid-training** — checkpointing and **resumable** jobs; idempotent **artifact** writes.
- **Cost spike** — misconfigured **max tokens** or routing; **budgets** and **alerts** per tenant.
- **Governance bypass** — direct API key to vendor skipping **registry**; **network** and **key** policy enforcement.
