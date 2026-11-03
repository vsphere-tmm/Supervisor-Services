# ArgoCD Service v1.3.0 Release Notes

ArgoCD Service v1.3.0 expands GitOps management on VMware Cloud Foundation (VCF) with cache high availability, standalone Supervisor CLI support, cascading deletion, Terraform support, and increased scale.

## What's New

### 1. Updated Bundled Argo CD Versions

ArgoCD Service v1.3.0 bundles the following upstream Argo CD versions:

- Argo CD v3.5.3
- Argo CD v3.4.9

### 2. VCF CLI Support for Standalone Supervisor Environments

The `vcf argocd` CLI plugin now supports instance lifecycle management and registration of vSphere Namespaces and VMware vSphere Kubernetes Service (VKS) clusters directly on Supervisor clusters, without requiring VCF Automation integration.

### 3. High Availability for the Valkey Cache

Adds optional high availability for the Valkey cache, with automatic failover to improve cache availability. High availability is disabled by default and can be enabled for each ArgoCD instance.

### 4. Configurable Cascading Deletion

Adds an option to automatically remove associated applications and management resources when deleting an ArgoCD instance. Cascading deletion is disabled by default, preserving associated resources unless explicitly enabled. Application deletion may also remove deployed workloads, depending on the application's deletion settings.

### 5. Terraform Support

Provides Terraform configurations using the Kubernetes provider to declaratively manage ArgoCD Service resources in both Supervisor Service and VCF Service environments.

### 6. Increased Scale

A single ArgoCD instance now supports managing up to **100 vSphere Namespaces** or **200 VKS clusters**. When managing both types, the combined total is limited to **200**, and the vSphere Namespace count is limited to **100**. Each vSphere Namespace and each VKS cluster counts as one managed cluster in Argo CD.

## Upgrade and Operational Notes

- **VCF ArgoCD CLI plugin:** Upgrade the `vcf argocd` CLI plugin to **v1.3.0** to fully use the new features in ArgoCD Service v1.3.0.
- **Service upgrade:** Upgrades to v1.3.0 are supported from ArgoCD Service v1.2.x. Before upgrading the service, upgrade Argo CD instances running versions earlier than v3.4 to an available v3.4.x version through ArgoCD Service v1.2.x.
