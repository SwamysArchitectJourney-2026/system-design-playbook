# Trade-offs: shipping an LLM feature (IC)

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Sync** vs **async job** | Simple UX | Timeouts under load | Long outputs or heavy retrieval |
| **RAG** vs **prompt-only** | Grounded answers | Index ops, freshness | Small static policy text fits in context |
| **Single model** vs **router** | Less code | Overpays on easy queries | Cost or latency pressure |
| **Strict JSON schema** vs prose | Downstream safety | More failures to handle | Machine-readable integration |
| **Log full prompts** vs hashes | Easier debug | Privacy / retention risk | Regulated or sensitive domains |
