# URL Shortener - Trade-offs

## Design Decisions and Trade-offs

### Token Service vs Centralized Counter

**Centralized Counter (Redis) Approach**:

- ✅ Simple implementation
- ❌ Single point of failure
- ❌ Performance bottleneck (all instances hit same Redis)
- ❌ Difficult to scale beyond single Redis capacity

**Token Range Assignment Approach**:

- ✅ No single point of failure (Token Service can be replicated)
- ✅ Better performance (instances work independently)
- ✅ Scales horizontally (add more service instances)
- ❌ Slight complexity in range management
- ❌ Token loss on service crashes (acceptable given scale)

**Decision**: Token range assignment provides better scalability and availability.

### Database Choice: Cassandra vs MySQL

**Cassandra**:

- ✅ Built-in horizontal scalability
- ✅ Optimized for high write throughput
- ✅ No sharding management required
- ❌ Eventual consistency (acceptable for URL mappings)
- ❌ Less familiar to some teams

**MySQL (Sharded)**:

- ✅ Strong consistency guarantees
- ✅ Familiar technology for most teams
- ✅ Mature ecosystem
- ❌ Requires manual sharding and management
- ❌ More operational complexity

**Decision**: Cassandra chosen for scalability, but MySQL is viable alternative with proper sharding.

### Analytics: Synchronous vs Asynchronous

**Synchronous Analytics**:

- ✅ No data loss
- ❌ Increases redirect latency
- ❌ Impacts user experience

**Asynchronous Analytics (Chosen)**:

- ✅ Zero impact on redirect latency
- ✅ Better user experience
- ❌ Potential data loss on service crashes
- ❌ Eventual consistency in analytics

**Decision**: Asynchronous analytics preferred for non-critical metrics. Acceptable to lose some events for better performance.

### Batching Strategy: Per-Request vs Batched

**Per-Request Publishing**:

- ✅ No data loss
- ❌ High I/O overhead
- ❌ Impacts latency

**Batched Publishing (Chosen)**:

- ✅ Reduced I/O operations
- ✅ Better performance
- ❌ Potential loss of multiple events on crash
- ❌ Slight delay in analytics availability

**Decision**: Batching preferred for analytics. Loss of 10-30 events acceptable for better system performance.

### Token Loss on Service Crashes

**Problem**: If service crashes after receiving token range, unused tokens are lost.

**Option 1: Accept Token Loss (Chosen)**:

- ✅ Simple design
- ✅ No additional tracking overhead
- ❌ Wastes some tokens

**Option 2: Track Used Tokens**:

- ✅ No token waste
- ❌ Significant complexity
- ❌ Additional database operations
- ❌ Defeats purpose of range assignment

**Decision**: Accept token loss. With 3.5 trillion possible URLs (7 characters), losing thousands of tokens is negligible.

### Cache Strategy: Write-Through vs Write-Behind

**Write-Through**:

- ✅ Cache always consistent with database
- ✅ Simpler invalidation logic
- ❌ Slightly higher write latency

**Write-Behind**:

- ✅ Lower write latency
- ❌ Cache inconsistency risk
- ❌ More complex invalidation

**Decision**: Write-through for simplicity and consistency.

## Alternative Architectures

### Hash-Based Short URL Generation

**Approach**: Hash long URL to generate short URL (e.g., MD5, SHA-256)

**Pros**:

- No token service needed
- Deterministic (same long URL → same short URL)

**Cons**:

- Hash collisions require handling
- Cannot customize short URLs
- Difficult to ensure uniqueness without checking database

**When to Use**: Suitable for smaller scale or when determinism is required.

### Database Auto-Increment

**Approach**: Use database auto-increment feature to generate unique IDs

**Pros**:

- Simple implementation
- Guaranteed uniqueness

**Cons**:

- Database becomes bottleneck
- Difficult to scale horizontally
- Single point of failure

**When to Use**: Only for very small scale systems.

## Summary

The chosen architecture prioritizes:

1. **Scalability**: Horizontal scaling of all components
2. **Availability**: No single points of failure
3. **Performance**: Low latency for redirects
4. **Simplicity**: Acceptable trade-offs to keep design manageable

Key trade-offs accepted:

- Token loss on crashes (negligible impact)
- Asynchronous analytics (acceptable data loss)
- Eventual consistency in database (acceptable for URL mappings)

## Evaluator Lens

This case study demonstrates:

- **Problem optimization**: Optimizes for read-heavy workload (100:1 read/write ratio) with low-latency redirects
- **Intentional non-optimization**: Analytics are asynchronous (not optimized for real-time), token loss accepted (not optimized for perfect efficiency)
- **What breaks first at scale**: Database becomes bottleneck → solved with caching; cache becomes bottleneck → solved with CDN; token service becomes bottleneck → solved with range pre-allocation

**What signals senior-level thinking**:
- ✅ Explicit trade-off discussion (not just listing features)
- ✅ Understanding that perfect solutions don't exist
- ✅ Accepting reasonable losses (token loss, analytics events) for simplicity
- ✅ Evolution thinking (start simple, scale as needed)
- ✅ Clear rationale for each decision

**Common candidate mistakes to avoid**:
- ❌ Over-engineering (e.g., tracking every token to prevent loss)
- ❌ Ignoring trade-offs (not discussing what's sacrificed)
- ❌ Premature optimization (e.g., microservices from day 1)
- ❌ Not considering failure scenarios
- ❌ Ignoring cost implications

**Evaluation criteria**:
- **Senior Level**: Can design system, discuss trade-offs, handle scale
- **Staff Level**: Can explain why each decision was made, what breaks first, how to evolve
- **Architect Level**: Can design for multiple failure modes, optimize for business goals, balance competing concerns

---

*This completes the URL Shortener case study. Review [Requirements](./01_requirements.md) for functional requirements, [Back-of-Envelope](./02_back-of-envelope.md) for capacity planning, [Observability](./06_observability.md) for monitoring and failure scenarios, and [Security](./07_security.md) for security considerations.*
