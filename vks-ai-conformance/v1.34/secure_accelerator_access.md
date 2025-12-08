## Description 

Ensure that access to accelerators from within containers is properly isolated and mediated by the Kubernetes resource management framework (device plugin or DRA) and container runtime, preventing unauthorized access or interference between workloads.

## Evidence

### Test 1: Ensure that access to accelerators from within containers is properly isolated and mediated by the Kubernetes resource management framework (device plugin or DRA) and container runtime, preventing unauthorized access or interference between workloads

#### Prerequisites

* Provision a VKS v3.5.0 Cluster with v1.34.1 node pool, VM Class with vGPU profile and NVIDIA GPU Operator

* Log in to the cluster as admin

References:

- https://techdocs.broadcom.com/us/en/vmware-cis/private-ai/foundation-with-nvidia/9-0/private-ai-foundation-9-x/deploying-ai-workloads-on-tkg-clusters/deploy-a-gpu-accelerated-tkg-cluster-with-kubectl-connected.html

#### Install DRA Driver

Add the following helm repo to initiate driver installation

```shell
helm repo add nvidia https://helm.ngc.nvidia.com/nvidia && helm repo update
```

Install the driver

```shell
helm install nvidia-dra-driver-gpu nvidia/nvidia-dra-driver-gpu --version="25.3.2" --create-namespace --namespace nvidia-dra-driver-gpu --set nvidiaDriverRoot=/run/nvidia/driver --set resources.gpus.enabled=true --set gpuResourcesEnabledOverride=true
```

The Driver installation creates the namespace `nvidia-dra-driver-gpu`. 

**Note**: The pod security policy in nvidia-dra-driver-gpu namespace should be set to privileged to proceed with driver installation and deployment of workloads.

```shell
kubectl label --overwrite ns nvidia-dra-driver-gpu pod-security.kubernetes.io/enforce=privileged
namespace/nvidia-dra-driver-gpu labeled
```

#### Deploy a workload

To deploy a workload that utilises DRA, 

- create a `ResourceClaimTemplate` containing the `DeviceClass` requests

- create a deployment that references the `ResourceClaimTemplate`

```shell
kubectl apply -f resource-claim-template.yaml
kubectl apply -f dra-deployment.yaml
```

Verify that the ResourceClaim resources are created

```shell
kubectl get resourceclaims -n gpu-test1
```

```shell
NAME                                                STATE                AGE
dra-gpu-example-68f595d7dc-6f892-single-gpu-cbv9k   allocated,reserved   9m48s
```

Verify that the deployment is up and running

```shell
kubectl get pods -n gpu-test1
```

```shell
NAME                              READY   STATUS    RESTARTS   AGE
dra-gpu-example-b7c8c55dd-wgfvn   1/1     Running   0          56m
```

Verify that the pod has access to GPU resources

```shell
kubectl logs dra-gpu-example-b7c8c55dd-wgfvn -n gpu-test1
```

```shell
Fri Oct 17 05:55:14 UTC 2025
GPU 0: GRID A100-8C (UUID: GPU-b8fe1770-6c2d-470f-905b-9ab700000000)
```

### Test 2: Ensure that access to accelerators from within containers is properly isolated and mediated by the Kubernetes resource management framework (device plugin or DRA) and container runtime, preventing unauthorized access or interference between workloads

Run the DRA E2E test to verify that configs and devices are mapped to the right containers preventing unauthorized access or interference between workloads

```shell
mkdir k8s.io && cd k8s.io && git clone https://github.com/kubernetes/kubernetes
cd kubernetes
git checkout v1.34.1
```

```shell
$ make WHAT="github.com/onsi/ginkgo/v2/ginkgo k8s.io/kubernetes/test/e2e/e2e.test" && KUBERNETES_PROVIDER=local hack/ginkgo-e2e.sh -ginkgo.focus='must map configs and devices to the right containers'
go: downloading go1.25.3 (linux/amd64)
+++ [1017 06:53:51] Building go targets for linux/amd64
    github.com/onsi/ginkgo/v2/ginkgo (non-static)
    k8s.io/kubernetes/test/e2e/e2e.test (test)
Setting up for KUBERNETES_PROVIDER="local".
Skeleton Provider: prepare-e2e not implemented
KUBE_MASTER_IP: 
KUBE_MASTER: 
  I1017 06:56:24.451340 2909692 e2e.go:109] Starting e2e run "e5f0168d-9234-4b63-945e-3441999f117b" on Ginkgo node 1
Running Suite: Kubernetes e2e suite - /home/vks/go/src/k8s.io/kubernetes/_output/bin
======================================================================================
Random Seed: 1760684183 - will randomize all specs
Will run 1 of 7196 specs
•
Ran 1 of 7196 Specs in 18.827 seconds
SUCCESS! -- 1 Passed | 0 Failed | 0 Pending | 7195 Skipped
PASS
Ginkgo ran 1 suite in 19.685371808s
Test Suite Passed
```

