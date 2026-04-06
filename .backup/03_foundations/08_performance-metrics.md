---
learning_level: "Beginner"
prerequisites: ["Basic understanding of system design", "Familiarity with measurements"]
estimated_time: "25 minutes"
learning_objectives:
  - "Understand percentile metrics (p90, p95, p99) and why they matter"
  - "Differentiate between latency and throughput"
  - "Calculate request rates and understand QPS vs RPS"
  - "Relate concurrent users to requests per second"
related_topics:
  prerequisites: []
  builds_upon:
    - ./05_back-of-envelope-part1.md
  enables:
    - ../04_principles/01_availability.md
    - ../04_principles/02_reliability.md
    - ../05_building-blocks/02_load-balancers.md
    - ../07_case-studies/01-scalefromzerotomillonusers/02_back-of-envelope-part1.md
  cross_refs: []
---

# Performance Metrics in System Design

Understanding performance metrics is essential for designing, monitoring, and optimizing systems. This module covers the key metrics you'll use throughout system design.

---

## Understanding Percentile Metrics

### What Are Percentiles?

Percentiles divide a dataset into 100 equal parts. In system design, we use percentiles to understand **response time distribution** and identify tail latency.

**Common Percentiles**:
- **p50 (median)**: 50% of requests finish in this time or less
- **p90 (90th percentile)**: 90% of requests finish in this time or less
- **p95 (95th percentile)**: 95% of requests finish in this time or less
- **p99 (99th percentile)**: 99% of requests finish in this time or less

### p90 and p95 Explained

**p90 (90th percentile)**:
- 90% of requests finish in at most this time
- The slowest 10% take longer
- Useful for understanding typical user experience

**p95 (95th percentile)**:
- 95% of requests finish in at most this time
- The slowest 5% take longer
- Commonly used in SLAs because it captures most user experience while ignoring extreme outliers

**Example**:
If p90 = 200 ms and p95 = 400 ms:
- 90% of requests are ≤ 200 ms
- 95% of requests are ≤ 400 ms
- The "tail" between p90 and p95 reflects slower outliers (5% of requests take 200-400ms)

### Why Percentiles Matter

**Averages Can Hide Problems**:
- Average latency might be 100ms, but if p95 is 2 seconds, many users experience slow responses
- Averages are skewed by outliers (one very slow request affects the average)

**Percentiles Show Real User Experience**:
- p95 shows what 95% of users actually experience
- Helps identify "tail latency" that real users feel
- Critical for understanding performance under load or during incidents

**Industry Standard**:
- p95 is commonly used in SLAs (Service Level Agreements)
- p99 is used for critical systems where even 1% of slow requests matter
- p50 (median) shows typical performance but doesn't capture outliers

---

## Latency vs Throughput

### Latency

**Definition**: The time it takes to complete a single request

**Characteristics**:
- Measured in milliseconds (ms) or seconds
- Lower is better
- Represents user-perceived performance

**Example**:
- p95 latency = 400 ms means 95% of requests finish in ≤ 400 ms
- Users experience this as "how fast the system feels"

**Components of Latency**:
- Processing time (application logic)
- Network latency (data transmission)
- Database query time
- Cache lookup time
- Queue wait time

### Throughput

**Definition**: The number of requests processed per second

**Characteristics**:
- Measured in requests per second (RPS) or queries per second (QPS)
- Higher is better
- Represents system capacity

**Example**:
- 1,000 requests/second means the system can handle 1,000 requests in one second
- Represents "how much work the system can do"

### Relationship Between Latency and Throughput

**High Latency Reduces Effective Throughput**:
- If requests take too long, they queue up
- System can't process new requests while waiting for old ones
- Example: 1 second latency means max 1 request/second per connection

**High Throughput with Low Latency is Ideal**:
- System processes many requests quickly
- Users experience fast responses
- System handles high load efficiently

**Trade-offs**:
- **Batching**: Increases latency (wait to batch) but improves throughput (process multiple items)
- **Async Processing**: Accepts higher latency for some requests to improve overall throughput
- **Caching**: Reduces latency (faster responses) and improves throughput (less database load)

---

## Number of Seconds per Request

### Calculation

**Formula**: Average time per request = 1 / Throughput (when system is at capacity)

**Example 1**:
- System handles 1,000 requests/second
- Average time per request = 1 / 1,000 = 0.001 seconds = 1 ms

**Example 2**:
- System handles 100 requests/second
- Average time per request = 1 / 100 = 0.01 seconds = 10 ms

### Important Notes

**Theoretical vs Actual**:
- This calculation gives theoretical maximum throughput
- Actual latency includes many factors:
  - Processing time
  - Network latency
  - Database query time
  - Cache lookup time
  - Queue wait time

**Real-World Latency**:
- Even if system can handle 1,000 QPS, individual requests might take 50-200ms
- The 1ms calculation is the minimum time if system is perfectly efficient
- Actual latency = processing time + wait time + network time

---

## Concurrent Users vs Requests per Second

### Definitions

**Concurrent Users**: Number of users actively using the system at the same time

**Requests per Second (RPS)**: Number of requests the system processes per second

### Key Insight

**Not all concurrent users make requests simultaneously**:
- Users have "think time" between requests
- Users read content, fill forms, navigate pages
- Only a fraction of concurrent users are actively making requests at any moment

### Formula

```
RPS = (Concurrent Users × Requests per User per Session) / Average Session Duration
```

### Example

**Scenario**:
- 10,000 concurrent users
- Each user makes 5 requests per 10-minute session
- Average session duration = 10 minutes = 600 seconds

**Calculation**:
```
RPS = (10,000 × 5) / 600
    = 50,000 / 600
    ≈ 83 requests/second
```

**Interpretation**:
- 10,000 concurrent users generate only ~83 requests/second
- This is much lower than if all users made requests simultaneously
- Design for this actual load, not the theoretical maximum

### Peak vs Average

**Peak RPS**:
- Can be 2-5x higher than average RPS
- Occurs during traffic spikes (product launches, viral content, peak hours)
- Must design for peak, not average

**Design Strategy**:
- Calculate average RPS from concurrent users
- Multiply by 3-5x for peak traffic
- Design system to handle peak load

---

## QPS vs Requests per Second

### Are They the Same?

**QPS (Queries Per Second)** and **RPS (Requests Per Second)** are often used interchangeably. Both measure the number of requests a system can handle in one second.

### Subtle Differences

**QPS (Queries Per Second)**:
- Often used for database queries or search operations
- Focuses on data retrieval operations
- Example: "Database handles 10,000 QPS"

**RPS (Requests Per Second)**:
- More general term for any HTTP/API requests
- Includes all types of operations (read, write, update, delete)
- Example: "API handles 10,000 RPS"

### Usage in System Design

**When to Use QPS**:
- Discussing database load
- Talking about search operations
- Measuring data retrieval performance

**When to Use RPS**:
- Discussing API/HTTP traffic
- Measuring overall system capacity
- General request rate discussions

**In Practice**:
- Both represent the same concept: request rate
- Choose based on context (database vs API)
- Don't overthink the distinction - they're functionally equivalent

---

## Key Takeaways

1. **Percentiles (p90, p95, p99) show real user experience** - Use them instead of averages to understand performance

2. **Latency is user-perceived speed** - Lower is better, measured in milliseconds

3. **Throughput is system capacity** - Higher is better, measured in requests per second

4. **Latency and throughput are related** - High latency reduces effective throughput

5. **Concurrent users ≠ simultaneous requests** - Users have think time, so RPS is much lower than concurrent users

6. **Design for peak, not average** - Peak RPS can be 2-5x higher than average

7. **QPS and RPS are essentially the same** - Use QPS for databases, RPS for APIs, but they measure the same thing

---

*Next: Apply these metrics in [Availability Principles](../04_principles/01_availability.md) or explore [Back-of-Envelope Calculations](./05_back-of-envelope-part1.md).*

