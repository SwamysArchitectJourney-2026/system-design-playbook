---
learning_level: "Intermediate"
prerequisites: ["System design fundamentals", "Basic understanding of distributed systems"]
estimated_time: "25 minutes"
learning_objectives:
  - "Understand availability metrics and how to calculate them"
  - "Design systems for high availability"
  - "Apply redundancy and failover strategies"
related_topics:
  prerequisites:
    - ../03_foundations/04_failure-models-part1.md
  builds_upon:
    - ../03_foundations/04_failure-models-part1.md
  enables:
    - ./05_fault-tolerance.md
    - ../05_building-blocks/02_load-balancers.md
  cross_refs: []
---

# Availability in System Design

## What Is Availability?

Availability measures **how often a system is operational and accessible** to users. It's expressed as a percentage of uptime over a given period.

## Availability Metrics

### The "Nines"

Availability is commonly expressed in "nines":

| Availability | Downtime per Year | Downtime per Month |
|--------------|-------------------|-------------------|
| 99% (two nines) | 3.65 days | 7.2 hours |
| 99.9% (three nines) | 8.76 hours | 43.2 minutes |
| 99.99% (four nines) | 52.56 minutes | 4.32 minutes |
| 99.999% (five nines) | 5.26 minutes | 25.9 seconds |

### Calculating Availability

```
Availability = (Total Time - Downtime) / Total Time × 100%
```

**Example**:
- System runs for 365 days
- Experiences 8 hours of downtime
- Availability = (365 days - 8 hours) / 365 days = 99.9%

## Factors Affecting Availability

### 1. Hardware Failures

**Impact**: Server crashes, disk failures, network equipment failures

**Mitigation**: 
- Redundant hardware
- Hot spares
- Automatic failover

### 2. Software Failures

**Impact**: Bugs, crashes, memory leaks

**Mitigation**:
- Code quality and testing
- Graceful error handling
- Automatic restarts

### 3. Network Issues

**Impact**: Connectivity problems, DNS failures, routing issues

**Mitigation**:
- Multiple network paths
- CDN for static content
- Geographic distribution

### 4. Human Error

**Impact**: Configuration mistakes, deployment errors, accidental deletions

**Mitigation**:
- Automation
- Code reviews
- Staged rollouts

## Design Patterns for High Availability

### Pattern 1: Redundancy

**Concept**: Deploy multiple instances of critical components.

**Types**:
- **Active-Active**: All instances handle traffic
- **Active-Passive**: Backup instances ready to take over

**Example**: Multiple application servers behind a load balancer.

### Pattern 2: Failover

**Concept**: Automatically switch to backup when primary fails.

**Types**:
- **Automatic**: System detects and switches automatically
- **Manual**: Requires human intervention

**Example**: Primary database fails → automatically route to replica.

### Pattern 3: Health Checks

**Concept**: Continuously monitor component health.

**Implementation**:
- Periodic health check endpoints
- Heartbeat mechanisms
- External monitoring

**Example**: Load balancer checks `/health` endpoint every 5 seconds.

### Pattern 4: Graceful Degradation

**Concept**: System continues operating with reduced functionality.

**Example**: Recommendation service down → show default recommendations instead of failing entire page.

## Availability vs Reliability

**Availability**: System is up and accessible
- Focus: Uptime percentage
- Question: "Is the system running?"

**Reliability**: System performs correctly when running
- Focus: Correctness of operations
- Question: "Does the system work correctly?"

**Relationship**: A system can be available but unreliable (running but returning wrong results).

## Key Takeaways

1. **Availability is measured in "nines"** - each nine significantly reduces downtime
2. **Redundancy is essential** - single points of failure kill availability
3. **Failover enables recovery** - automatic switching maintains uptime
4. **Monitor everything** - detect issues before they cause downtime
5. **Plan for failures** - they will happen, design accordingly

---

*Next: Learn about [Reliability](./02_reliability.md) or explore [Fault Tolerance](./05_fault-tolerance.md).*
