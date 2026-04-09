# URL Shortener - Requirements

## Functional Requirements

1. **URL Shortening**: Given a long URL, generate and return a shorter URL
2. **URL Redirection**: When a short URL is accessed, redirect the user to the original long URL

## Non-Functional Requirements

### Availability

- **High Availability**: Service must be always available (99.9%+ uptime)
- **No Single Point of Failure**: System must handle component failures gracefully

### Performance

- **Low Latency**: Response times must be minimal (critical for platforms like social media where URLs are shared frequently)
- **Fast Redirection**: Short URL resolution and redirection must happen quickly

### Scalability

- **Handle High Traffic**: System must support traffic from large-scale platforms (millions of requests per second)
- **Horizontal Scaling**: Must be able to scale by adding more instances

### Durability

- **Long-Term Storage**: Short URLs must remain valid for extended periods (e.g., 10 years)
- **Data Persistence**: URL mappings must not be lost

## Scale Considerations

### Short URL Length Calculation

The length of short URLs depends on:

- Expected number of unique URLs to be shortened
- Character set allowed in short URLs
- Duration URLs need to remain valid

**Character Set**: Typically uses alphanumeric characters:

- Lowercase letters (a-z): 26 characters
- Uppercase letters (A-Z): 26 characters
- Numbers (0-9): 10 characters
- **Total**: 62 characters

**Capacity Calculation**:

- Length 1: 62 unique URLs
- Length 2: 62² = 3,844 unique URLs
- Length 6: 62⁶ ≈ 58 billion unique URLs
- Length 7: 62⁷ ≈ 3.5 trillion unique URLs

**Decision Process**:

1. Calculate total unique URLs needed: `requests_per_second × 60 × 60 × 24 × 365 × years`
2. Determine minimum length: `n = ⌈log₆₂(total_urls)⌉`
3. Add safety margin (typically use 7 characters for most use cases)

**Example**: For 7-character URLs with 62-character alphabet, system can support approximately 3.5 trillion unique URLs, which is sufficient for most large-scale applications.
