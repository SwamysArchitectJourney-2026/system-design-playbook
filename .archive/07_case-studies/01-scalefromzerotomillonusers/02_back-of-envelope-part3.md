# Scale from Zero to Million Users - Component Calculations (Part 3)

This document covers back-of-envelope calculations for content delivery, monitoring, and alerting: CDN, Monitoring, and Alerting.

> **📋 Main Document**: See [Back-of-Envelope Summary (Part 1)](./02_back-of-envelope-part1.md) for capacity planning by phase and links to all component calculations.

---

## D. CDN (Content Delivery Network)

**Purpose**: Cache static content at edge locations close to users

**CDN, Traffic Distribution, and Edge Locations**:

**Edge Locations**: Servers distributed globally, close to end users
- Reduces latency by serving content from nearby locations
- Typical latency: 10-50ms (vs 100-300ms from origin)

**Traffic Distribution**:
- DNS routes users to nearest edge location
- Edge location serves cached content
- On cache miss, edge fetches from origin and caches for future requests

**Cache Hit Ratio**: 90-95% for static content (typical)

**Capacity Planning**:

**Phase 3-4 (100K-1M+ users)**:
- CDN for static assets (images, CSS, JS, videos)
- Edge locations: 50-200+ locations globally
- Bandwidth: 80-90% of total bandwidth (CDN handles most static traffic)
- Origin bandwidth: 10-20% of total (cache misses and dynamic content)

**Calculations**:
- **Static Content**: 60-80% of total bandwidth
- **CDN Bandwidth**: Static bandwidth × 0.9 (90% cache hit)
- **Origin Bandwidth**: Static bandwidth × 0.1 (10% cache miss) + Dynamic bandwidth
- **Latency Improvement**: 
  - Without CDN: 200-300ms (origin to user)
  - With CDN: 10-50ms (edge to user)

**Example (Phase 3)**:
- Total bandwidth: 160 Mbps
- Static content: 60% = 96 Mbps
- CDN handles: 96 × 0.9 = 86.4 Mbps (cache hits)
- Origin handles: 96 × 0.1 = 9.6 Mbps (cache misses) + 64 Mbps (dynamic) = 73.6 Mbps

---

## E. Monitoring

**Purpose**: Track system health, performance, and business metrics

**Metrics Collected**:

**Infrastructure Metrics**:
- CPU utilization (per server)
- Memory usage (per server)
- Disk I/O (per server)
- Network bandwidth (per server)

**Application Metrics**:
- Request rate (QPS/RPS)
- Response time (p50, p90, p95, p99)
- Error rate (4xx, 5xx)
- Cache hit ratio

**Business Metrics**:
- Active users
- Transactions per second
- Revenue per request

**Capacity Planning**:

**Phase 1-2 (0-100K users)**:
- Basic monitoring: 10-50 metrics
- Data retention: 7-30 days
- Update frequency: 1-5 minutes

**Phase 3-4 (100K-1M+ users)**:
- Comprehensive monitoring: 100-1000+ metrics
- Data retention: 90-365 days
- Update frequency: 10-60 seconds
- Distributed tracing for microservices

**Calculations**:
- **Metrics per Second**: (Number of metrics × Update frequency) / 60
- **Storage per Day**: (Metrics per second × Bytes per metric × 86400 seconds)
- **Example**: 100 metrics × 1 update/minute = 100/60 = 1.67 metrics/second
- Storage: 1.67 × 100 bytes × 86400 = ~14 MB/day

---

## F. Alerting

**Purpose**: Notify team when metrics exceed thresholds

**Alert Types**:

**Critical Alerts** (immediate response):
- Service down (error rate > 5%)
- High latency (p95 > 1 second)
- Database connection failures
- Disk space < 10%

**Warning Alerts** (investigate soon):
- Error rate > 1%
- Latency increasing (p95 > 500ms)
- CPU > 80%
- Cache hit ratio < 70%

**Capacity Planning**:

**Phase 1-2 (0-100K users)**:
- 5-10 alert rules
- Email/SMS notifications
- On-call rotation: 1-2 people

**Phase 3-4 (100K-1M+ users)**:
- 20-50+ alert rules
- PagerDuty/Opsgenie integration
- On-call rotation: 5-10 people
- Alert routing by service/severity

**Calculations**:
- **Alert Volume**: Typically 1-5% of metrics generate alerts
- **False Positive Rate**: Target < 5% (alerts that don't require action)
- **Alert Fatigue**: Too many alerts reduce effectiveness (aim for < 10 alerts/day per on-call person)

---

*Previous: [Component Calculations Part 2](./02_back-of-envelope-part2.md) - Data Store, Caching, Load Balancing*  
*Next: [Component Calculations Part 4](./02_back-of-envelope-part4.md) - Auto-Scaling, Backup & Recovery, Security & Compliance*

