# Sequence Diagram - URL Redirection Flow

## Redirection Flow Sequence

This diagram shows the step-by-step flow when a user accesses a short URL.

```mermaid
sequenceDiagram
    participant User
    participant CDN as CDN/Edge
    participant API as API Gateway
    participant Service as Short URL Service
    participant Cache as Redis Cache
    participant DB as Cassandra Database
    participant Analytics as Analytics Service

    User->>CDN: GET /{short_url}
    
    alt Cache hit at CDN
        CDN-->>User: HTTP 301 Redirect (cached)
    else Cache miss at CDN
        CDN->>API: GET /{short_url}
        API->>Service: Redirect request
        
        Service->>Cache: GET short_url
        
        alt Cache hit
            Cache-->>Service: Return long_url
        else Cache miss
            Service->>DB: SELECT long_url WHERE short_url = ?
            DB-->>Service: Return long_url
            Service->>Cache: SET short_url -> long_url (TTL)
            Cache-->>Service: Success
        end
        
        Service->>Analytics: Publish event (async, non-blocking)
        Analytics-->>Service: Acknowledged
        
        Service-->>API: HTTP 301 Redirect (long_url)
        API-->>CDN: HTTP 301 Redirect (long_url)
        CDN->>CDN: Cache redirect response
        CDN-->>User: HTTP 301 Redirect (long_url)
    end
    
    User->>User: Browser follows redirect
    User->>User: Access original long URL
```

## ASCII Fallback

```text
User → CDN → API → Service → Cache → DB
                    ↓
                Analytics

1. User requests short URL via CDN
2. CDN checks cache
3. If miss, request goes to API
4. Service checks Redis cache
5. If miss, query Cassandra database
6. Cache result in Redis
7. Publish analytics event (async)
8. Return HTTP 301 redirect
9. CDN caches redirect
10. User's browser follows redirect
```

## Key Interactions

1. **CDN Caching**: First layer of caching at edge locations
2. **Cache Lookup**: Redis cache checked before database query
3. **Database Query**: Cassandra lookup if cache miss
4. **Cache Update**: Result cached for future requests
5. **Analytics**: Event published asynchronously (non-blocking)
6. **Redirect Response**: HTTP 301 redirect returned
7. **Browser Redirect**: User's browser automatically follows redirect

## Performance Optimizations

- **CDN Cache**: Reduces latency for popular URLs
- **Redis Cache**: Reduces database load (85% hit ratio target)
- **Async Analytics**: Doesn't block redirect response
- **HTTP 301**: Permanent redirect, browser caches redirect

---

*Previous: [Shortening Flow](./01_shortening-flow.md) | Next: [Token Range Assignment](./03_token-range-assignment.md)*
