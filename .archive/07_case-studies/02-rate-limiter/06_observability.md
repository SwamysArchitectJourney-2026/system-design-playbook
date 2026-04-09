# Rate Limiter - Observability

## Monitoring Strategy

### Key Metrics

#### System Metrics

- **Request Rate**: Requests per second (RPS)
- **Latency**: p50, p95, p99 latency for rate limit checks
- **Error Rate**: Percentage of failed rate limit checks
- **Throughput**: Successful rate limit checks per second

#### Redis Metrics

- **Operations per Second**: Redis operations (GET, SET, INCR)
- **Latency**: Redis operation latency
- **Connection Pool**: Active connections, pool utilization
- **Memory Usage**: Redis memory consumption
- **Cache Hit Rate**: Configuration cache hit rate

#### Application Metrics

- **CPU Utilization**: Per instance CPU usage
- **Memory Usage**: Per instance memory consumption
- **Thread Pool**: Active threads, queue size
- **GC Metrics**: Garbage collection frequency and duration

### Metrics Collection

```python
class MetricsCollector:
    def record_rate_limit_check(self, rule_id: str, allowed: bool, latency: float):
        """Record rate limit check metrics."""
        self.counter.inc("rate_limit.checks.total", tags={"rule_id": rule_id})
        self.counter.inc(f"rate_limit.checks.{'allowed' if allowed else 'denied'}", 
                        tags={"rule_id": rule_id})
        self.histogram.observe("rate_limit.latency", latency, tags={"rule_id": rule_id})
    
    def record_redis_operation(self, operation: str, latency: float, success: bool):
        """Record Redis operation metrics."""
        self.counter.inc("redis.operations.total", tags={"operation": operation})
        self.counter.inc(f"redis.operations.{'success' if success else 'failure'}", 
                        tags={"operation": operation})
        self.histogram.observe("redis.latency", latency, tags={"operation": operation})
```

## Logging

### Log Levels

- **ERROR**: Rate limiter failures, Redis errors, critical issues
- **WARN**: Performance degradation, high latency, configuration issues
- **INFO**: Rate limit decisions, configuration changes, scaling events
- **DEBUG**: Detailed algorithm execution, cache operations

### Structured Logging

```python
logger.info("rate_limit_check", extra={
    "key_type": "user",
    "key_value": "user123",
    "rule_id": "rule_001",
    "allowed": True,
    "latency_ms": 0.8,
    "remaining": 999,
    "limit": 1000
})
```

### Log Aggregation

- **Centralized Logging**: All logs sent to centralized log aggregation service
- **Searchable**: Full-text search across all logs
- **Retention**: 30 days for INFO, 90 days for ERROR
- **Alerting**: Alert on error patterns

## Distributed Tracing

### Trace Spans

**Rate Limit Check Trace**:

```text
rate_limit_check (root span)
├── get_configuration (child span)
│   ├── cache_lookup
│   └── database_query
├── redis_operation (child span)
│   ├── connection_acquire
│   ├── redis_get
│   └── redis_set
└── algorithm_execution (child span)
```

### Trace Context

```python
def check_rate_limit(request: RateLimitRequest) -> RateLimitResponse:
    with tracer.start_span("rate_limit_check") as span:
        span.set_tag("key_type", request.key_type)
        span.set_tag("rule_id", request.rule_id)
        
        with tracer.start_span("get_configuration", child_of=span):
            rule = get_rate_limit_rule(request.rule_id)
        
        with tracer.start_span("redis_operation", child_of=span):
            allowed = execute_algorithm(key, rule)
        
        span.set_tag("allowed", allowed)
        return response
```

## SLIs and SLOs

### Service Level Indicators (SLIs)

1. **Availability**: Percentage of successful rate limit checks
2. **Latency**: p99 latency for rate limit checks
3. **Accuracy**: Rate limit enforcement accuracy (±1%)
4. **Throughput**: Requests per second handled

### Service Level Objectives (SLOs)

- **Availability**: 99.99% (4.32 minutes downtime per month)
- **Latency**: p99 < 1ms
- **Accuracy**: ±1% rate limit enforcement
- **Throughput**: 10M+ RPS

### Error Budget

- **Monthly Error Budget**: 0.01% (4.32 minutes)
- **Tracking**: Track against error budget
- **Alerting**: Alert when error budget consumed

## Alerting

### Critical Alerts

1. **High Error Rate**: Error rate > 1% for 5 minutes
2. **High Latency**: p99 latency > 2ms for 5 minutes
3. **Redis Unavailable**: Redis connection failures
4. **Low Availability**: Availability < 99.9% for 5 minutes

### Warning Alerts

1. **High CPU**: CPU > 80% for 10 minutes
2. **High Memory**: Memory > 85% for 10 minutes
3. **High Redis Load**: Redis ops/sec > 80% capacity
4. **Configuration Issues**: Invalid rate limit rules

### Alert Configuration

```yaml
alerts:
  - name: high_error_rate
    condition: error_rate > 0.01
    duration: 5m
    severity: critical
    notification: pagerduty
  
  - name: high_latency
    condition: latency_p99 > 0.002
    duration: 5m
    severity: critical
    notification: pagerduty
  
  - name: redis_unavailable
    condition: redis_connection_failures > 0
    duration: 1m
    severity: critical
    notification: pagerduty
```

## Dashboards

### Operational Dashboard

**Key Panels**:

- Request rate (RPS) over time
- Latency distribution (p50, p95, p99)
- Error rate percentage
- Rate limit decisions (allowed/denied)
- Redis operations per second
- Instance health (CPU, memory)

### Business Dashboard

**Key Panels**:

- Total rate limit checks
- Rate limit violations by rule
- Top rate-limited keys
- Geographic distribution
- Cost metrics

### Performance Dashboard

**Key Panels**:

- Algorithm performance comparison
- Cache hit rates
- Redis latency breakdown
- Connection pool utilization
- Throughput trends

## Health Checks

### Liveness Probe

```python
@app.route("/health/live")
def liveness():
    """Liveness check - is service running?"""
    return {"status": "healthy"}, 200
```

### Readiness Probe

```python
@app.route("/health/ready")
def readiness():
    """Readiness check - can service handle requests?"""
    checks = {
        "redis": check_redis_connection(),
        "database": check_database_connection(),
        "cache": check_cache_health()
    }
    
    if all(checks.values()):
        return {"status": "ready", "checks": checks}, 200
    else:
        return {"status": "not_ready", "checks": checks}, 503
```

## Log Analysis

### Common Queries

**Rate Limit Violations**:

```text
logs | filter allowed == false | group by rule_id | count
```

**High Latency Requests**:

```text
logs | filter latency_ms > 2 | group by rule_id | avg(latency_ms)
```

**Error Patterns**:

```text
logs | filter level == "ERROR" | group by error_type | count
```

### Anomaly Detection

- **Unusual Traffic Patterns**: Detect sudden spikes or drops
- **Latency Anomalies**: Detect latency degradation
- **Error Spikes**: Detect error rate increases
- **Configuration Changes**: Track configuration impact

## Incident Response

### Runbooks

1. **High Error Rate**:
   - Check Redis connectivity
   - Check database connectivity
   - Review recent configuration changes
   - Scale up if needed

2. **High Latency**:
   - Check Redis performance
   - Check instance CPU/memory
   - Review algorithm performance
   - Optimize hot paths

3. **Redis Unavailable**:
   - Check Redis cluster health
   - Failover to backup Redis
   - Enable fail-open mode
   - Scale Redis cluster

### Post-Incident Analysis

- **Root Cause Analysis**: Identify root cause
- **Timeline**: Document incident timeline
- **Impact**: Measure impact (availability, latency)
- **Prevention**: Implement prevention measures
- **Documentation**: Update runbooks

## Summary

Comprehensive observability includes metrics (system, Redis, application), structured logging, distributed tracing, SLIs/SLOs, alerting, dashboards, health checks, and incident response procedures. This enables proactive monitoring, quick issue detection, and effective troubleshooting.
