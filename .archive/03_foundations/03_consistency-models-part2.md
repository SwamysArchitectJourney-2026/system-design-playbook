---
learning_level: "Intermediate"
prerequisites: ["Consistency Models (Part 1)", "CAP theorem basics"]
estimated_time: "25 minutes"
learning_objectives:
  - "Apply consistency decision frameworks to real-world scenarios"
  - "Understand common consistency patterns and their trade-offs"
  - "Choose appropriate consistency models for different use cases"
related_topics:
  prerequisites:
    - ./03_consistency-models-part1.md
  builds_upon:
    - ./03_consistency-models-part1.md
  enables:
    - ../04_principles/04_consistency.md
    - ../05_building-blocks/03_databases-part1.md
  cross_refs: []
---

# Consistency Models (Part 2): Decision Framework and Patterns

## Choosing the Right Consistency Model

### Decision Framework

1. **What happens if data is stale?**
   - Critical (money, medical) → Strong consistency
   - Acceptable (social posts) → Eventual consistency

2. **How often is data updated?**
   - Frequent updates → Consider eventual consistency
   - Rare updates → Strong consistency feasible

3. **Geographic distribution?**
   - Global → Eventual consistency often necessary
   - Single region → Strong consistency possible

4. **Read vs Write ratio?**
   - Read-heavy → Eventual consistency with caching
   - Write-heavy → Consider strong consistency

## Common Patterns

### Pattern 1: Read Your Writes

**Requirement**: After writing, subsequent reads must see your write.

**Solution**: Route reads to the same replica that handled the write, or use strong consistency for user's own data.

**Example**: After posting a comment, you should immediately see it when refreshing the page.

### Pattern 2: Monotonic Reads

**Requirement**: Once you read a value, you never see an older value.

**Solution**: Route all reads for a user to the same replica, or use version numbers.

**Example**: Reading your account balance should never show a lower amount than you saw before.

### Pattern 3: Session Consistency

**Requirement**: Consistency guarantees within a user session.

**Solution**: Sticky sessions, or route user's requests to same replica.

**Example**: Shopping cart updates should be immediately visible within your session.

## Real-World Examples

### Strong Consistency: Financial Systems

**Use Case**: Bank account balances

**Why**: Money must be accurate immediately. Can't allow double-spending.

**Trade-off**: Higher latency, but correctness is critical.

### Eventual Consistency: Social Media

**Use Case**: Like counts, follower counts

**Why**: Acceptable if it takes a few seconds to propagate globally.

**Trade-off**: Temporary inconsistencies, but high availability and low latency.

### Causal Consistency: Chat Applications

**Use Case**: Message ordering

**Why**: Replies must appear after original message, but unrelated messages can be in any order.

**Trade-off**: More complex than eventual, but preserves important relationships.

## Key Takeaways

1. **Consistency is a spectrum** - from strong to eventual
2. **CAP theorem** - can't have all three (C, A, P)
3. **PACELC** - considers normal operation too
4. **Choose based on requirements** - what's acceptable for your use case
5. **Trade-offs are inevitable** - consistency vs availability vs latency

---

*Previous: [Consistency Models (Part 1)](./03_consistency-models-part1.md)*  
*Next: Learn about [Failure Models](./04_failure-models-part1.md) or explore [Consistency Principles](../04_principles/04_consistency.md).*

