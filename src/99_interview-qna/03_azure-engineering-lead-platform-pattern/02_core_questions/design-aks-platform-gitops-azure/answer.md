---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "AKS platform with GitOps on Azure"
---

# Design an internal AKS platform on Azure (GitOps)

## Clarify

- Number of teams/clusters; **multi-tenant** cluster vs cluster-per-team; **PCI/SOX** boundaries; **Windows** workloads?

## Estimate

- Node counts, peak pod churn, CI builds per day, registry pull bandwidth.

## Architecture

- **Hub-spoke** VNets; **AKS** private API server; **Azure Container Registry** with geo-replication; **Key Vault** + CSI driver.
- **GitOps:** Argo CD or Flux reconciling cluster state from Git; **Helm** or **Kustomize**; **policy** with **OPA Gatekeeper** or **Kyverno** + **Azure Policy** for Azure resources.
- **Ingress:** App Gateway / NGINX; **cert-manager** with Let's Encrypt or internal CA.
- **Observability:** Azure Monitor container insights + **Prometheus/Grafana**; log aggregation to Log Analytics.

## Deep dives

- **RBAC** (Entra ID + Kubernetes RBAC mapping); **namespace** quotas; **network policies**.
- **Upgrade** strategy (surge, blue-green node pools); **pod disruption budgets**.

## Failures

- **Control plane** outage—runbook; **node pool** failure—drain and replace; **bad rollout**—Git revert + sync.

## Evolution

- MVP: one prod + one nonprod cluster, baseline policies.
- Scale: cluster fleet, self-service namespaces, service mesh optional (justify complexity).

See companion files in this folder.
