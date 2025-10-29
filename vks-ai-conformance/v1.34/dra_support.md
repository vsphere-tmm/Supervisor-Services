## Description 

Support Dynamic Resource Allocation (DRA) APIs to enable more flexible and fine-grained resource requests beyond simple counts.

## Evidence

Dynamic Resource Allocation provides flexible resource management for specialised hardware like GPUs, FPGAs and network-attached devices. This guide covers how to configure DRA with VKS 3.5.

### Prerequisites

* Provision a VKS v3.5.0 Cluster with v1.34.1 node pool, VM Class with vGPU profile and NVIDIA GPU Operator

* Log in to the cluster as admin

References:

- https://techdocs.broadcom.com/us/en/vmware-cis/private-ai/foundation-with-nvidia/9-0/private-ai-foundation-9-x/deploying-ai-workloads-on-tkg-clusters/deploy-a-gpu-accelerated-tkg-cluster-with-kubectl-connected.html

- https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/managing-vsphere-kuberenetes-service-clusters-and-workloads/deploying-ai-ml-workloads-on-tkg-service-clusters/cluster-operator-workflow-for-deploying-ai-ml-workloads-on-tkg-service-clusters.html


### Verify GPU Operator

Pods in the gpu-operator namespace should be in running or completed state.

```shell
kubectl get pods -n gpu-operator
```

```shell
$ 
NAME                                                          READY   STATUS      RESTARTS      AGE
gpu-feature-discovery-8f6b9                                   1/1     Running     0             17h
gpu-feature-discovery-lftjn                                   1/1     Running     0             17h
gpu-feature-discovery-x2674                                   1/1     Running     0             17h
gpu-operator-6d5f7877bb-97wnn                                 1/1     Running     0             17h
gpu-operator-node-feature-discovery-gc-664cfcb6d9-q4kzw       1/1     Running     0             17h
gpu-operator-node-feature-discovery-master-6f97d7f876-ctghs   1/1     Running     0             17h
gpu-operator-node-feature-discovery-worker-9sc9d              1/1     Running     0             17h
gpu-operator-node-feature-discovery-worker-brbm9              1/1     Running     0             17h
gpu-operator-node-feature-discovery-worker-glpfx              1/1     Running     0             17h
gpu-operator-node-feature-discovery-worker-rttm5              1/1     Running     0             17h
nvidia-container-toolkit-daemonset-2x6bt                      1/1     Running     0             17h
nvidia-container-toolkit-daemonset-4sqn2                      1/1     Running     0             17h
nvidia-container-toolkit-daemonset-ltcbd                      1/1     Running     0             17h
nvidia-cuda-validator-ddd79                                   0/1     Completed   0             17h
nvidia-cuda-validator-gbq9w                                   0/1     Completed   0             17h
nvidia-cuda-validator-wgv47                                   0/1     Completed   0             17h
nvidia-dcgm-exporter-dll8g                                    1/1     Running     0             17h
nvidia-dcgm-exporter-lp26d                                    1/1     Running     0             17h
nvidia-dcgm-exporter-zbnb9                                    1/1     Running     0             17h
nvidia-device-plugin-daemonset-bnhtc                          1/1     Running     0             17h
nvidia-device-plugin-daemonset-cg9cm                          1/1     Running     0             17h
nvidia-device-plugin-daemonset-d7scr                          1/1     Running     0             17h
nvidia-driver-daemonset-f78lk                                 1/1     Running     1 (17h ago)   17h
nvidia-driver-daemonset-x642v                                 1/1     Running     1 (17h ago)   17h
nvidia-driver-daemonset-x6964                                 1/1     Running     0             17h
nvidia-operator-validator-88824                               1/1     Running     0             17h
nvidia-operator-validator-8wdqn                               1/1     Running     0             17h
nvidia-operator-validator-tm879                               1/1     Running     0             17h
```

Cluster nodes should carry labels with GPU information.

```shell
kubectl get node -o json | jq '.items[].metadata.labels'
```

```shell
{
  "nvidia.com/cuda.driver-version.full": "580.65.06",
  "nvidia.com/cuda.driver-version.major": "580",
  "nvidia.com/cuda.driver-version.minor": "65",
  "nvidia.com/cuda.driver-version.revision": "06",
  "nvidia.com/cuda.driver.major": "580",
  "nvidia.com/cuda.driver.minor": "65",
  "nvidia.com/cuda.driver.rev": "06",
  "nvidia.com/cuda.runtime-version.full": "13.0",
  "nvidia.com/cuda.runtime-version.major": "13",
  "nvidia.com/cuda.runtime-version.minor": "0",
  "nvidia.com/cuda.runtime.major": "13",
  "nvidia.com/cuda.runtime.minor": "0",
  "nvidia.com/gfd.timestamp": "1760623378",
  "nvidia.com/gpu-driver-upgrade-state": "upgrade-done",
  "nvidia.com/gpu.compute.major": "8",
  "nvidia.com/gpu.compute.minor": "0",
  "nvidia.com/gpu.count": "1",
  "nvidia.com/gpu.deploy.container-toolkit": "true",
  "nvidia.com/gpu.deploy.dcgm": "true",
  "nvidia.com/gpu.deploy.dcgm-exporter": "true",
  "nvidia.com/gpu.deploy.device-plugin": "true",
  "nvidia.com/gpu.deploy.driver": "true",
  "nvidia.com/gpu.deploy.gpu-feature-discovery": "true",
  "nvidia.com/gpu.deploy.node-status-exporter": "true",
  "nvidia.com/gpu.deploy.nvsm": "",
  "nvidia.com/gpu.deploy.operator-validator": "true",
  "nvidia.com/gpu.family": "ampere",
  "nvidia.com/gpu.machine": "VMware201",
  "nvidia.com/gpu.memory": "8192",
  "nvidia.com/gpu.mode": "compute",
  "nvidia.com/gpu.present": "true",
  "nvidia.com/gpu.product": "GRID-A100-8C",
  "nvidia.com/gpu.replicas": "1",
  "nvidia.com/gpu.sharing-strategy": "none",
  "nvidia.com/mig.capable": "false",
  "nvidia.com/mig.strategy": "single",
  "nvidia.com/mps.capable": "false",
  "nvidia.com/vgpu.host-driver-branch": "r581_36",
  "nvidia.com/vgpu.host-driver-version": "580.95.02",
  "nvidia.com/vgpu.present": "true",
}
{
  "nvidia.com/cuda.driver-version.full": "580.65.06",
  "nvidia.com/cuda.driver-version.major": "580",
  "nvidia.com/cuda.driver-version.minor": "65",
  "nvidia.com/cuda.driver-version.revision": "06",
  "nvidia.com/cuda.driver.major": "580",
  "nvidia.com/cuda.driver.minor": "65",
  "nvidia.com/cuda.driver.rev": "06",
  "nvidia.com/cuda.runtime-version.full": "13.0",
  "nvidia.com/cuda.runtime-version.major": "13",
  "nvidia.com/cuda.runtime-version.minor": "0",
  "nvidia.com/cuda.runtime.major": "13",
  "nvidia.com/cuda.runtime.minor": "0",
  "nvidia.com/gfd.timestamp": "1760623333",
  "nvidia.com/gpu-driver-upgrade-state": "upgrade-done",
  "nvidia.com/gpu.compute.major": "8",
  "nvidia.com/gpu.compute.minor": "0",
  "nvidia.com/gpu.count": "1",
  "nvidia.com/gpu.deploy.container-toolkit": "true",
  "nvidia.com/gpu.deploy.dcgm": "true",
  "nvidia.com/gpu.deploy.dcgm-exporter": "true",
  "nvidia.com/gpu.deploy.device-plugin": "true",
  "nvidia.com/gpu.deploy.driver": "true",
  "nvidia.com/gpu.deploy.gpu-feature-discovery": "true",
  "nvidia.com/gpu.deploy.node-status-exporter": "true",
  "nvidia.com/gpu.deploy.nvsm": "",
  "nvidia.com/gpu.deploy.operator-validator": "true",
  "nvidia.com/gpu.family": "ampere",
  "nvidia.com/gpu.machine": "VMware201",
  "nvidia.com/gpu.memory": "8192",
  "nvidia.com/gpu.mode": "compute",
  "nvidia.com/gpu.present": "true",
  "nvidia.com/gpu.product": "GRID-A100-8C",
  "nvidia.com/gpu.replicas": "1",
  "nvidia.com/gpu.sharing-strategy": "none",
  "nvidia.com/mig.capable": "false",
  "nvidia.com/mig.strategy": "single",
  "nvidia.com/mps.capable": "false",
  "nvidia.com/vgpu.host-driver-branch": "r581_36",
  "nvidia.com/vgpu.host-driver-version": "580.95.02",
  "nvidia.com/vgpu.present": "true",
}
{
  "nvidia.com/cuda.driver-version.full": "580.65.06",
  "nvidia.com/cuda.driver-version.major": "580",
  "nvidia.com/cuda.driver-version.minor": "65",
  "nvidia.com/cuda.driver-version.revision": "06",
  "nvidia.com/cuda.driver.major": "580",
  "nvidia.com/cuda.driver.minor": "65",
  "nvidia.com/cuda.driver.rev": "06",
  "nvidia.com/cuda.runtime-version.full": "13.0",
  "nvidia.com/cuda.runtime-version.major": "13",
  "nvidia.com/cuda.runtime-version.minor": "0",
  "nvidia.com/cuda.runtime.major": "13",
  "nvidia.com/cuda.runtime.minor": "0",
  "nvidia.com/gfd.timestamp": "1760623280",
  "nvidia.com/gpu-driver-upgrade-state": "upgrade-done",
  "nvidia.com/gpu.compute.major": "8",
  "nvidia.com/gpu.compute.minor": "0",
  "nvidia.com/gpu.count": "1",
  "nvidia.com/gpu.deploy.container-toolkit": "true",
  "nvidia.com/gpu.deploy.dcgm": "true",
  "nvidia.com/gpu.deploy.dcgm-exporter": "true",
  "nvidia.com/gpu.deploy.device-plugin": "true",
  "nvidia.com/gpu.deploy.driver": "true",
  "nvidia.com/gpu.deploy.gpu-feature-discovery": "true",
  "nvidia.com/gpu.deploy.node-status-exporter": "true",
  "nvidia.com/gpu.deploy.nvsm": "",
  "nvidia.com/gpu.deploy.operator-validator": "true",
  "nvidia.com/gpu.family": "ampere",
  "nvidia.com/gpu.machine": "VMware201",
  "nvidia.com/gpu.memory": "8192",
  "nvidia.com/gpu.mode": "compute",
  "nvidia.com/gpu.present": "true",
  "nvidia.com/gpu.product": "GRID-A100-8C",
  "nvidia.com/gpu.replicas": "1",
  "nvidia.com/gpu.sharing-strategy": "none",
  "nvidia.com/mig.capable": "false",
  "nvidia.com/mig.strategy": "single",
  "nvidia.com/mps.capable": "false",
  "nvidia.com/vgpu.host-driver-branch": "r581_36",
  "nvidia.com/vgpu.host-driver-version": "580.95.02",
  "nvidia.com/vgpu.present": "true",
}
```

### Install DRA Driver

To install [NVIDIA DRA Driver](https://github.com/NVIDIA/k8s-dra-driver-gpu/wiki/Installation), add the following helm repo

```shell
helm repo add nvidia https://helm.ngc.nvidia.com/nvidia && helm repo update
```

Install the driver

```shell
helm install nvidia-dra-driver-gpu nvidia/nvidia-dra-driver-gpu --version="25.3.2" --create-namespace --namespace nvidia-dra-driver-gpu --set nvidiaDriverRoot=/run/nvidia/driver --set resources.gpus.enabled=true --set gpuResourcesEnabledOverride=true
```

```shell
The output of the above command should be along the following lines
NAME: nvidia-dra-driver-gpu
LAST DEPLOYED: Thu Oct 16 18:41:00 2025
NAMESPACE: nvidia-dra-driver-gpu
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

The Driver installation creates the namespace `nvidia-dra-driver-gpu`. 

**Note**: The pod security policy in nvidia-dra-driver-gpu namespace should be set to privileged to proceed with driver installation and deployment of workloads.

```shell
kubectl label --overwrite ns nvidia-dra-driver-gpu pod-security.kubernetes.io/enforce=privileged
namespace/nvidia-dra-driver-gpu labeled
```

### Verify Driver Installation

The DRA controller and kubelet-plugin pods should be running and in `Ready` state

```shell
kubectl get pods -n nvidia-dra-driver-gpu
```

```shell
The output of the above command should be along the lines of the following snippet
NAME                                               READY   STATUS    RESTARTS   AGE
nvidia-dra-driver-gpu-controller-8f84b7988-tmwbj   1/1     Running   0          79s
nvidia-dra-driver-gpu-kubelet-plugin-lwkxk         2/2     Running   0          79s
nvidia-dra-driver-gpu-kubelet-plugin-t5vxk         2/2     Running   0          79s
nvidia-dra-driver-gpu-kubelet-plugin-wcp9k         2/2     Running   0          79s
```

DeviceClass resources should be created

```shell
kubectl get deviceclasses
```

```shell
NAME                                        AGE
compute-domain-daemon.nvidia.com            10m
compute-domain-default-channel.nvidia.com   10m
gpu.nvidia.com                              10m
mig.nvidia.com                              10m
```

ResourceSlice resources for the above DeviceClasses should be created

```shell
kubectl get resourceslice 
```

```shell
NAME                                                              NODE                                         DRIVER                      POOL                                         AGE
vks-cluster-0-np1-worker-njbp2-s2rvz-577zj-compute-domain.8lr89   vks-cluster-0-np1-worker-njbp2-s2rvz-577zj   compute-domain.nvidia.com   vks-cluster-0-np1-worker-njbp2-s2rvz-577zj   6m18s
vks-cluster-0-np1-worker-njbp2-s2rvz-577zj-gpu.nvidia.com-kkqkq   vks-cluster-0-np1-worker-njbp2-s2rvz-577zj   gpu.nvidia.com              vks-cluster-0-np1-worker-njbp2-s2rvz-577zj   6m18s
vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz-compute-domain.gvtc5   vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz   compute-domain.nvidia.com   vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz   6m18s
vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz-gpu.nvidia.com-sxjrp   vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz   gpu.nvidia.com              vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz   6m18s
vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj-compute-domain.jz2mg   vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj   compute-domain.nvidia.com   vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj   6m20s
vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj-gpu.nvidia.com-z2cjb   vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj   gpu.nvidia.com              vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj   6m20s
```

A detailed look at resourceslice resources can be seen for more information.

```shell
kubectl get resourceslices -o yaml
```

```shell
apiVersion: v1
items:
- apiVersion: resource.k8s.io/v1
  kind: ResourceSlice
  metadata:
    creationTimestamp: "2025-10-16T18:46:51Z"
    generateName: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj-compute-domain.nvidia.com-
    generation: 1
    name: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj-compute-domain.8lr89
    ownerReferences:
    - apiVersion: v1
      controller: true
      kind: Node
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj
      uid: c1d58aab-c4b7-4e65-abf8-7cff0deba3b3
    resourceVersion: "64504"
    uid: 48a5ed8c-6a62-448a-b2ee-f289181b5561
  spec:
    devices:
    - attributes:
        id:
          int: 0
        type:
          string: channel
      name: channel-0
    - attributes:
        id:
          int: 0
        type:
          string: daemon
      name: daemon-0
    driver: compute-domain.nvidia.com
    nodeName: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj
    pool:
      generation: 1
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj
      resourceSliceCount: 1
- apiVersion: resource.k8s.io/v1
  kind: ResourceSlice
  metadata:
    creationTimestamp: "2025-10-16T18:46:51Z"
    generateName: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj-gpu.nvidia.com-
    generation: 1
    name: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj-gpu.nvidia.com-kkqkq
    ownerReferences:
    - apiVersion: v1
      controller: true
      kind: Node
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj
      uid: c1d58aab-c4b7-4e65-abf8-7cff0deba3b3
    resourceVersion: "64505"
    uid: 56525f0a-57e4-474b-96b6-a5398cdb6801
  spec:
    devices:
    - attributes:
        architecture:
          string: Ampere
        brand:
          string: NvidiaVCS
        cudaComputeCapability:
          version: 8.0.0
        cudaDriverVersion:
          version: 13.0.0
        driverVersion:
          version: 580.65.6
        index:
          int: 0
        minor:
          int: 0
        pcieBusID:
          string: "0000:03:00.0"
        productName:
          string: GRID A100-8C
        resource.kubernetes.io/pcieRoot:
          string: pci0000:03
        type:
          string: gpu
        uuid:
          string: GPU-b8fe1770-6c2d-470f-905b-9ab700000000
      capacity:
        memory:
          value: 8Gi
      name: gpu-0
    driver: gpu.nvidia.com
    nodeName: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj
    pool:
      generation: 1
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-577zj
      resourceSliceCount: 1
- apiVersion: resource.k8s.io/v1
  kind: ResourceSlice
  metadata:
    creationTimestamp: "2025-10-16T18:46:51Z"
    generateName: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz-compute-domain.nvidia.com-
    generation: 1
    name: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz-compute-domain.gvtc5
    ownerReferences:
    - apiVersion: v1
      controller: true
      kind: Node
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz
      uid: 054493ec-a131-48a6-ae10-324471d611d1
    resourceVersion: "64506"
    uid: bc040439-13d0-449a-9428-42624aa311de
  spec:
    devices:
    - attributes:
        id:
          int: 0
        type:
          string: channel
      name: channel-0
    - attributes:
        id:
          int: 0
        type:
          string: daemon
      name: daemon-0
    driver: compute-domain.nvidia.com
    nodeName: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz
    pool:
      generation: 1
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz
      resourceSliceCount: 1
- apiVersion: resource.k8s.io/v1
  kind: ResourceSlice
  metadata:
    creationTimestamp: "2025-10-16T18:46:51Z"
    generateName: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz-gpu.nvidia.com-
    generation: 1
    name: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz-gpu.nvidia.com-sxjrp
    ownerReferences:
    - apiVersion: v1
      controller: true
      kind: Node
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz
      uid: 054493ec-a131-48a6-ae10-324471d611d1
    resourceVersion: "64507"
    uid: 99bb1bce-66f3-4a0b-8549-9abdd0579347
  spec:
    devices:
    - attributes:
        architecture:
          string: Ampere
        brand:
          string: NvidiaVCS
        cudaComputeCapability:
          version: 8.0.0
        cudaDriverVersion:
          version: 13.0.0
        driverVersion:
          version: 580.65.6
        index:
          int: 0
        minor:
          int: 0
        pcieBusID:
          string: "0000:03:00.0"
        productName:
          string: GRID A100-8C
        resource.kubernetes.io/pcieRoot:
          string: pci0000:03
        type:
          string: gpu
        uuid:
          string: GPU-ad362460-3713-4162-a903-758a00000000
      capacity:
        memory:
          value: 8Gi
      name: gpu-0
    driver: gpu.nvidia.com
    nodeName: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz
    pool:
      generation: 1
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-6jmwz
      resourceSliceCount: 1
- apiVersion: resource.k8s.io/v1
  kind: ResourceSlice
  metadata:
    creationTimestamp: "2025-10-16T18:46:49Z"
    generateName: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj-compute-domain.nvidia.com-
    generation: 1
    name: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj-compute-domain.jz2mg
    ownerReferences:
    - apiVersion: v1
      controller: true
      kind: Node
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj
      uid: 171bcf05-8bd9-4876-a57f-1d7d625dc9e1
    resourceVersion: "64476"
    uid: 94c7146f-2c90-4335-928f-b3107739e2e4
  spec:
    devices:
    - attributes:
        id:
          int: 0
        type:
          string: daemon
      name: daemon-0
    - attributes:
        id:
          int: 0
        type:
          string: channel
      name: channel-0
    driver: compute-domain.nvidia.com
    nodeName: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj
    pool:
      generation: 1
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj
      resourceSliceCount: 1
- apiVersion: resource.k8s.io/v1
  kind: ResourceSlice
  metadata:
    creationTimestamp: "2025-10-16T18:46:49Z"
    generateName: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj-gpu.nvidia.com-
    generation: 1
    name: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj-gpu.nvidia.com-z2cjb
    ownerReferences:
    - apiVersion: v1
      controller: true
      kind: Node
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj
      uid: 171bcf05-8bd9-4876-a57f-1d7d625dc9e1
    resourceVersion: "64477"
    uid: 323d1a9b-7f8a-4cda-8212-4028ac16844d
  spec:
    devices:
    - attributes:
        architecture:
          string: Ampere
        brand:
          string: NvidiaVCS
        cudaComputeCapability:
          version: 8.0.0
        cudaDriverVersion:
          version: 13.0.0
        driverVersion:
          version: 580.65.6
        index:
          int: 0
        minor:
          int: 0
        pcieBusID:
          string: "0000:03:00.0"
        productName:
          string: GRID A100-8C
        resource.kubernetes.io/pcieRoot:
          string: pci0000:03
        type:
          string: gpu
        uuid:
          string: GPU-71299acb-2e6c-4df9-abc2-a67c00000000
      capacity:
        memory:
          value: 8Gi
      name: gpu-0
    driver: gpu.nvidia.com
    nodeName: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj
    pool:
      generation: 1
      name: vks-cluster-0-np1-worker-njbp2-s2rvz-tnkwj
      resourceSliceCount: 1
kind: List
metadata:
  resourceVersion: ""
```

### Deploy a workload

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

**Note**: If the DRA Driver is left idle for more than 30 mins without any workload deployment, it may fail to schedule resources due to a known issue with DRA. To recover from this state, a manual restart of kubelet service is required on all the worker nodes.
