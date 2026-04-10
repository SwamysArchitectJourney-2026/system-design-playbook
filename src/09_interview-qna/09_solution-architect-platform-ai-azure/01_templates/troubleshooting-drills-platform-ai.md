# Troubleshooting drills — Platform AI on Azure

Use after whiteboard warm-up. Expect **ordered diagnosis**, **metrics**, and **rollback**—not random config tweaks. Each drill: **2 min** restate, **5 min** drill-down, **3 min** prevention.

---

## Drill 1 — 429 / quota storm

**Symptom:** Production copilot **throttles**; dashboards show **429** from Azure OpenAI; **no** code deploy in 24h.

**Probe:** Regional **quota** vs **deployment** TPM; **burst** vs steady; **retry** amplification from **multiple replicas**; **shared** key across teams.

**Strong path:** Identify **which** client lacks **exponential backoff**; **temporary** routing to **second region**; **quota** increase vs **capacity** reservation; **per-tenant** limits at **APIM**.

**Prevention:** **Client-side** budgets; **cache**; **queue** for batch; **SLO** on **429 rate**.

---

## Drill 2 — Private Link “sometimes works”

**Symptom:** **Intermittent** timeouts from **AKS** to **Azure OpenAI** PE; **VM** in same VNet is stable.

**Probe:** **SNAT** port exhaustion on **node pool** egress; **CoreDNS** forwarder; **multiple** PE subnets; **asymmetric** routing after **UDR** change.

**Strong path:** **tcp** connectivity from **pod** to **PE IP**; **conntrack** / **NAT gateway** story; **split** DNS for `*.openai.azure.com`.

**Prevention:** **Outbound** architecture doc; **chaos** test after **network** changes.

---

## Drill 3 — Managed identity / token failures

**Symptom:** Pods log **401/403** calling OpenAI despite **“correct”** RBAC in portal.

**Probe:** **Wrong** identity bound; **federated** credential **audience**; **regional** endpoint vs **global** AAD; **cached** tokens in app.

**Strong path:** **oauth2** token trace; **jwt** claims; **role assignment** scope (RG vs resource); **time skew**.

**Prevention:** **Golden** path test in **CI**; **least** privilege **templates**.

---

## Drill 4 — Azure Policy blocks valid deploy

**Symptom:** **Terraform apply** fails new **Search** SKU in **prod**; **security** insists policy stays.

**Probe:** **Exemption** process; **policy** intent (deny public vs deny SKU); **duplicate** policies; **management group** inheritance.

**Strong path:** **Time-boxed** exemption with **ticket**; **policy** revision in **dev** MG first; **what-if** before merge.

**Prevention:** **Policy** CI; **documented** **exception** SLA.

---

## Drill 5 — GitOps vs Terraform drift fight

**Symptom:** **Argo** “heals” **Ingress** change; **Terraform** next run **reverts** **AGIC** config; outage risk.

**Probe:** **Ownership** boundary: **who** owns **which** object; **annotation** filters; **import** into state.

**Strong path:** **Single** writer rule; **split** resources by **lifecycle**; **import** or **remove** from one tool.

**Prevention:** **Architecture decision record**; **pre-commit** validation.

---

## Drill 6 — Databricks → Azure PaaS blocked

**Symptom:** Jobs **cannot** reach **AML** or **Storage** after **NSG** “hardening.”

**Probe:** **Service endpoints** vs **Private Link**; **Databricks** **control plane** vs **data plane**; **firewall** **FQDN** tags vs **private** endpoints.

**Strong path:** **Minimal** allow list from **Databricks** docs; **PE** for storage; **diagnostic** logs.

**Prevention:** **Reference** architecture **test** environment; **change** window with **rollback**.

---

## Drill 7 — Cost spike after AI go-live

**Symptom:** **Finance** escalates; **embedding** batch **10×** budget.

**Probe:** **Unbounded** re-embed; **wrong** model tier; **duplicate** indexes; **missing** **cache**.

**Strong path:** **Top** cost drivers by **resource** and **caller**; **quota** + **alert** thresholds; **technical** **debt** paydown plan.

**Prevention:** **Budgets** per **project**; **FinOps** **dashboard** in **MVP**.

---

## Drill 8 — Supply chain / image compromise suspicion

**Symptom:** **Defender** alert on **unsigned** image pulled in **AKS** prod.

**Probe:** **Admission** controller policy; **ACR** **task** history; **digest** pinning; **SBOM** availability.

**Strong path:** **Isolate** nodes; **rotate** secrets; **block** registry; **forensics** **retain** logs.

**Prevention:** **Only** trusted registries; **sign** and **verify**; **immutable** tags.
