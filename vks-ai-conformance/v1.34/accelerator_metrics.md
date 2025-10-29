## Description

For supported accelerator types, the platform must allow for the installation and successful operation of at least one accelerator metrics solution that exposes fine-grained performance metrics via a standardized, machine-readable metrics endpoint. This must include a core set of metrics for per-accelerator utilization and memory usage. Additionally, other relevant metrics such as temperature, power draw, and interconnect bandwidth should be exposed if the underlying hardware or virtualization layer makes them available. The list of metrics should align with emerging standards, such as OpenTelemetry metrics, to ensure interoperability. The platform may provide a managed solution, but this is not required for conformance.

## Evidence

### Prerequisites

* Provision a VKS v3.5.0 Cluster with v1.34.1 node pool, VM Class with vGPU profile and NVIDIA GPU Operator

* Log in to the cluster as admin

References:

- https://techdocs.broadcom.com/us/en/vmware-cis/private-ai/foundation-with-nvidia/9-0/private-ai-foundation-9-x/deploying-ai-workloads-on-tkg-clusters/deploy-a-gpu-accelerated-tkg-cluster-with-kubectl-connected.html

- https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/managing-vsphere-kuberenetes-service-clusters-and-workloads/deploying-ai-ml-workloads-on-tkg-service-clusters/cluster-operator-workflow-for-deploying-ai-ml-workloads-on-tkg-service-clusters.html

NVIDIA GPU Operator includes [DCGM Exporter](https://github.com/NVIDIA/dcgm-exporter?tab=readme-ov-file#quickstart-on-kubernetes) which exposes metrics from the accelerator hardware.

Verify that GPU Operator is running

```shell
kubectl get pods -n gpu-operator
NAME                                                          READY   STATUS      RESTARTS   AGE
gpu-feature-discovery-8n7gw                                   1/1     Running     0          53m
gpu-feature-discovery-lb4m9                                   1/1     Running     0          53m
gpu-feature-discovery-wdqdf                                   1/1     Running     0          54m
gpu-operator-6d5f7877bb-t2qwm                                 1/1     Running     0          54m
gpu-operator-node-feature-discovery-gc-664cfcb6d9-rsrn4       1/1     Running     0          54m
gpu-operator-node-feature-discovery-master-6f97d7f876-gsmc8   1/1     Running     0          54m
gpu-operator-node-feature-discovery-worker-66dll              1/1     Running     0          54m
gpu-operator-node-feature-discovery-worker-gfw8v              1/1     Running     0          54m
gpu-operator-node-feature-discovery-worker-m8ww7              1/1     Running     0          54m
gpu-operator-node-feature-discovery-worker-rdh4s              1/1     Running     0          54m
nvidia-container-toolkit-daemonset-2zdhj                      1/1     Running     0          53m
nvidia-container-toolkit-daemonset-5tf85                      1/1     Running     0          54m
nvidia-container-toolkit-daemonset-dwrdm                      1/1     Running     0          53m
nvidia-cuda-validator-4vks                                    0/1     Completed   0          51m
nvidia-cuda-validator-6pl5b                                   0/1     Completed   0          52m
nvidia-cuda-validator-bmwjr                                   0/1     Completed   0          51m
nvidia-dcgm-exporter-86nqp                                    1/1     Running     0          54m
nvidia-dcgm-exporter-mz6q4                                    1/1     Running     0          53m
nvidia-dcgm-exporter-vgmc2                                    1/1     Running     0          53m
nvidia-device-plugin-daemonset-mn8tc                          1/1     Running     0          54m
nvidia-device-plugin-daemonset-nk7d2                          1/1     Running     0          53m
nvidia-device-plugin-daemonset-qmrzd                          1/1     Running     0          53m
nvidia-driver-daemonset-nlgbv                                 1/1     Running     0          54m
nvidia-driver-daemonset-s5s7l                                 1/1     Running     0          54m
nvidia-driver-daemonset-s6f2t                                 1/1     Running     0          54m
nvidia-operator-validator-452nf                               1/1     Running     0          54m
nvidia-operator-validator-bp5nf                               1/1     Running     0          53m
nvidia-operator-validator-r2rv2                               1/1     Running     0          53m
```

Verify that DCGM Exporter is hosting metrics from the underlying GPU.

```shell
curl -sL http://127.0.0.1:8080/metrics
Handling connection for 8080
# HELP DCGM_FI_DEV_SM_CLOCK SM clock frequency (in MHz).
# TYPE DCGM_FI_DEV_SM_CLOCK gauge
DCGM_FI_DEV_SM_CLOCK{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 1410
# HELP DCGM_FI_DEV_MEM_CLOCK Memory clock frequency (in MHz).
# TYPE DCGM_FI_DEV_MEM_CLOCK gauge
DCGM_FI_DEV_MEM_CLOCK{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 1215
# HELP DCGM_FI_DEV_MEMORY_TEMP Memory temperature (in C).
# TYPE DCGM_FI_DEV_MEMORY_TEMP gauge
DCGM_FI_DEV_MEMORY_TEMP{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 0
# HELP DCGM_FI_DEV_GPU_UTIL GPU utilization (in %).
# TYPE DCGM_FI_DEV_GPU_UTIL gauge
DCGM_FI_DEV_GPU_UTIL{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 0
# HELP DCGM_FI_DEV_MEM_COPY_UTIL Memory utilization (in %).
# TYPE DCGM_FI_DEV_MEM_COPY_UTIL gauge
DCGM_FI_DEV_MEM_COPY_UTIL{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 0
# HELP DCGM_FI_DEV_ENC_UTIL Encoder utilization (in %).
# TYPE DCGM_FI_DEV_ENC_UTIL gauge
DCGM_FI_DEV_ENC_UTIL{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 0
# HELP DCGM_FI_DEV_DEC_UTIL Decoder utilization (in %).
# TYPE DCGM_FI_DEV_DEC_UTIL gauge
DCGM_FI_DEV_DEC_UTIL{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 0
# HELP DCGM_FI_DEV_XID_ERRORS Value of the last XID error encountered.
# TYPE DCGM_FI_DEV_XID_ERRORS gauge
DCGM_FI_DEV_XID_ERRORS{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06",err_code="0",err_msg="No Error"} 0
# HELP DCGM_FI_DEV_FB_FREE Framebuffer memory free (in MiB).
# TYPE DCGM_FI_DEV_FB_FREE gauge
DCGM_FI_DEV_FB_FREE{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 7531
# HELP DCGM_FI_DEV_FB_USED Framebuffer memory used (in MiB).
# TYPE DCGM_FI_DEV_FB_USED gauge
DCGM_FI_DEV_FB_USED{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 0
# HELP DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL Total number of NVLink bandwidth counters for all lanes.
# TYPE DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL counter
DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 0
# HELP DCGM_FI_DEV_VGPU_LICENSE_STATUS vGPU License status
# TYPE DCGM_FI_DEV_VGPU_LICENSE_STATUS gauge
DCGM_FI_DEV_VGPU_LICENSE_STATUS{gpu="0",UUID="GPU-f809e614-a528-4083-acbf-334600000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="GRID A100-8C",Hostname="vks-cluster-0-0-np1-worker-xtxww-xw4wp-wn7j2",DCGM_FI_DRIVER_VERSION="580.65.06"} 0
```
