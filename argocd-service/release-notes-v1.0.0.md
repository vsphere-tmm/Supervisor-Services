
# ArgoCD Service v1.0.0 Release Notes

## What's New

ArgoCD Service v1.0.0 introduces the following features:

- ✅ Supports creating and configuring **ArgoCD v2.14.13** instances.
  Refer to the [official documentation](https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/using-supervisor-services/using-argo-cd-service.html) for detailed instructions.

- ✅ Supports creating **multiple ArgoCD instances** within a Supervisor Cluster.

- ✅ Supports changing **pod replica count** and **resource quotas** for ArgoCD instances.

- ✅ Supports configuring **Local Account / OIDC authentication** with **global RBAC**.

- ✅ Supports configuring **ArgoCD Exclusions/Inclusions** settings.

- ✅ Supports managing workloads on **VCF 9.0**.

---

### ⚠️ Important Notes

- Please upgrade your **Supervisor Cluster** to version **9.0.0.0100** which includes support for Supervisor version 1.30.10 before installation.

- You **must use the customized ArgoCD CLI** to add Supervisor namespaces for workload management.

- **In-cluster configuration is not supported.** When creating an application for supervisor namespaces, use the **Supervisor Cluster LoadBalancer IP** (shown in the vSphere UI) as the destination instead of `https://kubernetes.default.svc`.

### ✅ Resources Supported by GitOps Workflow

| Resource Type         | ArgoCD managing Supervisor Cluster (NS Scope) | ArgoCD managing VKS (Cluster Scope) |
|-----------------------|-----------------------------------------------|--------------------------------------|
| **VKS LCM**           | ✅                                            | N/A                                  |
| **VM LCM**            | ✅                                            | N/A                                  |
| **PodVM LCM**         | ✅                                            | N/A                                  |
| **K8S Core Resource** | ✅                                            | ✅                                   |
| **Helm Resources**    | N/A                                           | ✅                                   |
| **Kustomize Resources** | N/A                                         | ✅                                   |
| **Jsonnet Resources** | N/A                                           | ✅                                   |

## Known Issues

### VKS Cluster Deleting

ArgoCD service `v1.0.0` by default uses **foreground cascading deletion**. With this policy, VKS cluster deletion will take **10–15 minutes**, since it tries to get and delete all the subresources **serially**.

To make this process faster (like `kubectl delete` behavior which takes 2–3 minutes), set the deletion policy to **background**. You can do this in one of three ways:

1. Set the flag in the delete command:
   ```bash
   argocd app delete <app-name> --propagation-policy=background
   ```

2. Patch the app before deletion:
   ```bash
   argocd app patch <app-name> --patch '{"metadata": {"finalizers": ["resources-finalizer.argocd.argoproj.io/background"]}}' --type merge
   ```

3. Add the background finalizer in the app manifest before creation/deletion:
   ```yaml
   metadata:
     finalizers:
       - resources-finalizer.argocd.argoproj.io/background
   ```

---

### 2. Total Number of NGINX Connections

When ArgoCD manages workloads in **supervisor namespaces**, it watches all CRDs. This creates many **long-lived watch connections** to the supervisor KubeAPI server. As a result, tens of watch connections are created to the **supervisor nginx server**.

If ArgoCD manages **multiple supervisor namespaces**, the total NGINX connection limit may be reached, causing errors.

#### Error Symptoms

In `argocd-application-controller-0` pod logs (namespace: `<argocd instance ns>`), you'll see:

```
E0627 07:06:55.213934       7 retrywatcher.go:131] "Watch failed" err="an error on the server ("<html>\r\n<head><title>500 Internal Server Error</title></head>\r\n<body>\r\n<center><h1>500 Internal Server Error</h1></center>\r\n<hr><center>nginx/1.26.2</center>\r\n</body>\r\n</html>") has prevented the request from succeeding"
E0627 07:06:55.213945       7 retrywatcher.go:131] "Watch failed" err="an error on the server ("<html>\r\n<head><title>500 Internal Server Error</title></head>\r\n<body>\r\n<center><h1>500 Internal Server Error</h1></center>\r\n<hr><center>nginx/1.26.2</center>\r\n</body>\r\n</html>") has prevented the request from succeeding"
```

In the `kubectl-plugin-vsphere-**` pod logs (namespace: `kube-system`), errors appear as:

```
2025/06/27 07:11:52 [alert] 7#0: 512 worker_connections are not enough
2025/06/27 07:11:52 [alert] 7#0: 512 worker_connections are not enough
2025/06/27 07:11:52 [alert] 7#0: 512 worker_connections are not enough
2025/06/27 07:11:52 [alert] 7#0: 512 worker_connections are not enough
```

> 💡 Consider using the **inclusion/exclusion** feature of ArgoCD service to reduce CRD watches and conserve connections.

---

### 3. ComparisonError After VKS Upgrade (3.3 → 3.4)

When VKS is upgraded from `3.3` to `3.4`, ArgoCD may show `ComparisonError` in the UI or CLI for the VKS Cluster spec.

This is caused by changes in the `Cluster` CRD. The `argocd-application-controller` may still cache the **old schema**, leading to diff errors.

#### Error Log Example

```
ComparisonError  Failed to compare desired state to live state: failed to calculate diff: error calculating server side diff: serverSideDiff error: error removing non config mutations for resource Cluster/vks-cluster-e2e: error converting predicted live state from unstructured to cluster.x-k8s.io/v1beta1, Kind=Cluster: .spec.topology.classNamespace: field not declared in schema
```

#### Workaround

Restart the `argocd-application-controller` pod to refresh the cached CRD schema.
