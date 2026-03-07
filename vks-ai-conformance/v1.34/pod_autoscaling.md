## Description

If the platform supports the HorizontalPodAutoscaler, it must function correctly for pods utilizing accelerators. This includes the ability to scale these Pods based on custom metrics relevant to AI/ML workloads.

## Evidence

Complete guide to configure Horizontal Pod Autoscaling using NVIDIA DCGM metrics with Prometheus Operator on VKS v3.5.0 and Kubernetes v1.34.1.

### Prerequisites

* Provision a VKS v3.5.0 Cluster with v1.34.1 node pool, VM Class with vGPU profile and NVIDIA GPU Operator

* Log in to the cluster as admin

* Install Helm

References:

- https://techdocs.broadcom.com/us/en/vmware-cis/private-ai/foundation-with-nvidia/9-0/private-ai-foundation-9-x/deploying-ai-workloads-on-tkg-clusters/deploy-a-gpu-accelerated-tkg-cluster-with-kubectl-connected.html

### Install Prometheus Operator

```shell
hhelm repo add prometheus-community \
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

In this guide, prometheus service was configured to by of type LoadBalancer to obtain an external IP for the server.

### Install Prometheus Adapter

```shell
helm install prometheus-adapter prometheus-community/prometheus-adapter \
  --set prometheus.url="http://<kube-prometheus-stack-prometheus.default.svc.cluster.local or IP Address of Prometheus service>" --set prometheus.port="9090"
```

Verify that Prometheus, Prometheus Adapter and DCGM Exporter services. are functional.

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


### Test Kubernetes Custom Metrics Endpoint

Check for the metrics exposed by DCGM Exporter such as `DCGM_FI_DEV_GPU_UTIL`.

```shell
kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1 | jq -r . | grep DCGM
```

The output should be similar to the snippet below:

```shell
"namespaces/DCGM_FI_DEV_VGPU_LICENSE_STATUS"
"namespaces/DCGM_FI_DEV_SM_CLOCK"
"pods/DCGM_FI_DEV_MEM_CLOCK"
"pods/DCGM_FI_DEV_FB_USED"
"jobs.batch/DCGM_FI_DEV_SM_CLOCK"
"jobs.batch/DCGM_FI_DEV_MEMORY_TEMP"
"pods/DCGM_FI_DEV_DEC_UTIL"
"namespaces/DCGM_FI_DEV_DEC_UTIL"
"pods/DCGM_FI_DEV_XID_ERRORS"
"jobs.batch/DCGM_FI_DEV_FB_RESERVED"
"jobs.batch/DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL"
"pods/DCGM_FI_DEV_FB_RESERVED"
"jobs.batch/DCGM_FI_DEV_FB_FREE"
"pods/DCGM_FI_DEV_MEM_COPY_UTIL"
"namespaces/DCGM_FI_DEV_FB_RESERVED"
"jobs.batch/DCGM_FI_DEV_VGPU_LICENSE_STATUS"
"namespaces/DCGM_FI_DEV_FB_FREE"
"namespaces/DCGM_FI_DEV_MEM_CLOCK"
"pods/DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL"
"namespaces/DCGM_FI_DEV_XID_ERRORS"
"jobs.batch/DCGM_FI_DEV_GPU_UTIL"
"pods/DCGM_FI_DEV_MEMORY_TEMP"
"namespaces/DCGM_FI_DEV_MEMORY_TEMP"
"pods/DCGM_FI_DEV_GPU_UTIL"
"jobs.batch/DCGM_FI_DEV_FB_USED"
"namespaces/DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL"
"namespaces/DCGM_FI_DEV_ENC_UTIL"
"pods/DCGM_FI_DEV_VGPU_LICENSE_STATUS"
"jobs.batch/DCGM_FI_DEV_MEM_CLOCK"
"jobs.batch/DCGM_FI_DEV_ENC_UTIL"
"jobs.batch/DCGM_FI_DEV_DEC_UTIL"
"namespaces/DCGM_FI_DEV_MEM_COPY_UTIL"
"namespaces/DCGM_FI_DEV_GPU_UTIL"
"pods/DCGM_FI_DEV_ENC_UTIL"
"namespaces/DCGM_FI_DEV_FB_USED"
"jobs.batch/DCGM_FI_DEV_XID_ERRORS"
"pods/DCGM_FI_DEV_FB_FREE"
"jobs.batch/DCGM_FI_DEV_MEM_COPY_UTIL"
"pods/DCGM_FI_DEV_SM_CLOCK"
```

### Create HPA to Scale deployment based on GPU Utilization

Create a deployment that utilises GPU.

```shell
kubectl apply -f cuda-deployment.yaml
```

Verify that DCGM Exporter related metrics are available in Prometheus dashboard for the above deployment.

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

Create HPA resource that utilises a custom metric such as `DCGM_FI_DEV_DB_FREE` to scale the deployment based on free GPU memory.

```shell
spec:
  scaleTargetRef:
    kind: Deployment
    name: cuda
    apiVersion: apps/v1
  minReplicas: 1
  maxReplicas: 3
  metrics:
    - type: Pods
      pods:
        metric:
          name: DCGM_FI_DEV_FB_FREE
        target:
          type: AverageValue
          averageValue: "10000" 
```


```shell
kubectl apply -f hpa.yaml
```

Simulate load on GPU

```shell
kubectl exec -it deployment/cuda -- bash

for (( c=1; c<=5000; c++ )); do ./vectorAdd; done & \
for (( c=1; c<=5000; c++ )); do ./vectorAdd; done & \
for (( c=1; c<=5000; c++ )); do ./vectorAdd; done & \
for (( c=1; c<=5000; c++ )); do ./vectorAdd; done & \
for (( c=1; c<=5000; c++ )); do ./vectorAdd; done & \
for (( c=1; c<=5000; c++ )); do ./vectorAdd; done & \
for (( c=1; c<=5000; c++ )); do ./vectorAdd; done & \
for (( c=1; c<=5000; c++ )); do ./vectorAdd; done &
```

On inspecting hpa resource, you should be able to see the replicas being created for the deployment.

```shell
kubectl get hpa

kubectl describe hpa cuda
```

The above commands should display output as follows for successful Horizontal Pod Autoscaling.

```shell
NAME   REFERENCE         TARGETS     MINPODS   MAXPODS   REPLICAS   AGE
cuda   Deployment/cuda   19762/10k   1         3         2          26h
```

```shell
Name:                             cuda
Namespace:                        default
Labels:                           <none>
Annotations:                      <none>
CreationTimestamp:                Thu, 30 Oct 2025 10:45:25 +0000
Reference:                        Deployment/cuda
Metrics:                          ( current / target )
  "DCGM_FI_DEV_FB_FREE" on pods:  19762 / 10k
Min replicas:                     1
Max replicas:                     3
Deployment pods:                  2 current / 2 desired
Conditions:
  Type            Status  Reason              Message
  ----            ------  ------              -------
  AbleToScale     True    ReadyForNewScale    recommended size matches current size
  ScalingActive   True    ValidMetricFound    the HPA was able to successfully calculate a replica count from pods metric DCGM_FI_DEV_FB_FREE
  ScalingLimited  False   DesiredWithinRange  the desired count is within the acceptable range
Events:           <none>
```
