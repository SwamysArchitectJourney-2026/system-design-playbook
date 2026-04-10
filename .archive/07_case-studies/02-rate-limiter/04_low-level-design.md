# Rate Limiter - Low-Level Design

## Data Models

### Rate Limit Configuration

```python
class RateLimitRule:
    id: str
    key_type: str  # "user", "ip", "endpoint", "custom"
    key_pattern: str  # Pattern to match keys
    algorithm: str  # "token_bucket", "sliding_window", "fixed_window"
    limit: int  # Maximum requests
    window_seconds: int  # Time window in seconds
    burst: int  # Burst allowance (for token bucket)
    enabled: bool
    created_at: datetime
    updated_at: datetime
```

### Rate Limit Counter

```python
class RateLimitCounter:
    key: str  # Composite key: "{key_type}:{key_value}:{rule_id}"
    count: int  # Current count
    window_start: int  # Window start timestamp
    tokens: int  # Current tokens (for token bucket)
    last_refill: int  # Last token refill timestamp
    ttl: int  # Time to live in seconds
```

## API Design

### Rate Limit Check API

**Endpoint**: `POST /api/v1/rate-limit/check`

**Request**:

```json
{
  "key_type": "user",
  "key_value": "user123",
  "rule_id": "rule_001",
  "request_count": 1
}
```

**Response (Allowed)**:

```json
{
  "allowed": true,
  "limit": 1000,
  "remaining": 999,
  "reset_at": 1638360000
}
```

**Response (Denied)**:

```json
{
  "allowed": false,
  "limit": 1000,
  "remaining": 0,
  "reset_at": 1638360000,
  "retry_after": 60
}
```

**HTTP Headers**:

```text
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1638360000
```

## Algorithm Implementations

### Token Bucket Algorithm

```python
def check_token_bucket(key: str, limit: int, window: int, burst: int) -> bool:
    """
    Token bucket algorithm implementation.
    
    Args:
        key: Rate limit key
        limit: Maximum requests per window
        window: Time window in seconds
        burst: Burst allowance
    
    Returns:
        True if allowed, False otherwise
    """
    current_time = get_current_timestamp()
    
    # Get current state from Redis
    state = redis.get(key)
    if state is None:
        # Initialize bucket
        state = {
            "tokens": limit + burst,  # Start with full bucket + burst
            "last_refill": current_time
        }
    else:
        state = json.loads(state)
        # Refill tokens based on elapsed time
        elapsed = current_time - state["last_refill"]
        tokens_to_add = (elapsed * limit) // window
        state["tokens"] = min(limit + burst, state["tokens"] + tokens_to_add)
        state["last_refill"] = current_time
    
    # Check if token available
    if state["tokens"] >= 1:
        state["tokens"] -= 1
        # Update Redis with TTL
        redis.setex(key, json.dumps(state), window)
        return True
    else:
        # Update last refill time
        redis.setex(key, json.dumps(state), window)
        return False
```

### Sliding Window Algorithm

```python
def check_sliding_window(key: str, limit: int, window: int) -> bool:
    """
    Sliding window algorithm implementation.
    
    Args:
        key: Rate limit key
        limit: Maximum requests per window
        window: Time window in seconds
    
    Returns:
        True if allowed, False otherwise
    """
    current_time = get_current_timestamp()
    window_start = current_time - window
    
    # Use Redis sorted set to track requests
    # Score is timestamp, member is request ID
    redis_key = f"{key}:requests"
    
    # Remove old requests outside window
    redis.zremrangebyscore(redis_key, 0, window_start)
    
    # Count current requests in window
    current_count = redis.zcard(redis_key)
    
    if current_count < limit:
        # Add current request
        request_id = f"{current_time}:{uuid.uuid4()}"
        redis.zadd(redis_key, {request_id: current_time})
        redis.expire(redis_key, window)
        return True
    else:
        return False
```

### Fixed Window Algorithm

```python
def check_fixed_window(key: str, limit: int, window: int) -> bool:
    """
    Fixed window algorithm implementation.
    
    Args:
        key: Rate limit key
        limit: Maximum requests per window
        window: Time window in seconds
    
    Returns:
        True if allowed, False otherwise
    """
    current_time = get_current_timestamp()
    window_start = (current_time // window) * window
    
    # Use window start as part of key
    window_key = f"{key}:{window_start}"
    
    # Atomic increment and check
    current_count = redis.incr(window_key)
    if current_count == 1:
        # First request in window, set TTL
        redis.expire(window_key, window)
    
    return current_count <= limit
```

## Service Implementation

### Rate Limiter Service

```python
class RateLimiterService:
    def __init__(self):
        self.redis_client = RedisClient()
        self.config_cache = LocalCache()
        self.metrics = MetricsCollector()
    
    def check_rate_limit(self, request: RateLimitRequest) -> RateLimitResponse:
        """
        Check if request should be rate limited.
        
        Args:
            request: Rate limit check request
        
        Returns:
            Rate limit response with decision
        """
        start_time = time.time()
        
        try:
            # Get rate limit rule
            rule = self.get_rate_limit_rule(request.rule_id)
            if not rule or not rule.enabled:
                return self._allow_response()
            
            # Build rate limit key
            key = self._build_key(request.key_type, request.key_value, rule.id)
            
            # Execute algorithm
            allowed = self._execute_algorithm(key, rule)
            
            # Update metrics
            self.metrics.record_rate_limit_check(
                rule_id=rule.id,
                allowed=allowed,
                latency=time.time() - start_time
            )
            
            # Build response
            if allowed:
                return self._build_allowed_response(rule, key)
            else:
                return self._build_denied_response(rule, key)
        
        except Exception as e:
            # Fail open on errors
            self.metrics.record_error(e)
            return self._allow_response()
    
    def _execute_algorithm(self, key: str, rule: RateLimitRule) -> bool:
        """Execute rate limiting algorithm."""
        if rule.algorithm == "token_bucket":
            return check_token_bucket(key, rule.limit, rule.window_seconds, rule.burst)
        elif rule.algorithm == "sliding_window":
            return check_sliding_window(key, rule.limit, rule.window_seconds)
        elif rule.algorithm == "fixed_window":
            return check_fixed_window(key, rule.limit, rule.window_seconds)
        else:
            raise ValueError(f"Unknown algorithm: {rule.algorithm}")
    
    def _build_key(self, key_type: str, key_value: str, rule_id: str) -> str:
        """Build composite rate limit key."""
        return f"{key_type}:{key_value}:{rule_id}"
    
    def get_rate_limit_rule(self, rule_id: str) -> RateLimitRule:
        """Get rate limit rule from cache or database."""
        # Check cache first
        rule = self.config_cache.get(rule_id)
        if rule:
            return rule
        
        # Load from database
        rule = self.db.get_rate_limit_rule(rule_id)
        if rule:
            self.config_cache.set(rule_id, rule, ttl=300)
        
        return rule
```

## Redis Data Structures

### Counter Storage

**Key Format**: `ratelimit:{key_type}:{key_value}:{rule_id}`

**Value**: JSON string with counter state

```json
{
  "count": 42,
  "window_start": 1638360000,
  "tokens": 10,
  "last_refill": 1638360000
}
```

**TTL**: Set to window duration for automatic cleanup

### Sliding Window Storage

**Key Format**: `ratelimit:sliding:{key_type}:{key_value}:{rule_id}:requests`

**Type**: Redis Sorted Set

- **Score**: Timestamp
- **Member**: Request ID

**Operations**:

- `ZADD`: Add request
- `ZREMRANGEBYSCORE`: Remove old requests
- `ZCARD`: Count current requests

## Performance Optimizations

### Connection Pooling

```python
class RedisClient:
    def __init__(self):
        self.pool = redis.ConnectionPool(
            host='redis-cluster',
            port=6379,
            max_connections=100,
            decode_responses=True
        )
        self.client = redis.Redis(connection_pool=self.pool)
```

### Batch Operations

```python
def batch_check_rate_limits(requests: List[RateLimitRequest]) -> List[RateLimitResponse]:
    """Batch rate limit checks for efficiency."""
    pipeline = redis.pipeline()
    
    for request in requests:
        key = build_key(request)
        pipeline.get(key)
    
    results = pipeline.execute()
    # Process results...
```

### Local Caching

```python
class LocalCache:
    def __init__(self):
        self.cache = {}
        self.ttl = {}
    
    def get(self, key: str):
        if key in self.cache:
            if time.time() < self.ttl.get(key, 0):
                return self.cache[key]
            else:
                del self.cache[key]
                del self.ttl[key]
        return None
    
    def set(self, key: str, value: any, ttl: int = 300):
        self.cache[key] = value
        self.ttl[key] = time.time() + ttl
```

## Error Handling

### Fail-Open Strategy

```python
def check_rate_limit_safe(request: RateLimitRequest) -> RateLimitResponse:
    """Safe rate limit check with fail-open."""
    try:
        return check_rate_limit(request)
    except RedisError:
        # Redis unavailable - allow request
        metrics.record_fail_open()
        return allow_response()
    except Exception as e:
        # Unknown error - allow request
        logger.error(f"Rate limit error: {e}")
        metrics.record_error(e)
        return allow_response()
```

### Circuit Breaker

```python
class CircuitBreaker:
    def __init__(self, failure_threshold=5, timeout=60):
        self.failure_count = 0
        self.failure_threshold = failure_threshold
        self.timeout = timeout
        self.state = "closed"  # closed, open, half_open
        self.last_failure_time = None
    
    def call(self, func, *args, **kwargs):
        if self.state == "open":
            if time.time() - self.last_failure_time > self.timeout:
                self.state = "half_open"
            else:
                raise CircuitBreakerOpen()
        
        try:
            result = func(*args, **kwargs)
            if self.state == "half_open":
                self.state = "closed"
                self.failure_count = 0
            return result
        except Exception as e:
            self.failure_count += 1
            self.last_failure_time = time.time()
            if self.failure_count >= self.failure_threshold:
                self.state = "open"
            raise e
```
