# Rate Limiter - Component Diagram

## Component Diagram (Rate Limiter Service)

This diagram shows the internal components of the Rate Limiter Service container.

```mermaid
C4Component
    title Component Diagram - Rate Limiter Service

    Container_Boundary(rateLimiterService, "Rate Limiter Service") {
        Component(apiController, "API Controller", "REST/gRPC", "Handles rate limit check requests")
        Component(rateLimitEngine, "Rate Limit Engine", "Business Logic", "Executes rate limiting algorithms")
        Component(algorithmFactory, "Algorithm Factory", "Business Logic", "Creates algorithm instances")
        Component(tokenBucket, "Token Bucket", "Algorithm", "Token bucket implementation")
        Component(slidingWindow, "Sliding Window", "Algorithm", "Sliding window implementation")
        Component(fixedWindow, "Fixed Window", "Algorithm", "Fixed window implementation")
        Component(redisClient, "Redis Client", "Redis Driver", "Redis operations")
        Component(cacheClient, "Cache Client", "In-Memory", "Local cache operations")
        Component(configClient, "Config Client", "HTTP Client", "Configuration service client")
        Component(metricsCollector, "Metrics Collector", "Component", "Collects and sends metrics")
    }
    
    ContainerDb(redis, "Redis Cluster", "Redis")
    Container(cache, "Local Cache", "In-Memory")
    Container(configService, "Configuration Service", "HTTP/gRPC")

    Rel(apiController, rateLimitEngine, "Delegates to", "Uses")
    Rel(rateLimitEngine, algorithmFactory, "Gets algorithm", "Uses")
    Rel(algorithmFactory, tokenBucket, "Creates", "Uses")
    Rel(algorithmFactory, slidingWindow, "Creates", "Uses")
    Rel(algorithmFactory, fixedWindow, "Creates", "Uses")
    Rel(rateLimitEngine, redisClient, "Reads/writes counters", "Uses")
    Rel(rateLimitEngine, cacheClient, "Checks cache", "Uses")
    Rel(rateLimitEngine, configClient, "Gets configuration", "Uses")
    Rel(redisClient, redis, "Operations", "Redis Protocol")
    Rel(cacheClient, cache, "Reads/writes", "In-Memory")
    Rel(configClient, configService, "Gets rules", "HTTP/gRPC")
    Rel(apiController, metricsCollector, "Sends metrics", "Uses")
```

## ASCII Fallback

```text
┌─────────────────────────────────┐
│     Rate Limiter Service        │
│                                 │
│  ┌──────────────┐              │
│  │ API Controller│              │
│  └──────┬───────┘               │
│         │                       │
│  ┌──────▼──────────┐           │
│  │ Rate Limit      │           │
│  │ Engine          │           │
│  └──────┬──────────┘           │
│         │                       │
│    ┌────▼────┐                 │
│    │Algorithm│                 │
│    │ Factory │                 │
│    └────┬────┘                 │
│         │                       │
│    ┌────▼────┐  ┌──────┐       │
│    │ Token   │  │Sliding│      │
│    │ Bucket  │  │Window │      │
│    └────┬────┘  └───┬──┘       │
│         │           │          │
│    ┌────▼───────────▼──┐       │
│    │  Redis Client    │        │
│    └────┬─────────────┘       │
│         │                      │
│    ┌────▼────┐  ┌──────┐      │
│    │ Cache   │  │Config│      │
│    │ Client  │  │Client│      │
│    └─────────┘  └──────┘      │
└────────┬───────────┬───────────┘
         │           │
    ┌────▼───┐  ┌───▼────┐
    │ Redis  │  │Config  │
    │Cluster │  │Service │
    └────────┘  └────────┘
```

## Component Responsibilities

### API Controller

- Receives rate limit check requests
- Validates input parameters
- Returns rate limit decisions
- Handles errors and exceptions

### Rate Limit Engine

- Orchestrates rate limiting process
- Selects appropriate algorithm
- Executes algorithm
- Makes allow/deny decisions

### Algorithm Factory

- Creates algorithm instances based on rule type
- Manages algorithm lifecycle
- Provides algorithm abstraction

### Algorithm Components

- **Token Bucket**: Implements token bucket algorithm
- **Sliding Window**: Implements sliding window algorithm
- **Fixed Window**: Implements fixed window algorithm

### Redis Client

- Manages Redis connections
- Performs counter operations
- Handles connection pooling
- Implements retry logic

### Cache Client

- Manages local in-memory cache
- Implements cache-aside pattern
- Handles cache invalidation
- Manages TTL

### Config Client

- Communicates with configuration service
- Fetches rate limit rules
- Handles configuration updates
- Implements caching

### Metrics Collector

- Collects rate limit metrics
- Sends metrics to monitoring system
- Tracks performance indicators

## Component Interactions

1. **Request Flow**: API Controller → Rate Limit Engine → Algorithm → Redis Client
2. **Configuration Flow**: Rate Limit Engine → Config Client → Configuration Service
3. **Cache Flow**: Rate Limit Engine → Cache Client → Local Cache
4. **Metrics Flow**: API Controller → Metrics Collector → Monitoring System
