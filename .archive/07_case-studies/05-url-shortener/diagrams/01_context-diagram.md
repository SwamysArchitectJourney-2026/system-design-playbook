# URL Shortener - C4 Level 1: System Context

## System Context Diagram

The system context diagram shows the URL Shortener system and its relationships with users and external systems.

```mermaid
C4Context
    title System Context Diagram - URL Shortener

    Person(user, "User", "Wants to shorten URLs and access shortened URLs")
    System(urlShortener, "URL Shortener", "Provides URL shortening and redirection services")
    System_Ext(cdn, "CDN", "Content delivery network for global distribution")
    System_Ext(analytics, "Analytics Platform", "External analytics and reporting tools")

    Rel(user, urlShortener, "Creates short URLs and accesses redirects", "HTTPS")
    Rel(user, cdn, "Accesses short URLs via CDN", "HTTPS")
    Rel(urlShortener, analytics, "Sends analytics events", "Kafka/HTTP")
    Rel(cdn, urlShortener, "Fetches redirects on cache miss", "HTTPS")
```

## ASCII Fallback

```text
┌─────────┐
│  User   │
└────┬────┘
     │ Creates short URLs
     │ Accesses redirects
     │
     ▼
┌─────────────────────┐
│  URL Shortener      │
│  System             │
└────┬────────────────┘
     │
     │ Sends analytics
     ▼
┌─────────────────────┐
│  Analytics Platform │
└─────────────────────┘

┌─────────┐
│  User   │
└────┬────┘
     │
     │ Accesses via CDN
     ▼
┌─────────┐
│   CDN   │
└────┬────┘
     │
     │ Cache miss
     ▼
┌─────────────────────┐
│  URL Shortener      │
└─────────────────────┘
```

## Description

**Users**: End users who want to shorten long URLs or access shortened URLs.

**URL Shortener System**: The core system that provides:

- URL shortening functionality
- URL redirection services
- Analytics and monitoring

**CDN**: Content delivery network that caches redirects at edge locations for low latency.

**Analytics Platform**: External system for processing analytics events and generating reports.

---

*Next: [Container Diagram](./02_container-diagram.md)*
