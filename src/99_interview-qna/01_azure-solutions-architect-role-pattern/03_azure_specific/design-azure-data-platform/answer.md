---
learning_level: "Advanced"
estimated_time: "30 minutes"
topic: "Azure data platform (analytics + serving)"
---

# Design an Azure data platform for analytics and downstream serving

## Clarify

- Sources: OLTP DBs, apps, SaaS, logs; **batch vs real-time** SLAs; **PII** handling.
- Consumers: BI, ML features, operational reverse-ETL?

## Estimate

- Daily ingest TB; query concurrency; retention.

## Architecture (medallion-style)

- **Ingest:** ADF or **Synapse pipelines**, **Event Hubs** for streaming, **Landing** ADLS Gen2 **Bronze**.
- **Transform:** Spark (Synapse/Fabric/Databricks) **Silver/Gold** curated layers.
- **Serving:** **Synapse serverless** or dedicated SQL pool; **Power BI**; optional **Cosmos** or Redis for low-latency features.
- **Governance:** **Purview** for catalog/lineage; RBAC on storage accounts.

## Deep dives

- **Partitioning** in lake (date, region); **Iceberg/Delta** if interviewer expects open formats.
- **Incremental** loads vs full snapshots; **idempotent** MERGE jobs.

## Failures

- Pipeline retries; **dead letter** landing for bad records; data quality gates between layers.

## Evolution

- Start batch daily; add near-real-time for fraud/ops; add feature store when ML online serving needed.

See companion files in this folder.
