---
learning_level: "Beginner"
prerequisites: ["Understanding of basic client-server systems", "Familiarity with HTTP/JSON"]
estimated_time: "25 minutes"
learning_objectives:
  - "Choose between SQL and NoSQL based on access patterns"
  - "Compare vertical scaling vs horizontal scaling"
  - "Explain common bottlenecks and evaluation-ready next steps"
related_topics:
  prerequisites: []
  builds_upon:
    - ./07_scaling-fundamentals-part1.md
  enables:
    - ../04_principles/03_scalability.md
    - ../07_case-studies/01-scalefromzerotomillonusers/README.md
  cross_refs:
    - ../05_building-blocks/03_databases-part1.md
    - ../05_building-blocks/03_databases-part2.md
    - ../05_building-blocks/02_load-balancers.md
---

# Scaling Fundamentals (Part 2): Database Choices and Scaling Strategies

Once you’ve separated tiers, scaling becomes a sequence of decisions driven by your workload (reads vs writes, latency targets, data shape, and failure tolerance).

## Choosing a database (evaluation framing)

Think in terms of constraints and access patterns, not brand names.

### SQL (relational)

- Best when relationships and transactions matter.
- Useful for joins, constraints, and strong consistency semantics.

### NoSQL (non-relational)

- Best when you need flexible schemas and straightforward horizontal scaling.
- Often optimized for high throughput and predictable access patterns.

Common NoSQL categories:

- Key-value
- Document
- Column-family
- Graph

Quick heuristic:

| Need | Lean towards |
| ---- | ----------- |
| Multi-row transactions, constraints, joins | SQL |
| Flexible schema, massive scale, simple queries | NoSQL |
| Ultra-low latency reads, predictable keys | KV/Cache + DB |

## Scaling up vs scaling out

### Vertical scaling (scale up)

Add CPU/RAM/disk to a single machine.

- Pros: simple, minimal architecture change.
- Cons: hard limits, expensive at the top end, still a single point of failure.

### Horizontal scaling (scale out)

Add more machines.

- Pros: better availability and capacity; you can keep adding nodes.
- Cons: requires coordination (load balancing, statelessness, data partitioning).

In evaluations, horizontal scaling is the default path for large systems.

## Bottlenecks of a single web server

- If the box dies, your system is down.
- Traffic spikes push latency up and can lead to request drops.
- Maintenance (deploys, upgrades) often becomes downtime.

## A practical evolution checklist

When asked to “scale from zero to millions”, you can answer with this pattern:

1. Start with a simple baseline and a clear request flow.
2. Identify the first bottleneck (compute, DB, network, disk).
3. Propose the next smallest change that removes that bottleneck.
4. Add reliability (redundancy, health checks) alongside capacity.
5. State trade-offs (cost vs complexity, consistency vs availability).

---

*Next: Deepen this with [Scalability Principles](../04_principles/03_scalability.md) and the [Scale from Zero to Million Users](../07_case-studies/01-scalefromzerotomillonusers/README.md) case study.*
