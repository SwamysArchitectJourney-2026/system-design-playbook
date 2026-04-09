# Trade-offs: LLMOps platform

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Central platform** vs team silos | Consistent governance, shared GPU pool | Slower self-service for experts | Mature org with many teams |
| **Hosted LLM APIs** vs **self-host** | Less ops, fast start | Cost at scale, less control | Air-gap, custom weights, cost breakeven |
| **Adapters / LoRA** vs **full fine-tunes** | Cheaper iteration, smaller artifacts | Not always enough capacity | Domain shift is moderate |
| **Strong offline eval only** vs **online experimentation** | Safer gate | Misses real user distribution | Low traffic or high risk—add shadow |
| **Tight approval** vs **developer velocity** | Compliance | Innovation slows | Clear risk tiers: fast path for low risk |
