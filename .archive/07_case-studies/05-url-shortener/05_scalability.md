# URL Shortener - Scalability

## Scaling Strategies

### Horizontal Scaling

**Short URL Service**:

- Add more service instances behind load balancer
- Stateless design allows easy horizontal scaling
- Each instance independently generates short URLs using assigned token ranges

**Database (Cassandra)**:

- Add more nodes to Cassandra cluster
- Automatic data distribution across nodes
- Linear scalability with node addition

**Token Service**:

- Low-frequency service (called only when token ranges exhausted)
- Can scale by:
  - Increasing token range size (assign millions instead of thousands)
  - Adding read replicas for range assignment queries
  - Deploying across multiple data centers

### Caching Layer

**Redis Cache for Read Path**:

- Cache popular short URLs to reduce database load
- Cache hit ratio typically 80-90% for popular URLs
- Reduces latency for frequently accessed URLs

**Cache Strategy**:

- Write-through: Write to both cache and database
- TTL: 24 hours (configurable based on access patterns)
- Eviction: LRU (Least Recently Used) for cache full scenarios

### Database Sharding (Alternative Approach)

If using MySQL instead of Cassandra:

**Sharding Strategy**:

- Shard by short URL hash (consistent hashing)
- Each shard handles subset of URLs
- Requires shard management and routing logic

**Trade-off**: More operational complexity compared to Cassandra's built-in sharding

## Analytics and Monitoring

### Analytics Requirements

**Business Metrics**:

- Click-through rates per short URL
- Geographic distribution of clicks
- Device/platform breakdown (mobile, desktop, iOS, Android)
- Referrer information (which platform shared the link)

**Operational Metrics**:

- Request latency (p50, p95, p99)
- Error rates
- Cache hit ratios
- Database query performance

### Analytics Architecture

**Data Collection**:

- Asynchronous event publishing to message queue (Kafka)
- Non-blocking to avoid impacting redirect latency
- Batch processing for efficiency

**Event Structure**:

```json
{
  "short_url": "aB3xK9m",
  "timestamp": "2025-12-14T10:30:00Z",
  "ip_address": "192.168.1.1",
  "user_agent": "Mozilla/5.0...",
  "referrer": "facebook.com",
  "country": "US"
}
```

**Processing Pipeline**:

1. Service publishes events to Kafka (async, non-blocking)
2. Stream processing (Spark Streaming) aggregates events
3. Aggregated data stored in analytics database
4. Dashboard queries analytics database for metrics

### Batching Strategy

**Problem**: Writing to Kafka on every request impacts latency.

**Solution**: Local batching

- Accumulate events in memory buffer
- Flush to Kafka when:
  - Buffer reaches threshold (e.g., 100 events)
  - Time threshold reached (e.g., every 10 seconds)
- Reduces I/O operations per request

**Trade-off**: Potential event loss if service crashes before flush (acceptable for analytics)

## Geographic Distribution

### Multi-Region Deployment

**Strategy**:

- Deploy service instances in multiple data centers
- Route users to nearest data center
- Replicate database across regions

**Benefits**:

- Reduced latency for global users
- Improved availability (survives regional outages)
- Better data residency compliance

**Challenges**:

- Cross-region database replication
- Token Service coordination across regions
- Cache invalidation across regions

## Capacity Planning

### Read-Heavy Workload

**Characteristics**:

- Redirect requests: 100:1 ratio vs shortening requests
- Most URLs accessed infrequently (long tail)
- Small percentage of URLs receive majority of traffic

**Optimization**:

- Aggressive caching for popular URLs
- Database read replicas
- CDN for static assets (if any)

### Write Workload

**Characteristics**:

- Shortening requests: Lower volume but must be fast
- Token generation: Very low frequency (ranges last hours/days)

**Optimization**:

- Large token ranges to reduce Token Service calls
- Efficient database writes (Cassandra optimized for writes)

---

*For capacity planning details, see [Back-of-Envelope](./02_back-of-envelope.md). For design trade-offs, see [Trade-offs](./08_trade-offs.md).*
