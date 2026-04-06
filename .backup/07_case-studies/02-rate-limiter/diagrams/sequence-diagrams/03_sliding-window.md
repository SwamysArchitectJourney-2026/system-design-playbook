# Sliding Window Algorithm - Sequence Diagram

## Sliding Window Implementation Sequence

This diagram shows the detailed flow of the sliding window rate limiting algorithm.

```mermaid
sequenceDiagram
    participant Client
    participant RateLimiter as Rate Limiter Service
    participant Redis as Redis Cluster

    Note over Client,Redis: Window: 60 seconds, Limit: 10 requests

    Client->>RateLimiter: Request 1 (t=0s)
    RateLimiter->>Redis: ZREMRANGEBYSCORE key 0 (now-60)
    Redis-->>RateLimiter: Removed old entries
    RateLimiter->>Redis: ZCARD key
    Redis-->>RateLimiter: Count: 0
    RateLimiter->>RateLimiter: Check: 0 < 10? Yes
    RateLimiter->>Redis: ZADD key {request_id_1: timestamp_0}
    Redis-->>RateLimiter: Added
    RateLimiter->>Redis: EXPIRE key 60
    RateLimiter-->>Client: Allowed (remaining: 9)

    Note over Client,Redis: 5 seconds later

    Client->>RateLimiter: Request 2 (t=5s)
    RateLimiter->>Redis: ZREMRANGEBYSCORE key 0 (now-60)
    Redis-->>RateLimiter: Removed entries before t=-55s
    RateLimiter->>Redis: ZCARD key
    Redis-->>RateLimiter: Count: 1
    RateLimiter->>RateLimiter: Check: 1 < 10? Yes
    RateLimiter->>Redis: ZADD key {request_id_2: timestamp_5}
    Redis-->>RateLimiter: Added
    RateLimiter-->>Client: Allowed (remaining: 8)

    Note over Client,Redis: 10 requests made quickly

    Client->>RateLimiter: Request 11 (t=10s)
    RateLimiter->>Redis: ZREMRANGEBYSCORE key 0 (now-60)
    Redis-->>RateLimiter: Removed entries before t=-50s
    RateLimiter->>Redis: ZCARD key
    Redis-->>RateLimiter: Count: 10
    RateLimiter->>RateLimiter: Check: 10 < 10? No
    RateLimiter-->>Client: Denied (429 Too Many Requests)

    Note over Client,Redis: 30 seconds later, some requests expired

    Client->>RateLimiter: Request 12 (t=40s)
    RateLimiter->>Redis: ZREMRANGEBYSCORE key 0 (now-60)
    Redis-->>RateLimiter: Removed entries before t=-20s (requests 1-4)
    RateLimiter->>Redis: ZCARD key
    Redis-->>RateLimiter: Count: 6
    RateLimiter->>RateLimiter: Check: 6 < 10? Yes
    RateLimiter->>Redis: ZADD key {request_id_12: timestamp_40}
    Redis-->>RateLimiter: Added
    RateLimiter-->>Client: Allowed (remaining: 3)
```

## ASCII Fallback

```text
Client    Rate Limiter   Redis Cluster
  │            │              │
  │ Request 1 (t=0s)          │
  ├───────────>│              │
  │            │ Remove old   │
  │            ├─────────────>│
  │            │<─────────────┤
  │            │ Count: 0     │
  │            ├─────────────>│
  │            │<─────────────┤
  │            │ Add request  │
  │            ├─────────────>│
  │<───────────┤              │
  │            │              │
  │ Request 2 (t=5s)          │
  ├───────────>│              │
  │            │ Remove old   │
  │            ├─────────────>│
  │            │<─────────────┤
  │            │ Count: 1     │
  │            ├─────────────>│
  │            │<─────────────┤
  │            │ Add request  │
  │            ├─────────────>│
  │<───────────┤              │
  │            │              │
  │ Request 11 (t=10s)         │
  ├───────────>│              │
  │            │ Remove old   │
  │            ├─────────────>│
  │            │<─────────────┤
  │            │ Count: 10    │
  │            ├─────────────>│
  │            │<─────────────┤
  │            │ Over limit   │
  │<───────────┤              │
  │ Denied     │              │
```

## Flow Description

1. **Remove Old Entries**: Remove requests outside the sliding window
2. **Count Current Requests**: Count requests within the window
3. **Check Limit**: Compare count with limit
4. **Add Request**: If under limit, add current request
5. **Set TTL**: Set expiration to window duration

## Key Operations

### ZREMRANGEBYSCORE

Removes entries with scores (timestamps) outside the window:

```text
ZREMRANGEBYSCORE key 0 (current_time - window_seconds)
```

### ZCARD

Counts current entries in the sorted set:

```text
ZCARD key
```

### ZADD

Adds current request with timestamp as score:

```text
ZADD key {request_id: current_timestamp}
```

### EXPIRE

Sets TTL for automatic cleanup:

```text
EXPIRE key window_seconds
```

## Advantages

- **Accurate**: Precise rate limiting within window
- **No Burst**: No burst at window boundary
- **Smooth**: Continuous sliding window

## Trade-offs

- **Memory**: More memory for sorted sets
- **Complexity**: More complex operations
- **Latency**: Slightly higher latency than fixed window
