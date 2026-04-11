---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "Application portfolio modernization roadmap"
---

# Modernize an enterprise application portfolio (roadmap + architecture)

## Clarify

- Business drivers (cost, risk, speed to market); **regulatory** deadlines; **critical** systems list; **skill** constraints.

## Frame (no fake precision)

- **Application inventory:** ~N systems (order of magnitude), **tier** by business criticality.
- **Technical debt** signals: unsupported stacks, single points of failure, manual deploys.

## Target architecture principles

- **API-first** integration; **domain-aligned** capabilities; **zero trust** networking; **observable** by default.
- **Cloud landing zone** (subscriptions, policies, connectivity); **hybrid** if required.

## Phased roadmap

1. **Foundation:** identity, networking, CI/CD golden path, observability baseline.
2. **Quick wins:** retire obvious duplicates, **SaaS** replace where fit, **containerize** stateless edges.
3. **Core modernization:** strangler around monoliths; **data** migration plans with **dual-write** or batch sync where needed.
4. **GenAI** (if in scope): **approved** use cases, **data classification**, **platform** inference with guardrails—not one-off shadow IT.

## Deep dives (pick 2)

- **Data gravity**—which systems block others.
- **Vendor** contracts and **exit** strategy.
- **Org change**—platform team + enabling guilds.

## Risks

- Big-bang cutover; **under-tested** integrations; **skill** gaps on new stack.

## Metrics

- Lead time, deployment frequency, MTTR, cost per business capability, incident rate post-migration.

See `diagram.md`, `tradeoffs.md`, `followups.md`.
