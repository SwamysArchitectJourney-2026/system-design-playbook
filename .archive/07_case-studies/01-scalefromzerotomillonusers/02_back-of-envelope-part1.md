# Scale from Zero to Million Users - Back-of-Envelope Calculations

## Capacity Planning by Phase

### Phase 1: 0-1,000 Users

**Assumptions**:

- 1,000 active users
- 10 requests/user/day average
- 100 requests/second peak
- 1 KB average request/response size

**Calculations**:

- **Daily Requests**: 1,000 users × 10 requests = 10,000 requests/day
- **Peak QPS**: 100 requests/second
- **Bandwidth**: 100 QPS × 1 KB × 2 (request + response) = 200 KB/s = 1.6 Mbps
- **Storage**: 10,000 requests/day × 1 KB × 365 days = 3.65 GB/year
- **Servers**: 1 server (2 CPU, 4 GB RAM) sufficient

**Infrastructure Cost**: ~$50-100/month

### Phase 2: 1,000-100,000 Users

**Assumptions**:

- 100,000 active users
- 10 requests/user/day average
- 1,000 requests/second peak
- 1 KB average request/response size

**Calculations**:

- **Daily Requests**: 100,000 users × 10 requests = 1,000,000 requests/day
- **Peak QPS**: 1,000 requests/second
- **Bandwidth**: 1,000 QPS × 1 KB × 2 = 2 MB/s = 16 Mbps
- **Storage**: 1M requests/day × 1 KB × 365 days = 365 GB/year
- **Servers**: 2-3 servers (4 CPU, 8 GB RAM each) with read replicas

**Infrastructure Cost**: ~$300-500/month

### Phase 3: 100,000-1,000,000 Users

**Assumptions**:

- 1,000,000 active users
- 10 requests/user/day average
- 10,000 requests/second peak
- 1 KB average request/response size

**Calculations**:

- **Daily Requests**: 1M users × 10 requests = 10,000,000 requests/day
- **Peak QPS**: 10,000 requests/second
- **Bandwidth**: 10,000 QPS × 1 KB × 2 = 20 MB/s = 160 Mbps
- **Storage**: 10M requests/day × 1 KB × 365 days = 3.65 TB/year
- **Servers**: 10-20 servers (8 CPU, 16 GB RAM each) with load balancer

**Infrastructure Cost**: ~$2,000-5,000/month

### Phase 4: 1,000,000+ Users

**Assumptions**:

- 10,000,000+ active users
- 10 requests/user/day average
- 100,000+ requests/second peak
- 1 KB average request/response size

**Calculations**:

- **Daily Requests**: 10M users × 10 requests = 100,000,000 requests/day
- **Peak QPS**: 100,000 requests/second
- **Bandwidth**: 100,000 QPS × 1 KB × 2 = 200 MB/s = 1.6 Gbps
- **Storage**: 100M requests/day × 1 KB × 365 days = 36.5 TB/year
- **Servers**: 100+ servers distributed across regions

**Infrastructure Cost**: ~$20,000-50,000/month

## Key Metrics Summary

| Phase | Users | Peak QPS | Storage/Year | Servers | Monthly Cost |
| ----- | ----- | -------- | ------------ | ------- | ------------ |
| Phase 1 | 1K | 100 | 3.65 GB | 1 | $50-100 |
| Phase 2 | 100K | 1K | 365 GB | 2-3 | $300-500 |
| Phase 3 | 1M | 10K | 3.65 TB | 10-20 | $2K-5K |
| Phase 4 | 10M+ | 100K+ | 36.5+ TB | 100+ | $20K-50K+ |

## Scaling Considerations

- **Cache Hit Ratio**: 80% cache hit rate reduces database load by 5x
- **Read/Write Ratio**: 10:1 read/write ratio affects database design
- **Data Growth**: Plan for 3-5 years of data retention
- **Geographic Distribution**: Multi-region deployment for global users

---

## Understanding Performance Metrics

> **📚 Foundational Content**: For detailed explanations of performance metrics (p90/p95, latency vs throughput, QPS/RPS, concurrent users), see [Performance Metrics in System Design](../../03_foundations/08_performance-metrics.md).

**Quick Reference**:
- **p90/p95**: Percentile metrics showing response time distribution (p95 = 95% of requests finish in this time)
- **Latency**: Time to complete a request (lower is better, measured in ms)
- **Throughput**: Requests processed per second (higher is better, measured in RPS/QPS)
- **Concurrent Users vs RPS**: RPS = (Concurrent Users × Requests per Session) / Session Duration
- **QPS vs RPS**: Essentially the same metric (QPS for databases, RPS for APIs)

---

## Component-Level Back-of-Envelope Calculations

Detailed component-level calculations are split across three documents for better organization:

- **[Part 2: Data Store, Caching, Load Balancing](./02_back-of-envelope-part2.md)** - Core infrastructure components
- **[Part 3: CDN, Monitoring, Alerting](./02_back-of-envelope-part3.md)** - Content delivery and observability
- **[Part 4: Auto-Scaling, Backup & Recovery, Security & Compliance](./02_back-of-envelope-part4.md)** - Operations and security

### Quick Component Summary

| Component | Key Metrics | Phase 1-2 | Phase 3-4 |
|-----------|-------------|-----------|-----------|
| **A. Data Store** | p95 < 50ms | Single DB, 50-100 connections | Sharded/Replicated, 200-500 connections/shard |
| **B. Caching** | 80-90% hit rate | 2-4 GB Redis | 16-64 GB Redis cluster |
| **C. Load Balancing** | 2-3x peak capacity | External LB, 1K-10K conn/s | External + Internal LBs, 10K-100K+ conn/s |
| **D. CDN** | 90-95% cache hit | Not needed | 50-200+ edge locations |
| **E. Monitoring** | 10-1000+ metrics | 10-50 metrics, 7-30 day retention | 100-1000+ metrics, 90-365 day retention |
| **F. Alerting** | < 10 alerts/day/person | 5-10 rules, Email/SMS | 20-50+ rules, PagerDuty integration |
| **G. Auto-Scaling** | CPU/Memory triggers | 2-20 instances | 20-100+ instances |
| **H. Backup & Recovery** | RTO: 1-24 hours | Daily backups, 7-30 day retention | Continuous + daily, 30-90 day retention |
| **I. Security & Compliance** | Encryption overhead: 5-10% | HTTPS, basic validation | WAF, DDoS, compliance audits |

For detailed calculations, examples, and capacity planning formulas, see the component-specific documents above.

---

*Next: [Component Calculations Part 2](./02_back-of-envelope-part2.md) - Data Store, Caching, Load Balancing*