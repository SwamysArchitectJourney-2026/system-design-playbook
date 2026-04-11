# Failure scenarios — Azure AI platform landing zone

Each scenario includes: **symptom → root cause → recovery path → prevention signal**.

---

## F1 — Regional Azure OpenAI degradation

**Symptom:** Spike in 503 / 429 from APIM; AOAI health page shows `impaired` for primary region.

**Root cause:** Model deployment unavailable or regional capacity exhausted. APIM pointing to a single AOAI endpoint with no circuit-breaker.

**Recovery path:**
1. APIM backend pool routes to secondary region AOAI (active/active or active/standby).
2. For prompts with high cost tolerances, serve **Redis cached** responses where semantic similarity ≥ 0.95.
3. Non-critical paths fall back to a **cheaper or faster model** (e.g., GPT-4o-mini) while GPT-4o is degraded.
4. Surface a `X-Degraded-Mode: true` header so calling apps can show a UX indicator.

**Prevention signal (interviewer):** Can they name the APIM `retry` and `set-backend-service` policies and explain how to configure a round-robin backend pool across two AOAI endpoints?

---

## F2 — Misconfigured Private Link: silent timeouts

**Symptom:** Calls to Azure OpenAI succeed from developer laptops but time out from production AKS pods.

**Root cause:** Private DNS zone `privatelink.openai.azure.com` is not linked to the AKS VNet, so pods resolve the **public IP** which is blocked by the AOAI network ACL.

**Recovery path:**
1. Add a VNet link for the spoke VNet to the private DNS zone in the hub.
2. Verify with `kubectl exec -- nslookup <endpoint>` — must return RFC-1918 IP.
3. Check NSG on the PE subnet: TCP 443 inbound from AKS pod CIDR.
4. Validate with health probe that hits the **actual inference path** (not a `/ping` returning 200 before network traversal).

**Prevention signal:** "Our smoke test calls the actual model, not just a health endpoint stub."

---

## F3 — Over-privileged service principal: blast radius across subscriptions

**Symptom:** Security team alert: a single service principal has `Contributor` on three subscriptions. One SPN secret was found committed in a dev repo.

**Root cause:** IaC team took a shortcut during initial provisioning — assigned broad scope to avoid RBAC errors. Secret rotation never enforced.

**Recovery path:**
1. **Immediately rotate** the exposed secret / revoke client secret; issue new federated credential.
2. **Narrow RBAC scope** to specific resource groups per workload using least-privilege roles (`Cognitive Services OpenAI Contributor`, not `Contributor`).
3. **Enable PIM** for any remaining broad roles; require JIT activation with approval.
4. Add `Azure Policy` to **deny** `Owner` or `Contributor` grants on subscription scope without an exemption ticket.

**Prevention signal:** "We use federated credentials for all pipelines — no long-lived client secrets. RBAC is scoped to RG, not subscription."

---

## F4 — IaC pipeline compromise via supply chain

**Symptom:** Defender for DevOps flags a Terraform provider version pinned to a compromised version. A PR merged a module bump without manual review.

**Root cause:** Pipeline allows `terraform init` to pull any provider version matching a loose constraint (`~> 3.0`). No module signing or SBOM enforcement.

**Recovery path:**
1. Pin all providers to exact versions (`= 3.84.0`) in `required_providers`.
2. Add **Checkov / tfsec** to PR gate — blocks merge if provider not in allowlist.
3. Requires `terraform plan` output reviewed and approved before `apply` in prod.
4. Retro-apply `terraform plan -refresh-only` to confirm no state drift from the compromised run.

**Prevention signal:** "Version pinning + signed module registry. `terraform apply` on prod requires a named human approver in the pipeline."

---

## F5 — Databricks / AML network path exposes data plane

**Symptom:** Data exfiltration alert from Defender for Cloud: an AML compute cluster made an outbound connection to an external IP.

**Root cause:** AML compute cluster in a VNet with a route pulling traffic through a public NAT gateway instead of the hub firewall. No egress filter on the AML subnet.

**Recovery path:**
1. Force route `0.0.0.0/0` to Azure Firewall NVA in hub via UDR on the AML subnet.
2. Enable **no-public-IP** compute clusters and **CMK-encrypted** managed storage.
3. Add NSG rule: deny all outbound except to approved private endpoints and Azure backbone tags.
4. Review audit logs for Volume of data transferred before the fix.

**Prevention signal:** "AML compute subnets have a UDR forcing egress through the firewall. Private workspace only — no public web access from compute clusters."

---

## F6 — Azure Policy blocks a valid preview feature deployment

**Symptom:** `terraform apply` fails in prod with `RequestDisallowedByPolicy`. The resource being deployed is an Azure OpenAI fine-tuned model deployment using a feature in preview.

**Root cause:** A policy assignment at the management group level restricts deployment of resources matching `Microsoft.CognitiveServices/accounts/deployments` without an approved SKU list that pre-dates the preview SKU.

**Recovery path:**
1. Identify the blocking assignment: `az policy assignment list --scope /providers/Microsoft.Management/managementGroups/<mg>`.
2. Create a **time-bounded policy exemption** (expiry 30 days) for the target resource scope with a business justification.
3. Track the exemption in a ticketing system with an owner.
4. After preview GA, update the policy definition's allowlist to include the new SKU and remove the exemption.

**Prevention signal:** "We run `az policy what-if` or `Terraform plan` with policy simulator before deploying to prod. Exemptions have expiry dates and are reviewed quarterly."

---

## F7 — AI Search hot partition degrading RAG retrieval

**Symptom:** P99 latency for RAG queries spikes to 8s; AI Search `SearchLatency` metric shows `SearchThrottledQueriesPercentage` > 40%.

**Root cause:** Semantic ranker is enabled but Search Units (SUs) were not increased when query volume tripled post-launch. All traffic lands on a single replica.

**Recovery path:**
1. Scale AI Search tier: add replicas (scale-out for query throughput) and partitions (scale-out for index size / ingestion).
2. Implement **Redis semantic cache** upstream in APIM for repeated or near-identical queries — reduces raw Search load by 30–60%.
3. Enable **query result caching** for deterministic filter queries.
4. Review index schema: over-vectorization (embedding every field) bloats index and slows retrieval.

**Prevention signal:** "Search SU sizing is part of our capacity model. We cache semantically equivalent queries in Redis and track `ThrottledQueriesPercentage` in our SLO dashboard."

---

## F8 — Managed identity token failure in AKS workload

**Symptom:** AKS pod returns `401 Unauthorized` calling Azure OpenAI. Pod logs show `AADSTS70021: No matching federated identity credential found`.

**Root cause:** The service account annotation points to a managed identity that exists, but the **federated credential** was created with the wrong Kubernetes namespace or service account name — audience mismatch.

**Recovery path:**
1. Retrieve the federated credential config: `az identity federated-credential list --identity-name <mi> --resource-group <rg>`.
2. Compare `subject` field (`system:serviceaccount:<namespace>:<sa-name>`) against `kubectl get sa -n <ns>`.
3. Correct the subject or recreate the federated credential with the exact namespace + SA name.
4. Verify `Azure Workload Identity` mutating webhook is injecting the `AZURE_CLIENT_ID` env var into the pod.

**Prevention signal:** "We have a smoke test that validates MI token acquisition from inside the pod as part of our CD pipeline post-deploy validation step."

---

## Quick-recall matrix

| Failure | First diagnostic move | Key term to say |
|---------|-----------------------|-----------------|
| Regional AOAI degradation | Check APIM backend pool health | Circuit breaker, semantic cache fallback |
| Private Link silent timeout | `nslookup` from inside pod | Private DNS zone VNet link |
| Over-privileged SPN | PIM blast radius review | Federated credential, JIT |
| IaC supply chain | Provider version pin audit | Signed module registry, SBOM |
| AML network exfiltration | UDR egress path audit | Firewall NVA, no-public-IP compute |
| Policy blocks preview | `az policy what-if` | Time-bounded exemption |
| AI Search hot partition | `ThrottledQueriesPercentage` | SU scaling, semantic cache |
| MI token failure | Federated credential subject mismatch | Workload identity, audience |
