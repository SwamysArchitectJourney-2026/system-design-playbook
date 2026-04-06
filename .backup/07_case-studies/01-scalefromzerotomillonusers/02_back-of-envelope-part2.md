# Scale from Zero to Million Users - Component Calculations (Part 2)

This document covers back-of-envelope calculations for core infrastructure components: Data Store, Caching, and Load Balancing.

> **📋 Main Document**: See [Back-of-Envelope Summary (Part 1)](./02_back-of-envelope-part1.md) for capacity planning by phase and links to all component calculations.

---

## A. Data Store

**Performance Target**: Returns within 50ms for 95% of requests (p95 < 50ms)

**Capacity Planning**:

**Phase 1-2 (0-100K users)**:
- Single database instance
- Read replicas for read-heavy workloads
- Connection pool: 50-100 connections
- Storage: 365 GB - 3.65 TB/year

**Phase 3-4 (100K-1M+ users)**:
- Database sharding or read replicas
- Connection pool: 200-500 connections per shard
- Storage: 3.65 TB - 36.5+ TB/year
- Read replicas: 2-5 replicas per primary

**Calculations**:
- **Read Operations**: 90% of traffic (10:1 read/write ratio)
- **Write Operations**: 10% of traffic
- **Database Load**: Total QPS / (1 + number of read replicas)
- **Storage Growth**: Daily writes × record size × retention period

**Example (Phase 3)**:
- 10,000 QPS total
- 9,000 read QPS, 1,000 write QPS
- 3 read replicas
- Primary database handles: 1,000 write QPS + (9,000 / 3) = 4,000 QPS
- Each replica handles: 3,000 read QPS

---

## B. Caching

**Strategy**: Use Redis or Memcached to cache frequent queries, reducing database load

**Cache Hit Ratio Target**: 80-90% (industry standard)

**Capacity Planning**:

**Phase 2 (1K-100K users)**:
- Single Redis instance
- Memory: 2-4 GB
- Cache TTL: 5-15 minutes
- Reduces database load by 4-5x

**Phase 3-4 (100K-1M+ users)**:
- Redis cluster (distributed)
- Memory: 16-64 GB total (across nodes)
- Cache TTL: 1-10 minutes (varies by data type)
- Reduces database load by 5-10x

**Calculations**:
- **Cache Hit Rate**: 80% (typical)
- **Database Load Reduction**: 
  - Without cache: 10,000 QPS to database
  - With 80% hit rate: 2,000 QPS to database (80% reduction)
- **Cache Memory**: 
  - Hot data: 20% of total data
  - Cache size = (Daily unique reads × record size × 0.2) / cache_hit_ratio

**Example (Phase 3)**:
- 10,000 read QPS
- 80% cache hit rate
- Cache handles: 8,000 QPS (hits)
- Database handles: 2,000 QPS (misses)
- Cache memory needed: ~8-16 GB for hot data

---

## C. Load Balancing

**Types**: External (public-facing) and Internal (service-to-service)

**External Load Balancer**:
- Sits between internet and application servers
- Handles user traffic
- SSL termination
- Health checks
- Geographic routing (Phase 4)

**Internal Load Balancer**:
- Routes traffic between services
- Service-to-service communication
- Not exposed to internet
- Lower latency requirements

**Capacity Planning**:

**Phase 2 (1K-100K users)**:
- Single external load balancer
- 1,000-10,000 connections/second capacity
- Health checks every 5-10 seconds

**Phase 3-4 (100K-1M+ users)**:
- External load balancer with auto-scaling
- 10,000-100,000+ connections/second capacity
- Internal load balancers for microservices
- Health checks every 1-5 seconds

**Calculations**:
- **Connections per Second**: Peak QPS × average connection duration
- **Load Balancer Capacity**: Must handle 2-3x peak traffic for headroom
- **Health Check Overhead**: (Number of backends × health check frequency) / 60 seconds

**Example (Phase 3)**:
- 10,000 peak QPS
- Average connection: 2 seconds
- Connections/second: 10,000 × 2 = 20,000 connections/second
- Load balancer capacity needed: 20,000 × 2 = 40,000 connections/second (with headroom)

### Internal vs External Load Balancers

**External Load Balancer** (Public-facing):
- **Location**: Between internet and application servers
- **Purpose**: Distribute user traffic to application servers
- **Features**:
  - SSL/TLS termination
  - Public IP addresses
  - DDoS protection
  - Geographic routing (multi-region)
- **Use Cases**: 
  - User-facing APIs
  - Web applications
  - Mobile app backends
- **Latency**: 1-5ms overhead per request

**Internal Load Balancer** (Service-to-service):
- **Location**: Inside private network, between services
- **Purpose**: Route traffic between microservices
- **Features**:
  - Private IP addresses only
  - Service discovery integration
  - Health checks
  - Circuit breaker support
- **Use Cases**:
  - Microservices communication
  - Database connection pooling
  - Internal API routing
- **Latency**: 0.5-2ms overhead per request

**When to Use Each**:

**External Load Balancer**:
- All user-facing traffic
- Phase 2+ (when you have multiple application servers)
- Required for SSL termination
- Needed for geographic distribution

**Internal Load Balancer**:
- Microservices architecture (Phase 4)
- Service mesh implementations
- Database read replica routing
- Internal service-to-service communication

**Example Architecture (Phase 4)**:
```text
Internet → External LB → [App Server 1, App Server 2, ...]
                              ↓
                    Internal LB → [User Service, Order Service, ...]
                              ↓
                    Internal LB → [Database Primary, Read Replica 1, ...]
```

---

*Next: [Component Calculations Part 3](./02_back-of-envelope-part3.md) - CDN, Monitoring, Alerting*

