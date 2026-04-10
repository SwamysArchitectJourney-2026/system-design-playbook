---
learning_level: "Intermediate"
prerequisites: ["System design fundamentals", "Basic understanding of security concepts"]
estimated_time: "25 minutes"
learning_objectives:
  - "Apply security principles to system design"
  - "Design systems with defense in depth"
  - "Balance security with usability and performance"
related_topics:
  prerequisites:
    - ../03_foundations/01_abstractions.md
  builds_upon:
    - ./01_availability.md
    - ./02_reliability.md
  enables:
    - ../05_building-blocks/02_load-balancers.md
    - ../06_patterns/02_rate-limiting.md
  cross_refs: []
---

# Security in System Design

## What Is Security?

Security in system design means **protecting systems, data, and users** from unauthorized access, attacks, and data breaches. Security is not an afterthought—it must be designed into the system from the beginning.

## Security Principles

### Defense in Depth

**Concept**: Multiple layers of security controls.

**Approach**:
- Network security (firewalls, VPNs)
- Application security (authentication, authorization)
- Data security (encryption, access controls)
- Monitoring and detection

**Example**: Even if one layer fails, others provide protection.

### Least Privilege

**Concept**: Grant minimum permissions necessary.

**Approach**:
- Users get only permissions they need
- Services access only required resources
- Principle of least privilege at every level

**Example**: Database user only has read access, not write or admin.

### Fail Secure

**Concept**: System defaults to secure state on failure.

**Approach**:
- Deny access if authentication fails
- Close connections on errors
- Default to most restrictive permissions

**Example**: Authentication failure → deny access, don't allow anonymous.

## Security Layers

### 1. Network Security

**Protection**: Secure network communication.

**Mechanisms**:
- **TLS/SSL**: Encrypt data in transit
- **Firewalls**: Control network access
- **VPNs**: Secure remote access
- **DDoS Protection**: Mitigate attacks

**Example**: All API calls use HTTPS, not HTTP.

### 2. Authentication

**Protection**: Verify user identity.

**Methods**:
- **Password-based**: Username/password
- **Multi-factor (MFA)**: Password + token/phone
- **OAuth/SAML**: Third-party authentication
- **Certificate-based**: Digital certificates

**Example**: Login requires password + SMS code.

### 3. Authorization

**Protection**: Control what users can do.

**Models**:
- **RBAC**: Role-based access control
- **ABAC**: Attribute-based access control
- **ACLs**: Access control lists

**Example**: Admin users can delete, regular users can only read.

### 4. Data Security

**Protection**: Protect data at rest and in transit.

**Mechanisms**:
- **Encryption**: Encrypt sensitive data
- **Key Management**: Secure key storage
- **Data Masking**: Hide sensitive data
- **Backup Security**: Encrypt backups

**Example**: Credit card numbers encrypted in database.

## Common Security Threats

### 1. Injection Attacks

**Threat**: Malicious code injected into system.

**Examples**: SQL injection, command injection, XSS.

**Prevention**: Input validation, parameterized queries, output encoding.

### 2. Authentication Bypass

**Threat**: Unauthorized access without credentials.

**Examples**: Weak passwords, session hijacking, token theft.

**Prevention**: Strong passwords, MFA, secure session management.

### 3. Data Exposure

**Threat**: Sensitive data accessed by unauthorized users.

**Examples**: Unencrypted data, exposed APIs, misconfigured permissions.

**Prevention**: Encryption, access controls, security audits.

### 4. Denial of Service (DoS)

**Threat**: System overwhelmed by attacks.

**Examples**: DDoS attacks, resource exhaustion.

**Prevention**: Rate limiting, DDoS protection, resource quotas.

---

*Next: Continue with [Security Best Practices](./07_security-part2.md).*
