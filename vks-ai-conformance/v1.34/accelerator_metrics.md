## Description

For supported accelerator types, the platform must allow for the installation and successful operation of at least one accelerator metrics solution that exposes fine-grained performance metrics via a standardized, machine-readable metrics endpoint. This must include a core set of metrics for per-accelerator utilization and memory usage. Additionally, other relevant metrics such as temperature, power draw, and interconnect bandwidth should be exposed if the underlying hardware or virtualization layer makes them available. The list of metrics should align with emerging standards, such as OpenTelemetry metrics, to ensure interoperability. The platform may provide a managed solution, but this is not required for conformance.

## Evidence

Complete guide to configure Accelerator Metrics using NVIDIA DCGM with Prometheus Operator on VKS v3.5.0 and Kubernetes v1.34.1.

### Prerequisites

* Provision a VKS v3.5.0 Cluster with v1.34.1 node pool, VM Class with vGPU profile and NVIDIA GPU Operator

* Log in to the cluster as admin

References:

- https://techdocs.broadcom.com/us/en/vmware-cis/private-ai/foundation-with-nvidia/9-0/private-ai-foundation-9-x/deploying-ai-workloads-on-tkg-clusters/deploy-a-gpu-accelerated-tkg-cluster-with-kubectl-connected.html

NVIDIA GPU Operator includes [DCGM Exporter](https://github.com/NVIDIA/dcgm-exporter?tab=readme-ov-file#quickstart-on-kubernetes) which exposes metrics from the accelerator hardware.

Verify that GPU Operator is running

```shell
kubectl get pods -n gpu-operator
NAME                                                          READY   STATUS      RESTARTS   AGE
gpu-operator                   gpu-feature-discovery-7wk59                                              1/1     Running     0               5h20m
gpu-operator                   gpu-operator-84d7d7c545-tgtk9                                            1/1     Running     0               5h21m
gpu-operator                   gpu-operator-node-feature-discovery-gc-664cfcb6d9-5bdmk                  1/1     Running     0               5h21m
gpu-operator                   gpu-operator-node-feature-discovery-master-6f97d7f876-lnpjc              1/1     Running     0               5h21m
gpu-operator                   gpu-operator-node-feature-discovery-worker-8nwwd                         1/1     Running     0               5h21m
gpu-operator                   gpu-operator-node-feature-discovery-worker-bkgw4                         1/1     Running     0               5h21m
gpu-operator                   nvidia-container-toolkit-daemonset-ck9qv                                 1/1     Running     0               5h20m
gpu-operator                   nvidia-cuda-validator-98mg4                                              0/1     Completed   0               5h18m
gpu-operator                   nvidia-dcgm-exporter-24v75                                               1/1     Running     0               5h20m
gpu-operator                   nvidia-device-plugin-daemonset-7tsdv                                     1/1     Running     0               5h20m
gpu-operator                   nvidia-driver-daemonset-mc5w9                                            1/1     Running     0               5h21m
gpu-operator                   nvidia-operator-validator-tn8x4                                          1/1     Running     0               5h20m
```

### Install Prometheus Operator

```shell
helm repo add prometheus-community \
   https://prometheus-community.github.io/helm-charts
```

```shell
helm install prometheus-community/kube-prometheus-stack \
   --create-namespace --namespace prometheus \
   --generate-name \
   --set prometheus.service.type=LoadBalancer \
   --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false
```

You may have to configure the prometheus service to be NodePort or LoadBalancer to view the dashboard and modify the `additionalScrapeConfigs` configMap as per [NVIDIA's documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-telemetry/latest/kube-prometheus.html).

In this guide, prometheus service was configured to be of type LoadBalancer to obtain an external IP for the server.

Verify that Prometheus and DCGM Exporter services are functional.

```shell
kubectl get svc -A
```

```shell
$ k get svc -A
NAMESPACE           NAME                                                        TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                         AGE
default             kubernetes                                                  ClusterIP      198.48.0.1       <none>           443/TCP                         29h
default             prometheus-adapter                                          ClusterIP      198.50.195.185   <none>           443/TCP                         25h
default             supervisor                                                  ClusterIP      None             <none>           6443/TCP                        29h
gpu-operator        gpu-operator                                                ClusterIP      198.48.140.116   <none>           8080/TCP                        29h
gpu-operator        nvidia-dcgm-exporter                                        ClusterIP      198.62.80.236    <none>           9400/TCP                        29h
kube-system         antrea                                                      ClusterIP      198.58.225.77    <none>           443/TCP                         29h
kube-system         kube-dns                                                    ClusterIP      198.48.0.10      <none>           53/UDP,53/TCP,9153/TCP          29h
kube-system         kube-prometheus-stack-1761-coredns                          ClusterIP      None             <none>           9153/TCP                        25h
kube-system         kube-prometheus-stack-1761-kube-controller-manager          ClusterIP      None             <none>           10257/TCP                       25h
kube-system         kube-prometheus-stack-1761-kube-etcd                        ClusterIP      None             <none>           2381/TCP                        25h
kube-system         kube-prometheus-stack-1761-kube-proxy                       ClusterIP      None             <none>           10249/TCP                       25h
kube-system         kube-prometheus-stack-1761-kube-scheduler                   ClusterIP      None             <none>           10259/TCP                       25h
kube-system         kube-prometheus-stack-1761-kubelet                          ClusterIP      None             <none>           10250/TCP,10255/TCP,4194/TCP    26h
kube-system         kube-prometheus-stack-kubelet                               ClusterIP      None             <none>           10250/TCP,10255/TCP,4194/TCP    26h
kube-system         metrics-server                                              ClusterIP      198.56.115.113   <none>           443/TCP                         29h
prometheus          kube-prometheus-stack-1761-operator                         ClusterIP      198.50.9.255     <none>           443/TCP                         25h
prometheus          kube-prometheus-stack-1761-prometheus                       LoadBalancer   198.49.204.2     10.158.245.139   9090:31277/TCP,8080:32729/TCP   25h
prometheus          kube-prometheus-stack-1761824513-grafana                    ClusterIP      198.48.65.31     <none>           80/TCP                          25h
prometheus          kube-prometheus-stack-1761824513-kube-state-metrics         ClusterIP      198.58.246.4     <none>           8080/TCP                        25h
prometheus          kube-prometheus-stack-1761824513-prometheus-node-exporter   ClusterIP      198.58.165.44    <none>           9100/TCP                        25h
prometheus          prometheus-operated                                         ClusterIP      None             <none>           9090/TCP                        25h
tkg-system          packaging-api                                               ClusterIP      198.50.22.215    <none>           443/TCP,8080/TCP                29h
vmware-system-csi   vsphere-csi-controller                                      ClusterIP      198.58.163.109   <none>           2112/TCP,2113/TCP               29h
```


Verify that DCGM Exporter is hosting metrics from the underlying GPU.

**Note**: You can port-forward `nvidia-dcgm-exporter` service to view the DCGM metrics on localhost.

```shell
kubectl port-forward -n gpu-operator nvidia-dcgm-exporter-24v75 9400:9400 &
```
The metrics endpoint should display an output as follows:

```shell
curl localhost:9400/metrics
Handling connection for 9400
# HELP DCGM_FI_DEV_SM_CLOCK SM clock frequency (in MHz).
# TYPE DCGM_FI_DEV_SM_CLOCK gauge
DCGM_FI_DEV_SM_CLOCK{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 1755
# HELP DCGM_FI_DEV_MEM_CLOCK Memory clock frequency (in MHz).
# TYPE DCGM_FI_DEV_MEM_CLOCK gauge
DCGM_FI_DEV_MEM_CLOCK{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 1593
# HELP DCGM_FI_DEV_MEMORY_TEMP Memory temperature (in C).
# TYPE DCGM_FI_DEV_MEMORY_TEMP gauge
DCGM_FI_DEV_MEMORY_TEMP{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 0
# HELP DCGM_FI_DEV_GPU_UTIL GPU utilization (in %).
# TYPE DCGM_FI_DEV_GPU_UTIL gauge
DCGM_FI_DEV_GPU_UTIL{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 0
# HELP DCGM_FI_DEV_MEM_COPY_UTIL Memory utilization (in %).
# TYPE DCGM_FI_DEV_MEM_COPY_UTIL gauge
DCGM_FI_DEV_MEM_COPY_UTIL{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 0
# HELP DCGM_FI_DEV_ENC_UTIL Encoder utilization (in %).
# TYPE DCGM_FI_DEV_ENC_UTIL gauge
DCGM_FI_DEV_ENC_UTIL{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 0
# HELP DCGM_FI_DEV_DEC_UTIL Decoder utilization (in %).
# TYPE DCGM_FI_DEV_DEC_UTIL gauge
DCGM_FI_DEV_DEC_UTIL{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 0
# HELP DCGM_FI_DEV_XID_ERRORS Value of the last XID error encountered.
# TYPE DCGM_FI_DEV_XID_ERRORS gauge
DCGM_FI_DEV_XID_ERRORS{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",err_code="0",err_msg="No Error",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 0
# HELP DCGM_FI_DEV_FB_FREE Framebuffer memory free (in MiB).
# TYPE DCGM_FI_DEV_FB_FREE gauge
DCGM_FI_DEV_FB_FREE{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 19762
# HELP DCGM_FI_DEV_FB_USED Framebuffer memory used (in MiB).
# TYPE DCGM_FI_DEV_FB_USED gauge
DCGM_FI_DEV_FB_USED{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 0
# HELP DCGM_FI_DEV_FB_RESERVED Framebuffer memory reserved (in MiB).
# TYPE DCGM_FI_DEV_FB_RESERVED gauge
DCGM_FI_DEV_FB_RESERVED{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 717
# HELP DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL Total number of NVLink bandwidth counters for all lanes.
# TYPE DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL counter
DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 0
# HELP DCGM_FI_DEV_VGPU_LICENSE_STATUS vGPU License status
# TYPE DCGM_FI_DEV_VGPU_LICENSE_STATUS gauge
DCGM_FI_DEV_VGPU_LICENSE_STATUS{gpu="0",UUID="GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",pci_bus_id="00000000:03:00.0",device="nvidia0",modelName="NVIDIA H100-20C",Hostname="cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",DCGM_FI_DRIVER_VERSION="580.95.05",container="cuda",namespace="default",pod="cuda-75454ffb9f-jpwkc"} 1
```

### View Accelerator Metrics

View the fine grained accelerator metrics such as memory usage, temperator emitted by DCGM Exporter through the Prometheus endpoint.

```shell
curl -G http://<Prometheus Server IP Address>:9090/api/v1/query --data-urlencode 'query={__name__=~"DCGM.*"}' | jq -r .
```

The output should be similar to the following snippet:

```shell
{
  "status": "success",
  "data": {
    "resultType": "vector",
    "result": [
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_SM_CLOCK",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "1755"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_MEM_CLOCK",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "1593"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_MEMORY_TEMP",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "0"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_GPU_UTIL",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "0"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_MEM_COPY_UTIL",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "0"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_ENC_UTIL",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "0"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_DEC_UTIL",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "0"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_XID_ERRORS",
          "container": "cuda",
          "device": "nvidia0",
          "err_code": "0",
          "err_msg": "No Error",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "0"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_FB_FREE",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "19762"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_FB_USED",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "0"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_FB_RESERVED",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "717"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "0"
        ]
      },
      {
        "metric": {
          "DCGM_FI_DRIVER_VERSION": "580.95.05",
          "Hostname": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "UUID": "GPU-a0acdf3c-24b2-4dcd-853c-b19000000000",
          "__name__": "DCGM_FI_DEV_VGPU_LICENSE_STATUS",
          "container": "cuda",
          "device": "nvidia0",
          "gpu": "0",
          "instance": "192.0.1.10:9400",
          "job": "gpu-metrics",
          "kubernetes_node": "cluster-tkr1341-ubu2204-1xh100-20c-np-lcqbg-49wfm-rhpj8",
          "modelName": "NVIDIA H100-20C",
          "namespace": "default",
          "pci_bus_id": "00000000:03:00.0",
          "pod": "cuda-75454ffb9f-jpwkc"
        },
        "value": [
          1761917312.142,
          "1"
        ]
      }
    ]
  }
}
```
