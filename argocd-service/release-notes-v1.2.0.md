# ArgoCD Service v1.2.0 Release Notes
Argo CD supervisor service reduces manual toil and introduced a policy to automatically discover and attach VKS clusters to the ArgoCD instances enabling quick start managing workloads in VKS clusters.

---
## What's New

### 1. The "Bridge" Strategy and Bundled Upstream Versions
To bring customers up to date with modern GitOps features and security patches, v1.2.0 bundles four upstream ArgoCD versions:
*   **ArgoCD v3.4.x**
*   **ArgoCD v3.3.x**
*   **ArgoCD v3.2.x** for upgrade only
*   **ArgoCD v3.1.x** for upgrade only

### 2. Auto Manage VKS as Target Cluster in ArgoCD instance

*   Introduces native support for auto-attaching workload VKS clusters.
* **Benefit:** Eliminates the manual cluster registration step, providing a seamless, out-of-the-box GitOps onboarding experience for newly provisioned Kubernetes clusters.

### 3. Security and Compliance fixes

### 4. Scale and Resource Sizing Improvements

---
## Note
ArgoCD Supervisor Service support for a new Kubernetes minor will lag VKS by 2-4 months (with the current upstream schedules: a June VKR gets downstream ArgoCD support in October, an October VKR gets downstream ArgoCD support in January, a February VKR gets downstream ArgoCD support in April).