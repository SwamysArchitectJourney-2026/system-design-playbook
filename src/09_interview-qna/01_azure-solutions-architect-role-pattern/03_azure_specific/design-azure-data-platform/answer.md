---
learning_level: "Advanced"
estimated_time: "30 minutes"
topic: "Azure data platform (analytics + serving)"
---

# Design an Azure data platform for analytics and downstream serving

## Based on Template v1.1

Companion: `failures.md`, `tradeoffs.md`, `followups.md`, `../../01_templates/service-selection-guide.md`.

## 1. Clarify requirements

- **Sources:** OLTP, apps, SaaS, logs, IoT; batch vs near-real-time SLAs.
- **Consumers:** BI, ML features, ops dashboards, reverse-ETL to SaaS.
- **PII / residency:** masking, encryption, region pinning.
- **Freshness:** hourly vs minute vs streaming; **cost** ceiling.

## 2. Scale estimation (back-of-envelope)

- Daily ingest **TB**; **query** concurrency; **retention** years; **replay** need (compliance).

## 3. High-level architecture (medallion-style)

- **Landing / Bronze:** **ADLS Gen2**; **Event Hubs** or **ADF/Synapse pipelines** for ingest.
- **Transform:** Spark (**Synapse**, **Fabric**, or **Databricks**) **Silver → Gold** curated tables.
- **Serving:** **Synapse serverless** or dedicated SQL pool; **Power BI**; optional **Cosmos** / **Redis** for low-latency features.
- **Governance:** **Microsoft Purview** catalog/lineage; RBAC on storage; **private endpoints** where mandated.

### 3.1 Decision: Event Hubs vs ADF-only

- **Chosen: Event Hubs** when **streaming** or high-volume **CDC-style** events are first-class.
- **Chosen: ADF/pipelines-only** when batch file drops dominate and streaming is unnecessary.
- **Rejected: Service Bus as lake ingest** — wrong economics/pattern for firehose-scale raw ingest (use EH + stream jobs).

## 4. Deep dives (pick 2–3 in the room)

- **Lake partitioning** (date, region) and open table formats (**Delta/Iceberg**) if interviewer expects them.
- **Incremental** MERGE vs snapshots; **idempotent** pipelines for re-run safety.
- **Data quality** gates between layers; **quarantine** Bronze paths for bad records.

## 5. Failure scenarios and mitigations

1. **Bad schema upstream** → quarantine + **DLQ** landing; alert; contract tests.
2. **Spark job OOM / skew** → repartition, broadcast judiciously, fix hot keys.
3. **Serving endpoint throttled** → cache hot aggregates, scale pool, optimize queries.
4. **Partial pipeline success** → **lineage** + **atomic** partition promotion (swap pointer).
5. **Operator misconfiguration** — wide public ACL; prevent with **private endpoints** + policy.

(See `failures.md`.)

## 6. What breaks first?

1. **Small file problem** / metadata ops on lake — **catalog** and job startup choke before “CPU” limits.
2. **Hot partitions** in Spark or SQL pool — one tenant dominates.
3. **Serving concurrency** on serverless SQL — **throttling** under interactive BI peaks.
4. **Ingest backlog** — Event Hub **retention** vs replay window pressure.
5. **Cost alarm** — unbounded **scan** queries in serverless SQL or excessive **cluster** uptime.

## 7. Key design decisions

| Area | Chosen | Rejected | Because |
|------|--------|----------|---------|
| Lake | **ADLS Gen2** | legacy HDFS-only | Native Azure IAM, lifecycle tiers |
| Streaming ingest | **Event Hubs** | SB | Throughput + replay |
| Transform | **Spark (Synapse/Fabric/DBricks)** | SQL-only ELT | Scale for diverse volumes |
| Catalog | **Purview** | ad-hoc docs | Discovery + compliance narrative |

## 8. Trade-offs summary

- **Synapse serverless vs dedicated** — flip to dedicated when predictable heavy warehousing wins over pay-per-query volatility.
- **Fabric vs composed Synapse** — flip on team preference for unified SaaS vs best-of-breed assembly.

## 9. Evolution strategy (MVP → scale → global)

- **MVP:** daily batch Bronze/Silver, Power BI on Gold, Purview pilot.
- **10×:** near-real-time path for fraud/ops; optimize partitions; autoscale clusters.
- **Global:** region-specific **landing** and **legal** boundaries; **federated** catalog; minimize cross-border raw copies.

## 10. Security architecture

**Entra ID** for human access; **managed identities** for pipelines; **encryption** at rest; **column/row** masking for PII in BI; **private links** to storage and compute.

## 11. Observability and operations

Pipeline **SLA** monitors; **data freshness** metrics; **failed activity** alerts; Spark **stage** skew dashboards; cost **budgets** per workspace.

## 12. Cost considerations

**Cluster** auto-pause/pay-as-you-go vs always-on; **ADLS** tiering; **EH** retention; **Power BI** licensing model; **egress** from repeated lake scans—**materialized** Gold tables to cut ad hoc scan tax.
