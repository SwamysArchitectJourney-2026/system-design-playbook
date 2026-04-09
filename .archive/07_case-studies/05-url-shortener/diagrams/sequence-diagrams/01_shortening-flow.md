# Sequence Diagram - URL Shortening Flow

## Shortening Flow Sequence

This diagram shows the step-by-step flow when a user creates a short URL.

```mermaid
sequenceDiagram
    participant User
    participant WebApp as Web Application
    participant API as API Gateway
    participant Service as Short URL Service
    participant TokenMgr as Token Manager
    participant TokenSvc as Token Service
    participant Cache as Redis Cache
    participant DB as Cassandra Database

    User->>WebApp: Submit long URL
    WebApp->>API: POST /api/v1/shorten
    API->>API: Validate request & rate limit
    
    API->>Service: Shorten URL request
    Service->>TokenMgr: Get next token
    
    alt Token range available
        TokenMgr-->>Service: Return token from range
    else Token range exhausted
        TokenMgr->>TokenSvc: Request new token range
        TokenSvc->>TokenSvc: Assign unique range (ACID)
        TokenSvc-->>TokenMgr: Return range (start, end)
        TokenMgr-->>Service: Return token from new range
    end
    
    Service->>Service: Convert token to base-62
    Service->>Service: Generate short URL string
    
    Service->>DB: INSERT url_mapping (short_url, long_url)
    DB-->>Service: Success
    
    Service->>Cache: SET short_url -> long_url (optional)
    Cache-->>Service: Success
    
    Service-->>API: Return short URL
    API-->>WebApp: Return short URL
    WebApp-->>User: Display short URL
```

## ASCII Fallback

```text
User → WebApp → API → Service → TokenMgr → TokenSvc
                              ↓
                           Cache
                              ↓
                            DB

1. User submits long URL
2. API validates and rate limits
3. Service requests token
4. If range exhausted, request new range from Token Service
5. Convert token to base-62
6. Store mapping in database
7. Optionally cache mapping
8. Return short URL to user
```

## Key Interactions

1. **Request Validation**: API Gateway validates input and applies rate limiting
2. **Token Generation**: Service gets token from current range or requests new range
3. **Base-62 Encoding**: Numeric token converted to short URL string
4. **Storage**: URL mapping stored in Cassandra database
5. **Caching**: Mapping optionally cached in Redis for fast retrieval
6. **Response**: Short URL returned to user

---

*Next: [Redirection Flow](./02_redirection-flow.md)*
