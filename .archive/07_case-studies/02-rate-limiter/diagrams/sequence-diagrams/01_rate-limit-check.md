# Rate Limit Check Flow - Sequence Diagram

## Rate Limit Check Sequence

This diagram shows the flow when a client requests a rate limit check.

```mermaid
sequenceDiagram
    participant Client
    participant APIGateway as API Gateway
    participant RateLimiter as Rate Limiter Service
    participant Cache as Local Cache
    participant ConfigService as Configuration Service
    participant Redis as Redis Cluster
    participant Metrics as Metrics Service

    Client->>APIGateway: POST /api/v1/rate-limit/check
    APIGateway->>APIGateway: Authenticate request
    APIGateway->>RateLimiter: Forward rate limit check
    
    RateLimiter->>Cache: Get rate limit rule (rule_id)
    
    alt Cache Hit
        Cache-->>RateLimiter: Return cached rule
    else Cache Miss
        RateLimiter->>ConfigService: Get rate limit rule
        ConfigService-->>RateLimiter: Return rule
        RateLimiter->>Cache: Store rule in cache
    end
    
    RateLimiter->>RateLimiter: Build rate limit key
    RateLimiter->>Redis: Get current counter state
    
    alt Algorithm: Token Bucket
        RateLimiter->>RateLimiter: Calculate token refill
        RateLimiter->>RateLimiter: Check if token available
        alt Token Available
            RateLimiter->>Redis: Decrement token (atomic)
            Redis-->>RateLimiter: Success
            RateLimiter-->>APIGateway: Allowed (200 OK)
        else No Token
            RateLimiter-->>APIGateway: Denied (429 Too Many Requests)
        end
    else Algorithm: Sliding Window
        RateLimiter->>Redis: Remove old requests (ZREMRANGEBYSCORE)
        RateLimiter->>Redis: Count current requests (ZCARD)
        alt Under Limit
            RateLimiter->>Redis: Add current request (ZADD)
            RateLimiter-->>APIGateway: Allowed (200 OK)
        else Over Limit
            RateLimiter-->>APIGateway: Denied (429 Too Many Requests)
        end
    else Algorithm: Fixed Window
        RateLimiter->>Redis: Increment counter (INCR)
        alt Under Limit
            RateLimiter->>Redis: Set TTL if first request
            RateLimiter-->>APIGateway: Allowed (200 OK)
        else Over Limit
            RateLimiter-->>APIGateway: Denied (429 Too Many Requests)
        end
    end
    
    RateLimiter->>Metrics: Record rate limit check (async)
    APIGateway-->>Client: Response with rate limit headers
```

## ASCII Fallback

```text
Client    API Gateway   Rate Limiter   Cache    Config Service   Redis    Metrics
  │            │              │          │            │            │         │
  │ POST /rate-limit/check   │          │            │            │         │
  ├───────────>│              │          │            │            │         │
  │            │ Authenticate │          │            │            │         │
  │            ├─────────────>│          │            │            │         │
  │            │              │ Get rule │            │            │         │
  │            │              ├─────────>│            │            │         │
  │            │              │          │            │            │         │
  │            │              │ Cache Hit│            │            │         │
  │            │              │<──────────┤            │            │         │
  │            │              │          │            │            │         │
  │            │              │ Get counter           │            │         │
  │            │              ├───────────────────────────────────>│         │
  │            │              │<──────────────────────────────────┤         │
  │            │              │          │            │            │         │
  │            │              │ Execute algorithm                  │         │
  │            │              │          │            │            │         │
  │            │              │ Update counter                      │         │
  │            │              ├───────────────────────────────────>│         │
  │            │              │<──────────────────────────────────┤         │
  │            │              │          │            │            │         │
  │            │              │ Record metrics                     │         │
  │            │              ├──────────────────────────────────────────────>│
  │            │<─────────────┤          │            │            │         │
  │<───────────┤              │          │            │            │         │
```

## Flow Description

1. **Client sends request** to API Gateway with rate limit check
2. **API Gateway authenticates** the request
3. **Rate Limiter gets rule** from cache or configuration service
4. **Rate Limiter builds key** from request parameters
5. **Rate Limiter gets counter** from Redis
6. **Rate Limiter executes algorithm** (token bucket, sliding window, or fixed window)
7. **Rate Limiter updates counter** in Redis if allowed
8. **Rate Limiter records metrics** asynchronously
9. **Response returned** to client with rate limit headers

## Error Scenarios

- **Redis Unavailable**: Fail-open, allow request
- **Configuration Missing**: Fail-open, allow request
- **Invalid Request**: Return 400 Bad Request
- **Authentication Failed**: Return 401 Unauthorized
