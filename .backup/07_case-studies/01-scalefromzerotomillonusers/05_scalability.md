# Scale from Zero to Million Users - Scalability

## Scaling Strategies by Phase

### Phase 1: Vertical Scaling

**Approach**: Increase server resources

- Upgrade CPU: 2 cores → 4 cores → 8 cores
- Increase RAM: 4 GB → 8 GB → 16 GB
- Faster storage: HDD → SSD → NVMe

**Limitations**:

- Hardware limits
- Single point of failure
- Cost increases linearly

### Phase 2: Read Replicas

**Approach**: Add database read replicas

- Primary database for writes
- 2-3 read replicas for reads
- Replication lag: <100ms

**Benefits**:

- Distribute read load
- Improved availability
- Better performance

### Phase 3: Horizontal Scaling

**Approach**: Add more application servers

- Stateless application servers
- Load balancer distributes traffic
- Shared database and cache

**Benefits**:

- Linear scalability
- Better fault tolerance
- Cost-effective

### Phase 4: Distributed Architecture

**Approach**: Microservices + Distributed Systems

- Service decomposition
- Independent scaling per service
- Distributed databases
- Global distribution (multiple regions, traffic managed at DNS and load balancer layers)

**Benefits**:

- Maximum scalability
- Service-level optimization
- Global reach

## Database Scaling

### Vertical Scaling (Phase 1-2)

- Larger database instance
- More CPU and memory
- Faster storage

### Read Replicas (Phase 2-3)

- Primary for writes
- Multiple replicas for reads
- Geographic distribution

### Sharding (Phase 3-4)

- Horizontal partitioning
- Shard by user_id or region
- Consistent hashing for distribution

### Database Types (Phase 4)

- SQL for transactional data
- NoSQL for high-volume data
- Time-series for metrics
- Search engine for full-text search

## Caching Strategy

### Cache Layers

1. **Application Cache** (L1): In-memory, fastest, limited size
2. **Distributed Cache** (L2): Redis, shared across servers
3. **CDN Cache** (L3): Global edge cache for static content

### Cache Patterns

- **Cache-Aside**: Application manages cache
- **Write-Through**: Write to cache and DB
- **Write-Behind**: Write to cache, async to DB

## Load Balancing

### Phase 2: Basic Load Balancer

- Round-robin or least connections
- Health checks
- SSL termination

### Phase 3-4: Advanced Load Balancing

- Geographic routing
- Session affinity (if needed)
- Weighted routing
- Auto-scaling integration

## Traffic Management (DNS and Traffic Manager)

### Early Stages (Phase 1-2)

- Simple DNS record pointing directly to the application endpoint (server or external load balancer)
- Short TTLs can help when you need to move traffic to a new IP during incidents or migrations

### Growth Stages (Phase 3-4)

- Use DNS together with a traffic manager (geo-aware DNS or global routing service) to:
  - Route users to the closest healthy region
  - Fail over between regions during outages
- Keep routing logic simple: start with active-passive (one primary region, one standby), then evolve to active-active as you mature

## Deployment & Release Strategies (CI/CD, DevOps, GitOps)

### Phase 1-2: Getting to Safe, Repeatable Deployments

- Start with a basic CI/CD pipeline that builds, tests, and deploys the monolith
- Introduce blue-green deployments so you can switch traffic between old and new versions behind the load balancer with minimal downtime

### Phase 3-4: Operating at Scale

- Use rolling deployments and canary releases so only a slice of traffic sees the new version first
- Manage infrastructure declaratively (infra-as-code) and store configs in version control
- Adopt GitOps-style workflows: desired state lives in git, and automated agents reconcile the running system to that state across environments and regions

## Monitoring and Auto-Scaling

### Metrics to Monitor

- CPU utilization
- Memory usage
- Request rate (QPS)
- Response time (latency)
- Error rate
- Cache hit ratio

### Auto-Scaling Triggers

- Scale up: CPU > 70% for 5 minutes
- Scale down: CPU < 30% for 10 minutes
- Scale based on queue depth
- Scale based on custom metrics

## Cost Optimization

- **Right-sizing**: Match resources to actual needs
- **Reserved Instances**: For predictable workloads
- **Spot Instances**: For non-critical workloads
- **Cache Optimization**: Reduce database load
- **CDN**: Reduce bandwidth costs
- **Data Archival**: Move old data to cheaper storage
