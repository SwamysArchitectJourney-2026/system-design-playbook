# URL Shortener - Observability and Monitoring

## Observability Overview

Observability enables understanding system behavior through logs, metrics, and traces. This section covers comprehensive monitoring, logging, and alerting strategies.

## Three Pillars of Observability

### 1. Metrics

**System Metrics**:

- CPU utilization (per instance, per service)
- Memory usage (heap, cache, buffers)
- Disk I/O (read/write throughput, latency)
- Network I/O (bandwidth, packet loss)

**Application Metrics**:

- Request rate (QPS for reads/writes)
- Request latency (p50, p95, p99, p99.9)
- Error rate (4xx, 5xx responses)
- Cache hit ratio (Redis cache effectiveness)
- Database query latency (Cassandra read/write)

**Business Metrics**:

- URLs shortened per hour/day
- Redirects per hour/day
- Unique short URLs accessed
- Geographic distribution of traffic

### 2. Logging

**Structured Logging**:

- Use JSON format for machine parsing
- Include correlation IDs for request tracing
- Log levels: ERROR, WARN, INFO, DEBUG

**Key Log Events**:

- URL shortening requests (with long URL hash, not full URL)
- Redirect requests (short URL, user agent, IP)
- Token range assignments
- Service startup/shutdown
- Error conditions (database failures, cache misses)

**Log Aggregation**:

- Centralized logging system (ELK stack, Splunk, CloudWatch)
- Log retention: 30 days (hot), 1 year (cold storage)
- Index critical errors for fast retrieval

### 3. Distributed Tracing

**Trace Context**:

- Propagate trace IDs across service boundaries
- Include span IDs for operation tracking
- Track request flow: Load Balancer → Service → Database/Cache

**Key Spans**:

- Request received (load balancer)
- Service processing (shortening/redirect)
- Database query (Cassandra lookup)
- Cache operation (Redis get/set)
- Token service call (if needed)

**Trace Sampling**:

- 100% sampling for errors
- 1% sampling for normal requests (reduce overhead)
- 10% sampling for high-traffic periods

## Monitoring Architecture

### Metrics Collection

**Agent-Based Collection**:

- Prometheus exporters on each service instance
- Node exporter for system metrics
- Custom exporters for application metrics

**Push vs Pull**:

- **Pull model** (Prometheus): Scrape metrics from services
- **Push model** (StatsD): Services push metrics to aggregator
- **Hybrid**: Use pull for services, push for ephemeral jobs

**Metrics Storage**:

- Time-series database (Prometheus, InfluxDB)
- Retention: 15 days (high resolution), 1 year (aggregated)

### Alerting Strategy

**Alert Levels**:

**Critical (Page On-Call)**:

- Service availability < 99.9%
- Error rate > 1%
- P99 latency > 500ms
- Database unavailable

**Warning (Notify Team)**:

- Error rate > 0.5%
- P95 latency > 200ms
- Cache hit ratio < 80%
- Disk usage > 80%

**Info (Dashboard Only)**:

- Traffic spikes (>2x normal)
- Token range exhaustion approaching
- Cache eviction rate high

**Alert Channels**:

- PagerDuty/OpsGenie for critical alerts
- Slack/Email for warnings
- Dashboard for info-level metrics

## Service Level Indicators (SLIs)

### Availability SLI

**Definition**: Percentage of successful requests (2xx, 3xx responses)

**Target**: 99.9% availability

- **SLO**: 99.9% uptime (8.76 hours downtime/year)
- **Measurement**: Successful requests / Total requests

### Latency SLI

**Definition**: Percentage of requests below latency threshold

**Targets**:

- P50 latency: < 10ms (50% of requests)
- P95 latency: < 50ms (95% of requests)
- P99 latency: < 200ms (99% of requests)

### Error Rate SLI

**Definition**: Percentage of requests returning errors (4xx, 5xx)

**Target**: < 0.1% error rate

- **Measurement**: Error requests / Total requests

## Health Checks

### Service Health Endpoints

**Liveness Probe**:

- Endpoint: `/health/live`
- Checks: Service process running
- Response: 200 OK if alive

**Readiness Probe**:

- Endpoint: `/health/ready`
- Checks: Database connectivity, cache connectivity
- Response: 200 OK if ready to serve traffic

**Startup Probe**:

- Endpoint: `/health/startup`
- Checks: Initial token range assigned, dependencies ready
- Response: 200 OK when fully initialized

### Dependency Health

**Database Health**:

- Connection pool status
- Query latency
- Replication lag (if applicable)

**Cache Health**:

- Redis connectivity
- Cache hit ratio
- Memory usage

**Token Service Health**:

- MySQL connectivity
- Available token ranges
- Assignment rate

## Dashboards

### Operational Dashboard

**Key Panels**:

- Request rate (reads/writes) - time series
- Latency percentiles (p50, p95, p99) - time series
- Error rate (4xx, 5xx) - time series
- Cache hit ratio - gauge
- Database query latency - time series
- Service instance count - gauge

### Business Dashboard

**Key Panels**:

- URLs shortened (per hour/day) - counter
- Redirects (per hour/day) - counter
- Top shortened URLs - table
- Geographic traffic distribution - map
- Device/platform breakdown - pie chart

### Infrastructure Dashboard

**Key Panels**:

- CPU utilization (per service) - time series
- Memory usage (per service) - time series
- Network bandwidth (ingress/egress) - time series
- Database cluster health - status
- Cache cluster health - status

## Log Analysis

### Common Queries

**Error Analysis**:

```text
ERROR level logs | last 1 hour | group by error_type
```

**Slow Requests**:

```text
latency > 200ms | last 1 hour | group by endpoint
```

**Traffic Patterns**:

```text
redirect requests | last 24 hours | group by hour
```

### Anomaly Detection

**Automated Detection**:

- Sudden traffic spikes (>3x normal)
- Error rate increases (>2x baseline)
- Latency degradation (>50% increase)
- Cache hit ratio drops (>10% decrease)

## Failure Scenarios and Blast Radius Analysis

### Scenario 1: Cassandra Cluster Node Failure

**Blast Radius**:
- **Affected**: Write throughput reduced (fewer nodes), potential data unavailability if quorum lost
- **Not Affected**: Read operations (can read from remaining nodes), cached redirects

**Detection**:
- Cassandra node health check fails
- Write operation errors or timeouts
- Cluster replication factor warnings

**Mitigation**:
- Remaining nodes continue serving requests
- Auto-repair replicates data to new node
- Scale cluster if needed to maintain quorum

**Prevention**:
- Replication factor of 3+ (survive 1-2 node failures)
- Regular cluster health monitoring
- Automated node replacement
- Data backup and restore procedures

### Scenario 2: Redis Cache Cluster Failure

**Blast Radius**:
- **Affected**: All cached URL mappings, 100x increase in database read load
- **Not Affected**: System remains functional, redirects still work (slower)

**Detection**:
- Cache health check fails
- Cache hit ratio drops to 0%
- Database read QPS increases dramatically

**Mitigation**:
- System continues operating (cache is optimization, not critical)
- Database handles increased load (designed for this)
- Provision new cache cluster
- Warm cache with hot URLs gradually

**Prevention**:
- Redis cluster with replication (sentinel mode)
- Cache data persistence
- Monitor cache memory usage
- Implement cache warming for hot URLs

### Scenario 3: Token Service Failure

**Blast Radius**:
- **Affected**: New URL shortening requests (can't get new token ranges)
- **Not Affected**: Existing token ranges continue working, redirect operations

**Detection**:
- Token Service health check fails
- Service instances can't get new token ranges
- Error logs show token service connection failures

**Mitigation**:
- Service instances use existing token ranges (can continue for hours/days)
- Failover to backup token service instance
- Emergency: Use distributed ID generation (UUID) temporarily

**Prevention**:
- Token Service redundancy (multiple instances)
- Pre-allocate larger token ranges (reduce frequency of calls)
- Health checks and automatic failover
- Token range caching at service instances

### Scenario 4: CDN Failure

**Blast Radius**:
- **Affected**: Redirect latency increases (CDN → origin server), origin server load increases
- **Not Affected**: System remains functional, redirects still work

**Detection**:
- CDN health check fails
- Redirect latency increases
- Origin server load increases

**Mitigation**:
- Traffic routes directly to origin servers
- Scale origin servers to handle increased load
- Use backup CDN provider if available

**Prevention**:
- Multi-CDN strategy (failover)
- CDN health monitoring
- Origin server capacity planning (handle CDN failure)
- Geographic distribution

## Incident Response

### Runbooks

**Common Scenarios**:

1. High error rate → Check database connectivity, cache status
2. High latency → Check database query performance, cache hit ratio
3. Service unavailable → Check health endpoints, restart if needed
4. Database slow → Check replication lag, node health

### Escalation Path

1. **Level 1**: On-call engineer (auto-alert)
2. **Level 2**: Team lead (if unresolved in 15 min)
3. **Level 3**: Engineering manager (if unresolved in 1 hour)

## Cross-References

- Related: [Observability Building Block](../../05_building-blocks/07_monitoring.md)
- Related: [Failure Models](../../03_foundations/04_failure-models-part1.md)
- Related: [Failure Analysis](../../08_failures/01_introduction.md)

---

*For analytics architecture, see [Scalability](./05_scalability.md). For capacity planning, see [Back-of-Envelope](./02_back-of-envelope.md).*
