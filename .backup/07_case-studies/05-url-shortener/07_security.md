# URL Shortener - Security

## Security Overview

Security is critical for URL shortening services to prevent abuse, protect users, and maintain service integrity. This section covers authentication, authorization, rate limiting, and abuse prevention.

## Authentication and Authorization

### Public vs Private URLs

**Public URLs** (Default):

- No authentication required
- Anyone can create short URLs
- Anyone can access short URLs
- Suitable for general use cases

**Private URLs** (Optional Feature):

- Require user authentication
- Only authenticated users can create
- Access control (owner-only or shared)
- Suitable for enterprise/internal use

### Authentication Methods

**API Key Authentication**:

- Generate API keys for registered users
- Include API key in request header: `Authorization: Bearer <api_key>`
- Rate limits per API key
- Track usage per key

**OAuth 2.0** (For Private URLs):

- Support OAuth providers (Google, GitHub, etc.)
- Issue JWT tokens for authenticated sessions
- Token expiration: 1 hour (refreshable)

**Session-Based** (For Web UI):

- Traditional session cookies
- Secure, HttpOnly cookies
- CSRF protection for state-changing operations

## Rate Limiting

### Per-IP Rate Limiting

**Anonymous Users**:

- Create short URL: 10 requests/minute per IP
- Redirect: Unlimited (public access)

**Rationale**: Prevent abuse while allowing legitimate use

### Per-User Rate Limiting

**Authenticated Users**:

- Free tier: 100 URLs/minute
- Premium tier: 1,000 URLs/minute
- Enterprise: Custom limits

**Implementation**:

- Use Redis for rate limit counters
- Sliding window algorithm
- Key format: `rate_limit:{user_id}:{endpoint}`

### Distributed Rate Limiting

**Challenge**: Multiple service instances need coordinated rate limiting

**Solution**: Centralized Redis for rate limit counters

- All instances check same Redis
- Atomic increment operations
- TTL-based expiration

**Alternative**: Token bucket algorithm per instance with periodic sync

## URL Validation

### Input Sanitization

**Long URL Validation**:

- Maximum length: 2,048 characters (HTTP URL limit)
- Valid URL format (scheme, domain, path)
- Whitelist allowed schemes: `http://`, `https://`
- Block dangerous schemes: `javascript:`, `data:`, `file:`

**Malicious URL Detection**:

- Check against known phishing/malware databases
- Pattern matching for suspicious domains
- User reporting mechanism

### Content Filtering

**Blocked Content**:

- Known malware domains
- Phishing sites
- Spam patterns
- Adult content (if policy requires)

**Implementation**:

- Real-time URL checking service
- Cache results (TTL: 24 hours)
- Async validation (don't block user, validate in background)

## DDoS Protection

### Layer 1: CDN/WAF

**Web Application Firewall (WAF)**:

- Filter malicious requests at edge
- Block known attack patterns
- Rate limit at CDN level

**CDN Protection**:

- Cloudflare, AWS Shield, or similar
- Automatic DDoS mitigation
- Geographic filtering if needed

### Layer 2: Application-Level

**Request Throttling**:

- Per-IP rate limits (see Rate Limiting section)
- Per-user rate limits
- Global rate limits (circuit breaker)

**Circuit Breaker Pattern**:

- If error rate > threshold, reject new requests
- Automatic recovery after cooldown period
- Protect downstream services

## HTTPS/TLS

### Encryption in Transit

**Requirement**: All traffic over HTTPS

- TLS 1.2 minimum (TLS 1.3 preferred)
- Strong cipher suites only
- Certificate pinning for mobile apps

**Certificate Management**:

- Automated certificate renewal (Let's Encrypt, ACM)
- HSTS headers (force HTTPS)
- Redirect HTTP → HTTPS

## Data Protection

### URL Privacy

**Long URL Handling**:

- Don't log full URLs in access logs (privacy)
- Hash long URLs for analytics
- Encrypt sensitive URLs in database (optional)

**Access Logs**:

- Log short URL, timestamp, IP (hashed)
- Don't log full long URLs
- Anonymize IP addresses after 90 days

### Database Security

**Encryption at Rest**:

- Encrypt database volumes
- Encrypt sensitive columns (if storing private URLs)
- Key management service (AWS KMS, Azure Key Vault)

**Access Control**:

- Least privilege principle
- Separate read/write credentials
- Rotate credentials regularly

## Abuse Prevention

### Spam Detection

**Patterns to Detect**:

- Rapid URL creation from same IP
- Similar long URLs (variations)
- Suspicious domain patterns
- User reporting

**Mitigation**:

- Temporary IP blocking (1 hour)
- Require CAPTCHA after threshold
- Manual review queue for suspicious URLs

### Link Shortening Abuse

**Common Abuse**:

- Phishing links
- Malware distribution
- Spam campaigns
- Copyright infringement

**Prevention**:

- URL validation (see URL Validation section)
- User reporting mechanism
- Automated takedown process
- Legal compliance (DMCA, etc.)

## Security Monitoring

### Security Metrics

**Key Metrics**:

- Failed authentication attempts
- Rate limit violations
- Blocked malicious URLs
- DDoS attack attempts
- Suspicious traffic patterns

### Security Alerts

**Critical Alerts**:

- DDoS attack detected
- Unusual traffic spike from single IP
- High rate of blocked URLs
- Authentication system failure

**Warning Alerts**:

- Rate limit violations increasing
- Suspicious URL patterns detected
- Unusual geographic traffic

## Compliance

### Data Privacy

**GDPR Compliance** (if applicable):

- User data deletion (right to be forgotten)
- Data export (right to access)
- Privacy policy and consent

**Data Retention**:

- URL mappings: 10 years (as per requirements)
- Access logs: 90 days (anonymized)
- User data: Per privacy policy

### Audit Logging

**What to Log**:

- Authentication events (success/failure)
- Authorization changes
- URL creation/deletion
- Administrative actions
- Security policy changes

**Retention**: 7 years (compliance requirement)

## Security Best Practices Summary

1. **Always use HTTPS** for all communications
2. **Implement rate limiting** to prevent abuse
3. **Validate and sanitize** all URL inputs
4. **Monitor for abuse** patterns and attacks
5. **Encrypt sensitive data** at rest and in transit
6. **Follow least privilege** for access control
7. **Regular security audits** and penetration testing
8. **Keep dependencies updated** (security patches)
9. **Implement proper logging** for security events
10. **Have incident response plan** for security breaches

---

*For system architecture, see [High-Level Design](./03_high-level-design.md). For capacity planning, see [Back-of-Envelope](./02_back-of-envelope.md).*
