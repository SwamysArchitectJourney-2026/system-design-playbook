---
learning_level: "Intermediate"
prerequisites: ["Failure Models (Part 1)", "Basic understanding of distributed systems"]
estimated_time: "25 minutes"
learning_objectives:
  - "Apply failure recovery strategies in system design"
  - "Design systems that gracefully handle different failure types"
  - "Implement fault tolerance patterns"
related_topics:
  prerequisites:
    - ./04_failure-models-part1.md
  builds_upon:
    - ./04_failure-models-part1.md
  enables:
    - ../04_principles/05_fault-tolerance.md
    - ../08_failures/01_introduction.md
  cross_refs: []
---

# Failure Models (Part 2): Recovery Strategies and Design Patterns

## Failure Recovery Strategies

### Strategy 1: Retry with Exponential Backoff

**How it works**:
- Retry failed operation with increasing delays
- Delay = base_delay × 2^attempt_number
- Example: 100ms, 200ms, 400ms, 800ms...

**When to use**:
- Transient failures (network issues, temporary overload)
- Idempotent operations (safe to retry)

**Trade-offs**:
- ✅ Handles transient failures automatically
- ❌ Increases latency for persistent failures
- ❌ Can amplify load on failing service

### Strategy 2: Circuit Breaker

**How it works**:
- Monitor failure rate
- If failures exceed threshold, "open" circuit
- Fail fast instead of waiting for timeout
- Periodically attempt to "close" circuit

**States**:
- **Closed**: Normal operation
- **Open**: Failing fast, not calling service
- **Half-Open**: Testing if service recovered

**When to use**:
- Downstream service failures
- Cascading failure prevention
- Resource protection

### Strategy 3: Graceful Degradation

**How it works**:
- System continues operating with reduced functionality
- Fallback to simpler behavior or cached data

**Example**:
- Recommendation service down → show default recommendations
- Search service down → show cached results

**When to use**:
- Non-critical features
- Better than complete failure
- User experience priority

### Strategy 4: Failover

**How it works**:
- Automatically switch to backup when primary fails
- Can be automatic or manual

**Types**:
- **Active-Passive**: Backup ready but not serving traffic
- **Active-Active**: All instances serve traffic

**When to use**:
- Critical components
- High availability requirements
- Database primary/replica setups

## Design Patterns for Failure Handling

### Pattern 1: Timeout and Retry

**Implementation**:
- Set reasonable timeouts
- Retry transient failures
- Give up after max attempts

**Example**:
```python
max_retries = 3
timeout = 5  # seconds
for attempt in range(max_retries):
    try:
        result = service.call(timeout=timeout)
        return result
    except TimeoutError:
        if attempt < max_retries - 1:
            sleep(2 ** attempt)  # exponential backoff
        else:
            raise
```

### Pattern 2: Bulkhead Isolation

**Concept**: Isolate failures to prevent cascading.

**Implementation**:
- Separate thread pools per service
- Resource limits per component
- Independent failure domains

**Example**: User service failures don't affect payment service.

### Pattern 3: Health Checks and Monitoring

**Implementation**:
- Periodic health check endpoints
- Monitor key metrics (latency, error rate)
- Alert on anomalies

**Benefits**:
- Early failure detection
- Proactive recovery
- Better observability

## Key Takeaways

1. **Failures are expected** - design for them, don't ignore them
2. **Retry transient failures** - but not permanent ones
3. **Use circuit breakers** - prevent cascading failures
4. **Graceful degradation** - better than complete failure
5. **Monitor everything** - detect failures early

---

*Previous: [Failure Models (Part 1)](./04_failure-models-part1.md)*  
*Next: Learn about [Fault Tolerance](../04_principles/05_fault-tolerance.md) or explore [Real-World Failures](../08_failures/01_introduction.md).*
