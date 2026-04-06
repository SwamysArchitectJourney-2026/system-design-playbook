---
learning_level: "Intermediate"
prerequisites: ["03_databases-part1.md"]
estimated_time: "25 minutes"
learning_objectives:
  - "Apply decision framework for choosing between relational and non-relational databases"
  - "Understand when to use document databases vs columnar databases"
  - "Design database combinations for complex real-world scenarios"
related_topics:
  prerequisites:
    - 03_databases-part1.md
  builds_upon:
    - 03_databases-part1.md
  enables:
    - 04_key-value-store.md
  cross_refs: []
---

# Database Selection: SQL vs NoSQL Decision Framework

## Decision Flow Overview

The choice between relational (SQL) and non-relational (NoSQL) databases depends on three key questions:

1. Is your data structured or unstructured?
2. Do you need ACID guarantees (atomicity, consistency, isolation, durability)?
3. What are your query patterns and scale requirements?

## Structured Data with ACID Requirements

**When to use**: Financial transactions, inventory management, order processing, or any scenario requiring transactional guarantees.

**Why Relational Databases**:

- ACID properties ensure data consistency
- Transaction support for multi-step operations
- Strong referential integrity

**Example Scenario**: Payment system where money must be transferred atomically between accounts. Both debit and credit operations must succeed together or fail together.

**Common Solutions**: MySQL, PostgreSQL, Oracle, SQL Server

## Structured Data Without ACID Requirements

**When to use**: User profiles, content metadata, or read-heavy workloads where eventual consistency is acceptable.

**Options**: Either relational or non-relational databases work. Choose based on:

- Team expertise
- Existing infrastructure
- Query complexity requirements

## Unstructured Data: Document Databases

**When to use**: E-commerce catalogs, content management systems, or any scenario with:

- Wide variety of attributes across items
- Flexible schema requirements
- Complex queries on nested data

**Characteristics**:

- Store documents (JSON-like structures)
- Flexible schema per document
- Optimized for querying nested attributes

**Example Scenario**: E-commerce product catalog where:

- Shirts have attributes: size, color, material
- Refrigerators have attributes: volume, energy rating, features
- Milk has attributes: quantity, expiry date

**Common Solutions**: MongoDB, Couchbase, Amazon DocumentDB

**Note**: Elasticsearch and Solr (discussed in Part 1) are specialized document databases optimized for text search.

## Unstructured Data: Columnar Databases

**When to use**: Scenarios with:

- Ever-increasing data volume (growing faster than linear)
- Limited query types (few, well-defined queries)
- High write throughput requirements

**Characteristics**:

- Optimized for append-heavy workloads
- Efficient storage and retrieval of time-ordered data
- Horizontal scalability

**Example Scenario**: Location tracking system where:

- Drivers continuously send location pings
- Data volume grows as more drivers join
- Primary query: "Get all locations for driver X"

**Common Solutions**: Apache Cassandra, HBase

**Trade-off Note**: Cassandra is generally easier to deploy, while HBase offers more features but requires more components.

## Real-World Database Combinations

Most production systems use multiple database types, each optimized for specific use cases.

### Example: E-Commerce Platform

**Scenario**: An e-commerce platform needs to handle:

- Inventory management (prevent overselling)
- Order history (growing data volume)
- Product search and analytics

**Solution**:

1. **Relational Database (MySQL/PostgreSQL)** for:
   - Active inventory management
   - In-flight orders (not yet delivered)
   - ACID guarantees for preventing overselling

2. **Columnar Database (Cassandra)** for:
   - Delivered order history
   - Ever-increasing order data
   - Efficient storage of historical transactions

3. **Document Database (MongoDB)** for:
   - Product search and analytics queries
   - Flexible queries like "users who bought sugar in last 5 days"
   - Subset of order information optimized for reporting

**Workflow**:

- New orders stored in relational database
- After delivery, orders moved to Cassandra for permanent storage
- Analytics queries use MongoDB to find relevant order IDs, then query both relational and columnar databases

## Decision Summary

| Data Type | ACID Needed? | Query Pattern | Recommended Database |
| --------- | ------------ | ------------- | -------------------- |
| Structured | Yes | Various | Relational (MySQL, PostgreSQL) |
| Structured | No | Simple | Either (choose based on team/infrastructure) |
| Unstructured | No | Complex, varied | Document DB (MongoDB) |
| Unstructured | No | Simple, high volume | Columnar DB (Cassandra) |

**Key Takeaway**: Real-world systems rarely use a single database. Design your architecture to use the right database for each specific use case, combining multiple databases to meet all requirements.

---

*This completes the database selection framework. For specific building blocks, see [Key-Value Stores](./04_key-value-store.md), [Object Storage](./11_object-storage.md), and [Search](./12_search.md).*
