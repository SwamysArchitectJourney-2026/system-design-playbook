# Scale from Zero to Million Users - Component Calculations (Part 4)

This document covers back-of-envelope calculations for operations and security: Auto-Scaling, Backup & Recovery, and Security & Compliance.

> **📋 Main Document**: See [Back-of-Envelope Summary (Part 1)](./02_back-of-envelope-part1.md) for capacity planning by phase and links to all component calculations.

---

## G. Auto-Scaling

**Purpose**: Automatically adjust resources based on demand

**Scaling Triggers**:

**Scale Up** (add instances):
- CPU utilization > 70% for 5 minutes
- Memory usage > 80% for 5 minutes
- Request queue depth > 100
- p95 latency > 500ms for 5 minutes

**Scale Down** (remove instances):
- CPU utilization < 30% for 10 minutes
- Memory usage < 50% for 10 minutes
- Request queue depth < 10

**Capacity Planning**:

**Phase 2-3 (1K-1M users)**:
- Auto-scaling groups: 2-20 instances
- Scale-up: +2 instances at a time
- Scale-down: -1 instance at a time
- Cooldown: 5-10 minutes between scaling actions

**Phase 4 (1M+ users)**:
- Auto-scaling groups: 20-100+ instances
- Scale-up: +5-10 instances at a time
- Scale-down: -2-5 instances at a time
- Cooldown: 2-5 minutes between scaling actions

**Calculations**:
- **Target Capacity**: Peak QPS / (QPS per instance × target utilization)
- **Example**: 10,000 peak QPS, 500 QPS per instance, 70% target utilization
- Target instances: 10,000 / (500 × 0.7) = ~29 instances
- **Scaling Time**: 2-5 minutes to add instances, 1-3 minutes to remove

---

## H. Backup & Recovery

**Purpose**: Protect data and enable disaster recovery

**Backup Strategy**:

**Phase 1-2 (0-100K users)**:
- Daily full backups
- 7-30 day retention
- Manual recovery process
- RTO (Recovery Time Objective): 4-24 hours
- RPO (Recovery Point Objective): 24 hours

**Phase 3-4 (100K-1M+ users)**:
- Continuous backups (transaction logs)
- Daily full backups
- 30-90 day retention
- Automated recovery process
- RTO: 1-4 hours
- RPO: 1 hour or less

**Capacity Planning**:

**Backup Storage**:
- Full backup size: Database size × compression ratio (typically 0.3-0.5)
- Incremental backup: 5-10% of full backup size
- Total backup storage: (Full backup + Incremental backups × retention days) × 2 (for redundancy)

**Example (Phase 3)**:
- Database size: 3.65 TB
- Full backup: 3.65 TB × 0.4 = 1.46 TB (compressed)
- Daily incremental: 3.65 TB × 0.05 = 182 GB
- 30-day retention: 1.46 TB + (182 GB × 30) = 6.92 TB
- Total with redundancy: 6.92 TB × 2 = 13.84 TB

**Recovery Testing**:
- Test restore monthly (Phase 1-2)
- Test restore weekly (Phase 3-4)
- Document recovery procedures

---

## I. Security & Compliance

**Purpose**: Protect data and meet regulatory requirements

**Security Measures**:

**Phase 1-2 (0-100K users)**:
- HTTPS/TLS encryption
- Password hashing (bcrypt)
- Basic input validation
- SQL injection prevention
- Security headers

**Phase 3-4 (100K-1M+ users)**:
- All Phase 1-2 measures
- WAF (Web Application Firewall)
- DDoS protection
- Rate limiting
- Security scanning
- Penetration testing
- Compliance audits (SOC 2, GDPR, etc.)

**Capacity Planning**:

**Security Overhead**:
- Encryption: 5-10% CPU overhead
- WAF: 10-20ms latency overhead
- DDoS protection: Minimal overhead (handled at edge)
- Security scanning: Runs asynchronously, minimal impact

**Compliance Requirements**:
- Data encryption at rest: Required for sensitive data
- Data encryption in transit: Required (HTTPS/TLS)
- Access logging: All access attempts logged
- Audit trails: 90-365 day retention
- Compliance reporting: Monthly/quarterly reports

**Calculations**:
- **Security Logs**: 1-5% of total log volume
- **Audit Storage**: (Number of operations × log entry size × retention days)
- **Example**: 10M operations/day × 200 bytes × 365 days = 730 GB/year

---

*Previous: [Component Calculations Part 3](./02_back-of-envelope-part3.md) - CDN, Monitoring, Alerting*

