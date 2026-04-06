---
learning_level: "Intermediate"
prerequisites: ["Basic system design concepts", "Familiarity with web services"]
estimated_time: "25 minutes"
learning_objectives:
  - "Explain the goals and principles of DevOps in system design"
  - "Describe core CI/CD pipeline stages and common deployment strategies"
  - "Differentiate DevOps, GitOps, and DevSecOps and know when to apply each"
related_topics:
  prerequisites:
    - ../04_principles/02_reliability.md
    - ../04_principles/06_maintainability.md
  builds_upon:
    - 07_monitoring.md
    - 13_distributed-logging.md
  enables:
    - ../07_case-studies/01-scalefromzerotomillonusers/05_scalability.md
    - ../07_case-studies/02-rate-limiter/05_scalability.md
  cross_refs: []
---

# CI/CD and DevOps in System Design

## Why DevOps Matters for System Design

DevOps is about shortening the path from **idea → code → production** while keeping systems **reliable, secure, and observable**.
In system design evaluations, you do not need tool-specific detail, but you are expected to show how teams **build, test, deploy, and operate** the system safely at scale.

Key outcomes:

- Faster, safer releases
- Consistent environments
- Automated feedback via monitoring and alerts

## CI/CD: From Commit to Production

A typical CI/CD pipeline for a backend service includes:

1. **Source & Build**: Code pushed to version control triggers automated builds.
2. **Test Stages**:
   - Unit and integration tests
   - Contract tests for APIs
   - Basic performance or smoke tests
3. **Artifact & Image**: Build an immutable artifact (binary, container image).
4. **Deploy**:
   - Apply a deployment strategy (blue-green, rolling, or canary).
   - Validate health checks and key metrics before full rollout.

In designs, call out how your system:

- Automates tests before deployment
- Uses health checks and metrics as gates
- Keeps rollbacks simple (previous version is one click away)

## Deployment Strategies (Pattern-Level)

- **Blue-Green**:
  - Two environments (blue = current, green = new).
  - Switch traffic at load balancer level once green is healthy.
  - Great for low-risk releases; requires double capacity during deploy.

- **Rolling**:
  - Gradually replace instances with the new version.
  - Works well with stateless services behind a load balancer.
  - Good default for large clusters; small blast radius per batch.

- **Canary**:
  - Route a small percentage of traffic (e.g., 1–5%) to the new version.
  - Watch metrics (latency, errors, saturation) before increasing traffic.
  - Useful for critical services like authentication or rate limiting.

## DevOps, GitOps, and DevSecOps

- **DevOps**:
  - Culture and practices that bring **development and operations** together.
  - Emphasizes automation, observability, and shared ownership of reliability.

- **GitOps**:
  - Treat infrastructure and configuration as **versioned code in git**.
  - The desired state lives in git; automated agents reconcile actual state to match.
  - Works especially well with declarative platforms (containers, Kubernetes, etc.).

- **DevSecOps**:
  - Embed security checks into the same pipelines:
    - Static analysis, dependency scanning, image scanning
    - Policy checks (e.g., who can access which secrets)
  - Goal: **shift security left** without slowing teams down.

## How to Use This in Case Studies

When you describe a case study’s operations story:

- Mention CI/CD at a **pattern level** (pipeline stages, deployment strategy).
- Show how GitOps or DevOps practices help:
  - Keep multi-region deployments consistent.
  - Reduce manual steps and configuration drift.
- Tie DevSecOps back to:
  - Handling secrets safely
  - Scanning dependencies
  - Enforcing security policies before deployment.


