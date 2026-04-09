# Distributed Rate Limiting - Sequence Diagram

## Distributed Rate Limiting Sequence

This diagram shows how multiple rate limiter instances maintain consistent rate limits.

```mermaid
sequenceDiagram
    participant Client1 as Client 1
    participant Client2 as Client 2
    participant RL1 as Rate Limiter Instance 1
    participant RL2 as Rate Limiter Instance 2
    participant Redis as Redis Cluster

    Note over Client1,Redis: Both clients use same rate limit key

    Client1->>RL1: Rate limit check (key: user123)
    RL1->>Redis: GET ratelimit:user:user123:rule_001
    Redis-->>RL1: Counter: 5, Limit: 100
    
    RL1->>RL1: Check: 5 < 100? Yes
    RL1->>Redis: INCR ratelimit:user:user123:rule_001
    Redis-->>RL1: New count: 6
    RL1-->>Client1: Allowed (remaining: 94)
    
    Client2->>RL2: Rate limit check (key: user123)
    RL2->>Redis: GET ratelimit:user:user123:rule_001
    Redis-->>RL2: Counter: 6, Limit: 100
    
    RL2->>RL2: Check: 6 < 100? Yes
    RL2->>Redis: INCR ratelimit:user:user123:rule_001
    Redis-->>RL2: New count: 7
    RL2-->>Client2: Allowed (remaining: 93)
    
    Note over Client1,Redis: Both instances see consistent counter
    
    Client1->>RL1: Rate limit check (key: user123)
    RL1->>Redis: GET ratelimit:user:user123:rule_001
    Redis-->>RL1: Counter: 7, Limit: 100
    
    RL1->>RL1: Check: 7 < 100? Yes
    RL1->>Redis: INCR ratelimit:user:user123:rule_001
    Redis-->>RL1: New count: 8
    RL1-->>Client1: Allowed (remaining: 92)
```

## ASCII Fallback

```text
Client 1   Client 2   RL Instance 1   RL Instance 2   Redis Cluster
   │          │            │               │              │
   │          │            │               │              │
   │ Check    │            │               │              │
   ├─────────>│            │               │              │
   │          │            │ GET counter   │              │
   │          │            ├───────────────┼─────────────>│
   │          │            │               │              │
   │          │            │<──────────────┼──────────────┤
   │          │            │ Counter: 5    │              │
   │          │            │               │              │
   │          │            │ INCR          │              │
   │          │            ├───────────────┼─────────────>│
   │          │            │<──────────────┼──────────────┤
   │          │            │ New: 6        │              │
   │          │<───────────┤               │              │
   │          │            │               │              │
   │          │ Check      │               │              │
   │          ├───────────────────────────>│              │
   │          │            │               │ GET counter  │
   │          │            │               ├─────────────>│
   │          │            │               │<─────────────┤
   │          │            │               │ Counter: 6   │
   │          │            │               │              │
   │          │            │               │ INCR         │
   │          │            │               ├─────────────>│
   │          │            │               │<─────────────┤
   │          │            │               │ New: 7      │
   │          │<───────────────────────────┤              │
```

## Flow Description

1. **Multiple instances** share same Redis cluster
2. **All instances** read/write to same counter key
3. **Redis atomic operations** ensure consistency
4. **Counter increments** are atomic across instances
5. **Consistent rate limiting** across all instances

## Consistency Guarantees

- **Atomic Operations**: Redis INCR is atomic
- **Single Source of Truth**: Redis is authoritative
- **Eventual Consistency**: Small window acceptable
- **Accuracy**: ±1% accuracy acceptable

## Benefits

- **Distributed**: Works across multiple instances
- **Consistent**: Same limits enforced everywhere
- **Scalable**: Add more instances easily
- **Simple**: No complex synchronization needed
