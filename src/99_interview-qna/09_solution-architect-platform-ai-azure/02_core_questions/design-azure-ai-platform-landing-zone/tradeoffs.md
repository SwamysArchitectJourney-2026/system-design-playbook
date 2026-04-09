# Trade-offs: Platform AI on Azure

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Single AI subscription** | Simple billing | Noisy neighbor, RBAC mess | Split by BU or env at scale |
| **Private Link everywhere** | Security narrative | Slower onboarding, DNS ops | Regulated prod only first |
| **Foundry-first** vs **raw OpenAI** RGs | Governance UX | Learning curve | Standardize when many teams |
| **Databricks + AML** | Right tool per workload | Cost + skill split | Pick one dominant if team small |
| **GitOps** vs **push CD** | Drift control | Complexity | Mature platform teams |
