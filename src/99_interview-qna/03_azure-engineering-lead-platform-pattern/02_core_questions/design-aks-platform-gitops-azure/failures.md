# Failure scenarios: AKS platform with GitOps

- **Control plane / GitOps** desync — cluster state diverges from repo; **drift detection** and **freeze** deploys.
- **Bad rollout** — broken **CNI** or **admission webhook** takes down scheduling; **canary** + **rollback**.
- **Node pool exhaustion** — pending pods; **cluster autoscaler** lag; **quota** limits hit.
- **Secret sprawl** — leaked **kubeconfig** or **workload identity** misbind; blast radius to data plane.
- **Ingress / AGIC** flapping — **502** storms; health probe tuning; **backend pool** limits.
- **etcd / API server** pressure from chatty controllers — need **rate limits** and **watch** hygiene.
