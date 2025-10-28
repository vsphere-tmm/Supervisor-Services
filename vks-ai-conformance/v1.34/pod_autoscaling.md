## Description

If the platform supports the HorizontalPodAutoscaler, it must function correctly for pods utilizing accelerators. This includes the ability to scale these Pods based on custom metrics relevant to AI/ML workloads.

## Evidence

### Prerequisites

* Provision a VKS v3.5.0 Cluster with v1.34.1 node pool, VM Class with vGPU profile and NVIDIA GPU Operator

* Log in to the cluster as admin

References:

- https://techdocs.broadcom.com/us/en/vmware-cis/private-ai/foundation-with-nvidia/9-0/private-ai-foundation-9-x/deploying-ai-workloads-on-tkg-clusters/deploy-a-gpu-accelerated-tkg-cluster-with-kubectl-connected.html

- https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/managing-vsphere-kuberenetes-service-clusters-and-workloads/deploying-ai-ml-workloads-on-tkg-service-clusters/cluster-operator-workflow-for-deploying-ai-ml-workloads-on-tkg-service-clusters.html

### Install Prometheus Operator

```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
helm repo update
```
```shell
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
 --values kube-prometheus-stack-values.yaml
```

Create Prometheus Rule

```shell
kubectl apply -f prometheus-rule.yaml
```

Install Prometheus Adapter

```shell
helm install prometheus-adapter prometheus-community/prometheus-adapter \
  --set prometheus.url="http://kube-prometheus-stack-prometheus.default.svc.cluster.local"
```

### Test Kubernetes Custom Metrics Endpoint

Check for the metrics exposed by DCGM Exporter such as `DCGM_FI_DEV_GPU_UTIL`

```
kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1 | jq -r . | grep cuda_gpu
```

Create a deployment

```shell
kubectl apply -f cuda-deployment.yaml
```

### Create HPA to Scale deployment based on GPU Utilization

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

This scales the deployment to max replicas provided.
