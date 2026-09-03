# ArgoCD Service v1.2.0 Release Notes
Argo CD Supervisor Service reduces manual toil and introduces declarative policies to automatically discover and attach VKS clusters and Supervisor Namespaces to ArgoCD instances, enabling seamless GitOps workload management.

## What's New

### 1. The "Bridge" Strategy and Bundled Upstream Versions
To bring customers up to date with modern GitOps features and security patches, v1.2.0 bundles four upstream ArgoCD versions:
* **ArgoCD v3.4.4**
* **ArgoCD v3.3.12**
* **ArgoCD v3.2.12** for upgrade only
* **ArgoCD v3.1.16** for upgrade only

The cluster-scoped `ArgoCDVersion` resource (`argocd-supported-versions`) displays the list of supported upstream ArgoCD versions.

### 2. Auto Manage VKS as Target Cluster in ArgoCD Instance
* **`EntityManagementPolicy` (`emp`)**: Introduces declarative policy support to automatically discover and attach VKS clusters to ArgoCD instances based on namespace selectors, cluster names, label selectors, or CEL expressions.

### 3. Declarative Target Registration (`ManagedEntity`)
* **`ManagedEntity` (`me`)**: Standardizes declarative target registration in ArgoCD:
  * **VKS Clusters**: Registers VKS clusters for cluster-scoped workload management.
  * **Supervisor Namespaces**: Registers each Supervisor Namespace as a dedicated, standalone target cluster in ArgoCD for isolated namespace-scoped workload management.

### 4. ArgoCD CR Enhancements
* **Custom Lua Resource Health Checks**: Added `spec.resourceHealthChecks` to inject custom Lua health check scripts for custom CRDs and VKS cluster resources.
* **Component-Level Proxy Configuration**: Added fine-grained `proxy` (`httpProxy`, `httpsProxy`, `noProxy`) settings across `server`, `repo`, `controller`, `applicationSet`, and `notification` components.
* **Status & Generation Guards**: Added `observedGeneration` and phase states (`Progressing`, `Ready`, `Failed`) for clear and reliable status tracking.

### 5. Upstream ArgoCD CLI as VCF Plugin
* Bundles the upstream `argocd` CLI as a `vcf` CLI plugin, eliminating the previous requirement of downloading a customized standalone ArgoCD CLI binary.

### 6. Security and Compliance Improvements
* **Valkey Caching Engine**: Replaced Redis with **Valkey** as the in-memory cache and session store, providing a drop-in Redis-compatible engine while addressing open-source licensing and CVE concerns.
* **FIPS 140-3 Compliance**: Enforces `GO FIPS 140-3` across controller binaries.
* **TLS Secret References**: Added `spec.server.tlsCert.secretRef` to allow referencing Kubernetes TLS Secrets directly for custom certificates, deprecating inline base64 certificates.

## Fixed Issues

### Supervisor NGINX Connection Exhaustion When Managing Multiple Supervisor Namespaces

**Issue Description (in v1.0.0 / v1.1.0)**:  
In previous versions, managing workloads across Supervisor Namespaces required routing long-lived CRD watch connections through the external Supervisor LoadBalancer IP / VIP. Under scale, this exhausted NGINX worker connections (`512 worker_connections are not enough`) on the Supervisor reverse proxy (`kubectl-plugin-vsphere`), resulting in `500 Internal Server Error` watch failures in `argocd-application-controller`.

**Resolution (in v1.2.0)**:  
v1.2.0 enables **In-Cluster connectivity** via the dedicated ServiceAccount `argocd-k8s-sa`, routing all API watch and sync traffic internally within the Supervisor cluster and completely bypassing the external LoadBalancer and NGINX reverse proxy.

Two in-cluster topologies are supported:
1. **Declarative Standalone Multi-Cluster via `ManagedEntity` (Recommended)**:
   * Registers each Supervisor Namespace as an isolated target cluster endpoint (`https://kubernetes.default.svc/?context=<target-namespace>`).
   * Recommended for general deployments, offering full declarative lifecycle management and RBAC isolation.
2. **High-Density Multi-Namespace via Native CLI / Secret**:
   * Groups multiple namespaces under a single unified cluster endpoint (`https://kubernetes.default.svc`) sharing a single OpenAPI schema cache.
   * Recommended for large-scale, high-density environments to minimize controller memory overhead.

**Migration Note for Existing Applications**:  
When adopting `ManagedEntity` to manage existing Supervisor Namespace workloads (refer to the [official documentation](https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/using-supervisor-services/using-argo-cd-service.html) for RBAC and `ManagedEntity` configuration details), update the `destination` block in your existing ArgoCD Application manifests to align with the new in-cluster target:

* **Option A (By Server URL)**:
  ```yaml
  spec:
    destination:
      server: https://kubernetes.default.svc/?context=<target-namespace>
      namespace: <target-namespace>
  ```
* **Option B (By Cluster Name)**:
  ```yaml
  spec:
    destination:
      name: <target-namespace> # or custom spec.clusterName configured in ManagedEntity
      namespace: <target-namespace>
  ```

> ⚠️ **Note**: Using the legacy destination `https://<Supervisor-LB-VIP>:6443` is **not recommended** for Supervisor Namespace management. Continuing to use the external LoadBalancer endpoint will still encounter NGINX connection limit issues.


## Note
ArgoCD Supervisor Service support for a new Kubernetes minor will lag VKS by 2-4 months (with the current upstream schedules: a June VKR gets downstream ArgoCD support in October, an October VKR gets downstream ArgoCD support in January, a February VKR gets downstream ArgoCD support in April).
