---
learning_level: "Intermediate"
prerequisites: ["System design fundamentals", "Basic understanding of data storage"]
estimated_time: "25 minutes"
learning_objectives:
  - "Identify key factors that influence database selection in system design"
  - "Understand when to use specialized storage solutions (caching, blob storage, search engines)"
  - "Apply decision frameworks for choosing between SQL and NoSQL databases"
related_topics:
  prerequisites: []
  builds_upon: []
  enables:
    - 04_key-value-store.md
    - 11_object-storage.md
    - 12_search.md
  cross_refs: []
---

# Database Selection in System Design

## Why Database Choice Matters

In system design evaluations, your database selection significantly impacts how well your architecture scales and meets non-functional requirements. While functional requirements can typically be satisfied with any database, non-functional requirements—such as query patterns, data structure characteristics, and scale—are heavily influenced by your database choice.

## Key Decision Factors

Three primary factors guide database selection:

1. **Data Structure**: Is your data highly structured (tabular) or unstructured (flexible schema)?
2. **Query Patterns**: What types of queries will you execute? Random lookups, range queries, aggregations, or text search?
3. **Scale Requirements**: What volume of data and requests must the system handle?

## Specialized Storage Solutions

Before diving into traditional databases, consider specialized storage solutions for specific use cases.

### Caching Solutions

**When to use**: Reduce database load, cache frequently accessed data, or store API responses.

**Characteristics**:

- Key-value storage model
- Fast in-memory access
- Typically volatile (data can be evicted)

**Common Solutions**: Redis, Memcached, etcd, Hazelcast

**Example Use Cases**:

- Cache database query results
- Store session data
- Cache remote API responses to reduce latency

### Blob/Object Storage

**When to use**: Store large binary files (images, videos, documents) that don't require querying.

**Characteristics**:

- Optimized for large file storage
- Not designed for querying or indexing
- Cost-effective for large volumes

**Common Solutions**: Amazon S3, Azure Blob Storage, Google Cloud Storage

**Example Use Cases**:

- Product images in e-commerce platforms
- Video content for streaming services
- User-uploaded documents

**Best Practice**: Combine with CDN (Content Delivery Network) for global distribution and reduced latency.

### Text Search Engines

**When to use**: Full-text search, fuzzy matching, or complex text queries across large datasets.

**Characteristics**:

- Optimized for text indexing and search
- Support for fuzzy search (handling typos)
- Not a primary data store (use for search, not as source of truth)

**Common Solutions**: Elasticsearch, Apache Solr (both built on Apache Lucene)

**Example Use Cases**:

- Product search in e-commerce (search by title, description)
- Movie search by title, genre, cast
- Location search with fuzzy matching

**Critical Note**: Search engines are not databases—they don't guarantee data durability. Always maintain a primary data store and sync data to the search engine.

### Time Series Databases

**When to use**: Store and query metrics, monitoring data, or any data with timestamps as the primary dimension.

**Characteristics**:

- Append-only write pattern (sequential writes)
- Optimized for time-range queries
- Efficient compression for time-series data

**Common Solutions**: InfluxDB, OpenTSDB, TimescaleDB

**Example Use Cases**:

- Application metrics (CPU, memory, latency)
- IoT sensor data
- Financial tick data

### Data Warehouses

**When to use**: Analytics, reporting, and business intelligence on large historical datasets.

**Characteristics**:

- Designed for analytical queries (OLAP)
- Not optimized for transactional workloads (OLTP)
- Handles massive data volumes

**Common Solutions**: Hadoop ecosystem, Amazon Redshift, Google BigQuery

**Example Use Cases**:

- Business analytics and reporting
- Data mining across company-wide data
- Historical trend analysis

---

*This is Part 1 of database selection. Continue to [Part 2: SQL vs NoSQL Decision Framework](./03_databases-part2.md) for relational and non-relational database selection.*
