## Description

The platform must prove that at least one complex AI operator with a CRD (e.g., Ray, Kubeflow) can be installed and functions reliably. This includes verifying that the operator's pods run correctly, its webhooks are operational, and its custom resources can be reconciled.

## Evidence

### Prerequisites

* Provision a VKS v3.5.0 Cluster with v1.34.1 node pool, VM Class with vGPU profile and NVIDIA GPU Operator

* Log in to the cluster as admin

References:

- https://techdocs.broadcom.com/us/en/vmware-cis/private-ai/foundation-with-nvidia/9-0/private-ai-foundation-9-x/deploying-ai-workloads-on-tkg-clusters/deploy-a-gpu-accelerated-tkg-cluster-with-kubectl-connected.html

### Install KubeRay Operator

Add the following helm repos and install the kuberay-operator

```shell
helm repo add kuberay https://ray-project.github.io/kuberay-helm/
helm repo update
helm install kuberay-operator kuberay/kuberay-operator --version 1.4.2
```

```shell
NAME: kuberay-operator
LAST DEPLOYED: Wed Oct 22 13:14:14 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
Verify that the KubeRay Operator is functional
```

Verify that kuberay-operator pod is running and in Ready state

```shell
kubectl get po  -w
```
```shell
NAME                               READY   STATUS    RESTARTS   AGE
kuberay-operator-87c45b7f8-czg6d   1/1     Running   0          22s
```

### Install RayCluster

Install raycluster using the following helmchart

```shell
helm install -f ray-cluster.yaml raycluster kuberay/ray-cluster --version 1.4.2
```

```shell
NAME: raycluster
LAST DEPLOYED: Wed Oct 22 13:32:49 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

**Note**: Modify podsecurity and container security context of raycluster 

```shell
 podSecurityContext: 
    runAsNonRoot: true
    seccompProfile:
      type: RuntimeDefault
  securityContext:
    allowPrivilegeEscalation: false
    capabilities:
      drop:
        - ALL
```

Verify that raycluster resources are in Ready state

```shell
kubectl get rayclusters
```

```shell
NAME                 DESIRED WORKERS   AVAILABLE WORKERS   CPUS   MEMORY   GPUS   STATUS   AGE
raycluster-kuberay   1                 1                   2      3G       0      ready    4m18s
```

### Run KubeRay Job

Deploy a ray job for Modlin workload
```shell
kubectl apply -f https://raw.githubusercontent.com/ray-project/kuberay/master/ray-operator/config/samples/ray-job.modin.yaml
```

The job logs should be similar to the snippet below
```shell
kubectl logs -l=job-name=rayjob-sample
```

```shell
2025-10-23 03:09:25,423	INFO worker.py:1554 -- Using address 192.168.2.13:6379 set in the environment variable RAY_ADDRESS
2025-10-23 03:09:25,423	INFO worker.py:1694 -- Connecting to existing Ray cluster at address: 192.168.2.13:6379...
2025-10-23 03:09:25,435	INFO worker.py:1879 -- Connected to Ray cluster. View the dashboard at 192.168.2.13:8265
Modin Engine: Ray
FutureWarning: DataFrame.applymap has been deprecated. Use DataFrame.map instead.
Time to compute isnull: 0.1488487560000067
Time to compute rounded_trip_distance: 0.4387589910002134
2025-10-23 03:09:52,812	SUCC cli.py:65 -- -----------------------------------
2025-10-23 03:09:52,812	SUCC cli.py:66 -- Job 'rayjob-sample-r6dv4' succeeded
2025-10-23 03:09:52,812	SUCC cli.py:67 -- -----------------------------------
```
