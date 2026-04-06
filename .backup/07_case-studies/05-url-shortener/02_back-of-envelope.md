# URL Shortener - Back-of-the-Envelope Calculations

## Capacity Planning Overview

Back-of-the-envelope calculations help estimate resource requirements and validate design decisions. This section provides detailed calculations for storage, bandwidth, and infrastructure needs.

## Assumptions

**Scale Requirements**:

- 100 million URLs shortened per day
- 100:1 read-to-write ratio (10 billion redirects per day)
- Average long URL length: 100 characters
- Short URL length: 7 characters
- URLs stored for 10 years

## Storage Calculations

### Per URL Storage

**URL Mapping Record**:

- Short URL (7 chars): 7 bytes
- Long URL (100 chars avg): 100 bytes
- Metadata (timestamps, etc.): ~20 bytes
- **Total per record**: ~127 bytes

**With Overhead**:

- Database indexing overhead: ~30%
- Replication factor (Cassandra): 3x
- **Effective storage per URL**: 127 × 1.3 × 3 ≈ 495 bytes ≈ 0.5 KB

### Total Storage Requirements

**10-Year Storage**:

- URLs per day: 100 million
- Days in 10 years: 3,650 days
- Total URLs: 100M × 3,650 = 365 billion URLs
- **Total storage**: 365B × 0.5 KB = 182.5 TB

**With Growth**:

- Assuming 20% annual growth
- **Peak storage**: ~300 TB (with growth factor)

**Database Cluster Sizing**:

- Per node capacity: 10 TB (with 70% utilization)
- **Nodes required**: 300 TB ÷ 7 TB ≈ 43 nodes
- **Recommended**: 50 nodes (with redundancy)

## Bandwidth Calculations

### Write Traffic (Shortening)

**Daily Writes**:

- URLs per day: 100 million
- Bytes per write: ~200 bytes (request + response)
- **Daily write traffic**: 100M × 200 bytes = 20 GB/day
- **Peak write rate**: 20 GB ÷ 86,400 sec ≈ 232 KB/sec ≈ 1.86 Mbps

**Per Second**:

- Requests per second: 100M ÷ 86,400 ≈ 1,157 writes/sec
- **Peak write bandwidth**: 1,157 × 200 bytes ≈ 231 KB/sec

### Read Traffic (Redirection)

**Daily Reads**:

- Redirects per day: 10 billion
- Bytes per redirect: ~150 bytes (request + response)
- **Daily read traffic**: 10B × 150 bytes = 1.5 TB/day
- **Peak read rate**: 1.5 TB ÷ 86,400 sec ≈ 17.4 GB/sec ≈ 139 Gbps

**Per Second**:

- Requests per second: 10B ÷ 86,400 ≈ 115,740 reads/sec
- **Peak read bandwidth**: 115,740 × 150 bytes ≈ 17.4 MB/sec per instance

**With 10x Peak Factor**:

- **Peak read QPS**: 1.16 million requests/sec
- **Peak read bandwidth**: 174 MB/sec per instance

## Server Capacity Planning

### Service Instances

**CPU Requirements**:

- Each request: ~0.1 ms CPU time (simple lookup/redirect)
- CPU per instance: 4 cores @ 2.5 GHz = 10 GHz
- **Throughput per instance**: 10 GHz ÷ 0.1 ms = 100,000 requests/sec

**Memory Requirements**:

- Base memory: 2 GB (OS, runtime)
- Per-connection memory: ~10 KB
- **Total per instance**: 2 GB + (10K connections × 10 KB) ≈ 3 GB

**Instances Needed**:

- Peak QPS: 1.16 million reads/sec
- **Read instances**: 1.16M ÷ 100K ≈ 12 instances
- **Write instances**: 1,157 ÷ 100K ≈ 2 instances (with redundancy)
- **Total instances**: 15-20 instances (with 50% headroom)

### Database Capacity

**Cassandra Cluster**:

- Write throughput: 1,157 writes/sec
- Read throughput: 1.16 million reads/sec
- **Write nodes**: 1,157 ÷ 10K writes/node ≈ 1 node (with replication)
- **Read nodes**: 1.16M ÷ 50K reads/node ≈ 24 nodes
- **Total nodes**: 30-35 nodes (with redundancy)

## Cache Sizing

### Redis Cache

**Cache Strategy**:

- Cache top 20% of URLs (80/20 rule)
- Cache hit ratio target: 85%
- Average URL mapping: 127 bytes

**Cache Size Calculation**:

- Active URLs (last 30 days): 100M × 30 = 3 billion URLs
- Cached URLs (20%): 3B × 0.2 = 600 million URLs
- **Cache size**: 600M × 127 bytes ≈ 76 GB

**With Overhead**:

- Redis overhead: ~30%
- **Total cache memory**: 76 GB × 1.3 ≈ 100 GB

**Cache Cluster**:

- Per node capacity: 32 GB (with 70% utilization)
- **Cache nodes**: 100 GB ÷ 22 GB ≈ 5 nodes
- **Recommended**: 6-8 nodes (with redundancy)

## Network Bandwidth

### Ingress (Incoming)

**Write Requests**:

- Peak: 1,157 writes/sec × 200 bytes = 231 KB/sec

**Read Requests**:

- Peak: 1.16M reads/sec × 150 bytes = 174 MB/sec

**Total Ingress**: ~174 MB/sec ≈ 1.4 Gbps

### Egress (Outgoing)

**Write Responses**:

- Peak: 1,157 writes/sec × 100 bytes = 116 KB/sec

**Read Responses (Redirects)**:

- Peak: 1.16M reads/sec × 200 bytes = 232 MB/sec

**Total Egress**: ~232 MB/sec ≈ 1.9 Gbps

## Summary Table

| Resource | Calculation | Result |
| -------- | ----------- | ------ |
| **Storage (10 years)** | 365B URLs × 0.5 KB | 300 TB (with growth) |
| **Database Nodes** | 300 TB ÷ 7 TB/node | 50 nodes |
| **Peak Read QPS** | 10B/day ÷ 86,400 sec × 10x | 1.16M req/sec |
| **Peak Write QPS** | 100M/day ÷ 86,400 sec | 1,157 req/sec |
| **Service Instances** | 1.16M ÷ 100K/instance | 15-20 instances |
| **Cache Size** | 600M URLs × 127 bytes | 100 GB |
| **Cache Nodes** | 100 GB ÷ 22 GB/node | 6-8 nodes |
| **Peak Bandwidth** | 1.16M × 200 bytes | 232 MB/sec (1.9 Gbps) |

## Key Insights

1. **Read-Heavy Workload**: 100:1 read-to-write ratio requires heavy caching
2. **Storage Growth**: 300 TB over 10 years requires scalable database
3. **Network Bandwidth**: ~2 Gbps peak requires CDN for global distribution
4. **Cache Critical**: 85% cache hit ratio reduces database load by 8.5x
5. **Horizontal Scaling**: All components scale horizontally (no bottlenecks)

---

*For system architecture, see [High-Level Design](./03_high-level-design.md). For scaling strategies, see [Scalability](./05_scalability.md).*
