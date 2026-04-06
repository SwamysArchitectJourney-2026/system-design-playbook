# Rate Limiter - Back-of-Envelope Calculations

## Capacity Planning

### Traffic Estimates

**Assumptions**:

- Peak traffic: 10 million requests per second (RPS)
- Average request size: 1 KB
- Unique rate limit keys: 100 million
- Average rate limit checks per request: 1.5 (some requests check multiple limits)

### Storage Requirements

#### Rate Limit Counters

**Counter Storage**:

- Each counter: 8 bytes (timestamp + count)
- Unique keys: 100 million
- Total counter storage: 100M × 8 bytes = 800 MB
- With replication (3x): 2.4 GB

**TTL-based Cleanup**:

- Counters expire after time window (e.g., 1 hour)
- Active counters at any time: ~10% of total = 10 million
- Active storage: 10M × 8 bytes = 80 MB
- With replication: 240 MB

#### Configuration Storage

**Rate Limit Rules**:

- Number of rules: 10,000
- Average rule size: 500 bytes (rule definition, limits, keys)
- Total configuration: 10K × 500 bytes = 5 MB

**Total Storage**: ~250 MB (active counters + configuration)

### Bandwidth Requirements

#### Incoming Requests

- Requests per second: 10 million
- Request size: 1 KB
- Incoming bandwidth: 10M × 1 KB = 10 GB/s = 80 Gbps

#### Rate Limit Check Responses

- Responses per second: 10 million
- Response size: 100 bytes (status + headers)
- Outgoing bandwidth: 10M × 100 bytes = 1 GB/s = 8 Gbps

**Total Bandwidth**: ~88 Gbps

### Compute Requirements

#### Rate Limit Check Operations

**Operations per Request**:

- Redis lookup: 1 operation
- Counter increment: 1 operation
- TTL check: 1 operation
- Total: ~3 operations per request

**Total Operations**:

- Requests per second: 10 million
- Operations per request: 3
- Total operations: 30 million ops/second

#### CPU Requirements

**Per Operation**:

- Redis operation: ~0.1 ms CPU time
- Algorithm computation: ~0.05 ms CPU time
- Total: ~0.15 ms per operation

**Total CPU Time**:

- Operations per second: 30 million
- CPU time per operation: 0.15 ms
- Total CPU time: 4,500 seconds/second = 4,500 cores

**With 50% efficiency**: ~9,000 CPU cores needed

#### Memory Requirements

**Per Instance**:

- In-memory cache: 1 GB (frequently accessed counters)
- Application memory: 500 MB
- Redis connection pool: 100 MB
- Total per instance: ~1.6 GB

**Total Instances**: 100 instances (for redundancy and load distribution)
**Total Memory**: 100 × 1.6 GB = 160 GB

### Infrastructure Sizing

#### Application Servers

- **Instances**: 100 instances
- **CPU per instance**: 8 cores
- **Memory per instance**: 16 GB
- **Total CPU**: 800 cores (with 10x headroom for 9,000 core requirement)
- **Total Memory**: 1.6 TB

#### Redis Cluster

- **Nodes**: 10 nodes (for high availability and performance)
- **Memory per node**: 32 GB (for counter storage)
- **Total Memory**: 320 GB
- **Replication**: 3x replication = 960 GB total

#### Database (Configuration)

- **Instances**: 3 instances (primary + 2 replicas)
- **Storage**: 10 GB (configuration data)
- **Memory**: 8 GB per instance

### Cost Estimates (Monthly)

#### Compute

- Application servers: 100 instances × $100/month = $10,000
- Redis cluster: 10 nodes × $200/month = $2,000
- Database: 3 instances × $150/month = $450

**Total Compute**: ~$12,450/month

#### Network

- Bandwidth: 88 Gbps × $0.01/GB = ~$6,336/month (assuming 50% utilization)

**Total Infrastructure**: ~$18,786/month

### Performance Targets

#### Latency Breakdown

- Redis lookup: 0.5 ms (p99)
- Counter increment: 0.3 ms
- Algorithm computation: 0.1 ms
- Network overhead: 0.1 ms
- **Total**: <1 ms (p99)

#### Throughput per Instance

- Single instance capacity: 100K requests/second
- With 100 instances: 10M requests/second
- **Headroom**: 20% buffer = 12M requests/second capacity

### Scaling Considerations

#### Horizontal Scaling

- **Linear scaling**: Add instances to handle more traffic
- **Stateless design**: All instances are identical
- **Load distribution**: Even distribution across instances

#### Vertical Scaling

- **Redis scaling**: Add more nodes to Redis cluster
- **Database scaling**: Read replicas for configuration queries
- **Cache scaling**: Increase in-memory cache size

### Summary

| Metric | Value |
| ------ | ----- |
| Peak RPS | 10 million |
| Storage | 250 MB (active) |
| Bandwidth | 88 Gbps |
| CPU Cores | 9,000 (with headroom) |
| Memory | 1.6 TB (application) + 960 GB (Redis) |
| Instances | 100 application servers |
| Latency (p99) | <1 ms |
| Monthly Cost | ~$19K |
