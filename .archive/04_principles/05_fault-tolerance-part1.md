---
learning_level: "Intermediate"
prerequisites: ["Failure Models", "Availability basics"]
estimated_time: "25 minutes"
learning_objectives:
  - "Design systems that continue operating despite component failures"
  - "Apply redundancy and failover strategies"
  - "Implement graceful degradation and recovery mechanisms"
related_topics:
  prerequisites:
    - ../03_foundations/04_failure-models-part1.md
    - ./01_availability.md
  builds_upon:
    - ../03_foundations/04_failure-models-part1.md
    - ./01_availability.md
  enables:
    - ../05_building-blocks/02_load-balancers.md
    - ../06_patterns/03_circuit-breaker.md
  cross_refs: []
---

# Fault Tolerance in System Design

## What Is Fault Tolerance?

Fault tolerance is the ability of a system to **continue operating correctly** even when some components fail. Unlike fault prevention (trying to avoid failures), fault tolerance assumes failures will happen and designs systems to handle them gracefully.

## Fault vs Failure

### Fault

**Definition**: A defect or error in a component.

**Example**: Bug in code, hardware defect, configuration error.

**Status**: May not cause immediate failure.

### Failure

**Definition**: System stops providing required service.

**Example**: Service crashes, database becomes unavailable, network partition.

**Status**: Users are affected.

**Relationship**: Faults can lead to failures if not handled.

## Fault Tolerance Strategies

### Strategy 1: Redundancy

**Concept**: Deploy multiple instances of critical components.

**Types**:
- **Active-Active**: All instances handle traffic
- **Active-Passive**: Backup instances ready to take over
- **N+1 Redundancy**: N instances needed, deploy N+1

**Example**: Multiple application servers behind load balancer.

**Trade-offs**:
- ✅ High availability
- ✅ Load distribution
- ❌ Higher cost
- ❌ More complexity

### Strategy 2: Failover

**Concept**: Automatically switch to backup when primary fails.

**Types**:
- **Automatic**: System detects and switches automatically
- **Manual**: Requires human intervention
- **Hot Standby**: Backup ready immediately
- **Cold Standby**: Backup needs time to start

**Example**: Primary database fails → automatically route to replica.

**Trade-offs**:
- ✅ Maintains service during failures
- ✅ Transparent to users
- ❌ Failover time (brief downtime)
- ❌ Data synchronization complexity

### Strategy 3: Graceful Degradation

**Concept**: System continues operating with reduced functionality.

**Approach**:
- Disable non-critical features
- Return cached data
- Show simplified UI
- Continue core functionality

**Example**: Recommendation service down → show default recommendations instead of failing entire page.

**Trade-offs**:
- ✅ System remains usable
- ✅ Better user experience than complete failure
- ❌ Reduced functionality
- ❌ May need to explain to users

### Strategy 4: Error Recovery

**Concept**: Automatically recover from errors without user intervention.

**Mechanisms**:
- **Retry**: Transient errors → retry with backoff
- **Circuit Breaker**: Stop calling failing service
- **Rollback**: Revert to previous working state
- **Checkpoint/Restart**: Save state, restart from checkpoint

**Example**: Network timeout → retry with exponential backoff → succeed on 3rd attempt.

## Design Patterns for Fault Tolerance

### Pattern 1: Health Checks

**Concept**: Continuously monitor component health.

**Implementation**:
- Periodic health check endpoints
- Heartbeat mechanisms
- External monitoring services

**Action on Failure**: Remove from load balancer, trigger alerts, initiate failover.

### Pattern 2: Timeouts

**Concept**: Don't wait forever for responses.

**Implementation**:
- Set reasonable timeouts for all external calls
- Fail fast instead of hanging
- Use different timeouts for different operations

**Example**: API call timeout after 5 seconds → return error instead of waiting indefinitely.

### Pattern 3: Circuit Breaker

**Concept**: Stop calling failing service after threshold.

**States**:
- **Closed**: Normal operation
- **Open**: Failing, don't call
- **Half-Open**: Testing if fixed

**Example**: Database repeatedly timing out → open circuit → stop sending queries → test after 30s → close if healthy.

---

*Next: Continue with [Fault Tolerance in Practice](./05_fault-tolerance-part2.md).*
