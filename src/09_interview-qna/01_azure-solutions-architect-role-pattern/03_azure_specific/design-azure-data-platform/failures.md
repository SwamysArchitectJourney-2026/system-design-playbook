# Failure scenarios: Azure data platform

- **Pipeline failure mid-batch** → Idempotent MERGE; checkpoint partitions; alert + replay from last good watermark.
- **Bad data in Bronze** → Quarantine table; schema validation gate before Silver.
- **Spark cluster starvation** → Queue jobs; autoscale pools; right-size SKU.
- **Storage throttling** on ADLS → Partition layout; reduce small files; retry with backoff.
- **Lineage gap** → Purview/job metadata out of sync—manual trace until fixed.
