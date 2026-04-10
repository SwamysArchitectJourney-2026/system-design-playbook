# URL Shortener - Low-Level Design

## Token Generation Mechanism

### Token Range Assignment

**Process**:

1. Service instance requests token range from Token Service on startup or when current range is exhausted
2. Token Service assigns non-overlapping range (e.g., 1001-2000) using transactional database
3. Service instance uses tokens sequentially from assigned range
4. When range is nearly exhausted, service requests next range proactively

**Token Service Implementation**:

- Built on MySQL for ACID guarantees
- Maintains table of token ranges with assignment status
- Uses transactions to ensure unique range assignment
- Returns range start and end values

**Example Flow**:

```text
Service Instance 1 requests range → Token Service assigns 1001-2000
Service Instance 2 requests range → Token Service assigns 2001-3000
Service Instance 1 uses 1001, 1002, 1003... (converts to base-62 for short URL)
Service Instance 1 exhausts range → Requests next range → Gets 5001-6000
```

### Base Conversion

**Process**:

1. Token Service provides numeric token (base-10)
2. Service converts numeric token to base-62 using character set [a-z, A-Z, 0-9]
3. Result is short URL string (e.g., "aB3xK9m")

**Example**:

- Token: 1001 (decimal)
- Base-62 conversion: "gH" (if using simple mapping)
- Short URL: `https://short.ly/gH`

### Handling Service Failures

**Problem**: If service instance crashes after receiving token range but before using all tokens, unused tokens are lost.

**Solution**: Accept token loss as acceptable trade-off

- With 7-character URLs supporting 3.5 trillion unique URLs, losing thousands of tokens is negligible
- Alternative (tracking used tokens) adds significant complexity
- Simpler design preferred for evaluation scenarios

## Database Schema

### Cassandra Schema

**Table**: `url_mappings`

```text
Primary Key: short_url (text)
Columns:
  - long_url (text)
  - created_at (timestamp)
  - expires_at (timestamp, optional)
```

**Query Pattern**:

- Primary query: `SELECT long_url FROM url_mappings WHERE short_url = ?`
- Write pattern: `INSERT INTO url_mappings (short_url, long_url, created_at) VALUES (?, ?, ?)`

### Token Service Schema (MySQL)

**Table**: `token_ranges`

```text
Columns:
  - range_start (bigint, primary key)
  - range_end (bigint)
  - assigned_to (varchar, service instance identifier)
  - assigned_at (timestamp)
  - is_assigned (boolean, index)
```

**Query Pattern**:

- Assignment: `SELECT * FROM token_ranges WHERE is_assigned = false ORDER BY range_start LIMIT 1 FOR UPDATE`
- Update: `UPDATE token_ranges SET is_assigned = true, assigned_to = ?, assigned_at = NOW() WHERE range_start = ?`

## Service Instance Logic

### Shortening Request Handler

```python
def shorten_url(long_url):
    # Check if we have available tokens
    if current_token >= token_range_end:
        # Request new range from Token Service
        token_range = token_service.get_next_range()
        current_token = token_range.start
        token_range_end = token_range.end
    
    # Generate short URL
    short_url_token = current_token
    current_token += 1
    short_url = base62_encode(short_url_token)
    
    # Store mapping
    database.store(short_url, long_url)
    
    return short_url
```

### Redirection Request Handler

```python
def redirect(short_url):
    # Query database
    long_url = database.get(short_url)
    
    if long_url is None:
        return HTTP_404
    
    # Return redirect response
    return HTTP_301_REDIRECT(long_url)
```

## Performance Optimizations

### Caching Strategy

**Read Path Optimization**:

- Cache frequently accessed short URLs in Redis
- Reduces database load for popular URLs
- Cache TTL: 24 hours (configurable)

**Write Path**:

- No caching needed (writes go directly to database)

### Database Optimization

**Read Optimization**:

- Short URL is primary key (fast lookups)
- Consider read replicas for high read traffic

**Write Optimization**:

- Batch writes if possible (though real-time requirement may prevent this)
- Use connection pooling

---

*For scaling strategies and analytics, see [Scalability](./05_scalability.md). For design trade-offs, see [Trade-offs](./08_trade-offs.md).*
