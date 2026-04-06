# Data Access Flow - Sequence Diagram

## Read Operation with Cache (Phase 3-4)

This diagram shows the flow when reading data with cache-aside pattern.

```mermaid
sequenceDiagram
    participant User
    participant APIGateway
    participant AppService
    participant Cache
    participant Database
    participant ReadReplica

    User->>APIGateway: GET /api/data/{id}
    APIGateway->>AppService: Forward request
    AppService->>Cache: Get data by key
    alt Cache Hit
        Cache-->>AppService: Return cached data
        AppService-->>APIGateway: 200 OK (cached)
        APIGateway-->>User: 200 OK
    else Cache Miss
        Cache-->>AppService: Cache miss
        AppService->>ReadReplica: Query data by id
        ReadReplica-->>AppService: Return data
        AppService->>Cache: Store data in cache (TTL)
        AppService-->>APIGateway: 200 OK
        APIGateway-->>User: 200 OK
    end
```

## Write Operation (Phase 3-4)

```mermaid
sequenceDiagram
    participant User
    participant APIGateway
    participant AppService
    participant PrimaryDB
    participant Cache
    participant MessageQueue

    User->>APIGateway: PUT /api/data/{id}
    APIGateway->>AppService: Forward request
    AppService->>PrimaryDB: Update data
    PrimaryDB-->>AppService: Update successful
    AppService->>Cache: Invalidate cache key
    AppService->>MessageQueue: Publish data.updated event
    AppService-->>APIGateway: 200 OK
    APIGateway-->>User: 200 OK
```

## ASCII Fallback - Read Flow

```text
User    API Gateway   App Service   Cache      Read Replica
 │           │             │           │            │
 │ GET /api/data/{id}      │           │            │
 ├──────────>│             │           │            │
 │           ├────────────>│           │            │
 │           │             │ Get by key│            │
 │           │             ├──────────>│            │
 │           │             │           │            │
 │           │             │ Cache Hit │            │
 │           │             │<──────────┤            │
 │           │             │           │            │
 │           │<────────────┤           │            │
 │<──────────┤             │           │            │
```

## ASCII Fallback - Write Flow

```text
User    API Gateway   App Service   Primary DB   Cache    Message Queue
 │           │             │             │          │            │
 │ PUT /api/data/{id}      │             │          │            │
 ├──────────>│             │             │          │            │
 │           ├────────────>│             │          │            │
 │           │             │ Update data │          │            │
 │           │             ├────────────>│          │            │
 │           │             │<────────────┤          │            │
 │           │             │ Invalidate cache      │            │
 │           │             ├───────────────────────>│            │
 │           │             │ Publish event         │            │
 │           │             ├───────────────────────────────────>│
 │           │<────────────┤             │          │            │
 │<──────────┤             │             │          │            │
```

## Flow Description

### Read Operation (Cache-Aside Pattern)

1. **User requests data** via API Gateway
2. **AppService checks cache** first
3. **If cache hit**: Return cached data immediately
4. **If cache miss**:
   - Query Read Replica database
   - Store result in cache with TTL
   - Return data to user

### Write Operation

1. **User updates data** via API Gateway
2. **AppService writes** to Primary Database
3. **Cache is invalidated** to ensure consistency
4. **Event is published** to Message Queue for downstream processing
5. **Response** is returned to user

## Performance Characteristics

- **Cache Hit**: ~1-5ms latency
- **Cache Miss**: ~10-50ms latency (database query)
- **Write Operation**: ~20-100ms latency (database write + cache invalidation)

## Consistency Considerations

- **Reads from replicas may be eventually consistent**: Replication lag (typically <100ms) means reads might not see latest writes immediately
- **Cache invalidation ensures read-your-writes in most cases**: After writing, cache is invalidated, so subsequent reads from cache miss will hit database
- **Strong consistency can be enforced**: Route reads to primary database when required (e.g., financial transactions, critical data)
- **Trade-off**: Strong consistency reduces read scalability, eventual consistency improves performance

## Phase Differences

- **Phase 1-2**: Direct database access, no cache
- **Phase 3**: Cache-aside pattern with Redis
- **Phase 4**: Multi-layer caching (L1: app cache, L2: Redis, L3: CDN)

## Evaluator Lens

This flow demonstrates:

- **Cache-aside pattern**: Application manages cache, not database
- **Read/write separation**: Reads from replicas, writes to primary
- **Performance optimization**: Cache hits provide sub-millisecond latency
- **Consistency trade-offs**: Balancing performance vs. data freshness
- **Event-driven architecture**: Async processing via message queue

**Common candidate mistakes to avoid**:
- ❌ Forgetting cache invalidation after writes (stale data)
- ❌ Reading from primary for all operations (bottleneck)
- ❌ Not considering replication lag in consistency guarantees
- ❌ Synchronous cache updates (blocks response)
