## Description 

The platform must allow for the installation and successful operation of at least one gang scheduling solution that ensures all-or-nothing scheduling for distributed AI workloads (e.g. Kueue, Volcano, etc.) To be conformant, the vendor must demonstrate that their platform can successfully run at least one such solution.

## Evidence

### Prerequisites

* Provision a VKS v3.5.0 Cluster with v1.34.1 node pool, VM Class with vGPU profile and NVIDIA GPU Operator

* Log in to the cluster as admin

References:

- https://techdocs.broadcom.com/us/en/vmware-cis/private-ai/foundation-with-nvidia/9-0/private-ai-foundation-9-x/deploying-ai-workloads-on-tkg-clusters/deploy-a-gpu-accelerated-tkg-cluster-with-kubectl-connected.html

- https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/managing-vsphere-kuberenetes-service-clusters-and-workloads/deploying-ai-ml-workloads-on-tkg-service-clusters/cluster-operator-workflow-for-deploying-ai-ml-workloads-on-tkg-service-clusters.html

### Install Kueue

```shell
## Create namespace for kueue install
kubectl create ns  kueue-system

## Install via helm
helm install kueue oci://registry.k8s.io/kueue/charts/kueue --version=0.14.1 --namespace kueue-system --wait --timeout 300s
```


Wait until Kueue pods are ready

```shell
kubectl get deployments -n kueue-system
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
kueue-controller-manager   1/1     1            1           84s

get pods -n kueue-system
NAME                                        READY   STATUS    RESTARTS   AGE
kueue-controller-manager-59957d6f7d-rttqf   1/1     Running   0          2m1s
```


Create two new namespaces

```shell
kubectl create namespace team-a

kubectl create namespace team-b
```



### Create the ResourceFlavor

```shell
kubectl apply -f flavor.yaml
```

Verify ResourceFlavor

```shell
kubectl get resourceflavor
NAME             AGE
default-flavor   48s

kubectl describe resourceflavor
Name:         default-flavor
Namespace:
Labels:       <none>
Annotations:  <none>
API Version:  kueue.x-k8s.io/v1beta1
Kind:         ResourceFlavor
Metadata:
  Creation Timestamp:  2025-10-22T18:30:15Z
  Finalizers:
    kueue.x-k8s.io/resource-in-use
  Generation:        1
  Resource Version:  1869076
  UID:               f30863da-e343-43e1-ae0a-3f55883d4eaa
Spec:
Events:  <none>
```

### Create the ClusterQueue

```shell
kubectl apply -f cluster-queue.yaml
```

Inspect ClusterQueue resource

```shell
kubectl get ClusterQueue
NAME            COHORT   PENDING WORKLOADS
cluster-queue            0

kubectl describe ClusterQueue
Name:         cluster-queue
Namespace:
Labels:       <none>
Annotations:  <none>
API Version:  kueue.x-k8s.io/v1beta1
Kind:         ClusterQueue
Metadata:
  Creation Timestamp:  2025-10-22T18:33:36Z
  Finalizers:
    kueue.x-k8s.io/resource-in-use
  Generation:        1
  Resource Version:  1869871
  UID:               b7e60a0a-b40f-4d1a-8f43-d31b5893cf60
Spec:
  Flavor Fungibility:
    When Can Borrow:   Borrow
    When Can Preempt:  TryNextFlavor
  Namespace Selector:
  Preemption:
    Borrow Within Cohort:
      Policy:               Never
    Reclaim Within Cohort:  Never
    Within Cluster Queue:   Never
  Queueing Strategy:        BestEffortFIFO
  Resource Groups:
    Covered Resources:
      cpu
      memory
      nvidia.com/gpu
      ephemeral-storage
    Flavors:
      Name:  default-flavor
      Resources:
        Name:           cpu
        Nominal Quota:  10
        Name:           memory
        Nominal Quota:  2Gi
        Name:           nvidia.com/gpu
        Nominal Quota:  10
        Name:           ephemeral-storage
        Nominal Quota:  10Gi
  Stop Policy:          None
Status:
  Admitted Workloads:  0
  Conditions:
    Last Transition Time:  2025-10-22T18:33:36Z
    Message:               Can admit new workloads
    Observed Generation:   1
    Reason:                Ready
    Status:                True
    Type:                  Active
  Flavors Reservation:
    Name:  default-flavor
    Resources:
      Borrowed:  0
      Name:      cpu
      Total:     0
      Borrowed:  0
      Name:      ephemeral-storage
      Total:     0
      Borrowed:  0
      Name:      memory
      Total:     0
      Borrowed:  0
      Name:      nvidia.com/gpu
      Total:     0
  Flavors Usage:
    Name:  default-flavor
    Resources:
      Borrowed:         0
      Name:             cpu
      Total:            0
      Borrowed:         0
      Name:             ephemeral-storage
      Total:            0
      Borrowed:         0
      Name:             memory
      Total:            0
      Borrowed:         0
      Name:             nvidia.com/gpu
      Total:            0
  Pending Workloads:    0
  Reserving Workloads:  0
Events:                 <none>
```

### Create LocalQueue

```shell
kubectl apply -f local-queue.yaml
```

Inspect LocalQueue resource

```shell
kubectl get LocalQueue -A
NAMESPACE   NAME        CLUSTERQUEUE    PENDING WORKLOADS   ADMITTED WORKLOADS
team-a      lq-team-a   cluster-queue   0                   0
team-b      lq-team-b   cluster-queue   0                   0

kubectl describe LocalQueue lq-team-a -n team-a
Name:         lq-team-a
Namespace:    team-a
Labels:       <none>
Annotations:  <none>
API Version:  kueue.x-k8s.io/v1beta1
Kind:         LocalQueue
Metadata:
  Creation Timestamp:  2025-10-22T18:36:26Z
  Generation:          1
  Resource Version:    1870559
  UID:                 fa8df963-fdc7-49ef-98a4-7cabdba227e1
Spec:
  Cluster Queue:  cluster-queue
  Stop Policy:    None
Status:
  Admitted Workloads:  0
  Conditions:
    Last Transition Time:  2025-10-22T18:36:26Z
    Message:               Can submit new workloads to localQueue
    Observed Generation:   1
    Reason:                Ready
    Status:                True
    Type:                  Active
  Flavor Usage:
    Name:  default-flavor
    Resources:
      Name:   cpu
      Total:  0
      Name:   ephemeral-storage
      Total:  0
      Name:   memory
      Total:  0
      Name:   nvidia.com/gpu
      Total:  0
  Flavors:
    Name:  default-flavor
    Resources:
      cpu
      ephemeral-storage
      memory
      nvidia.com/gpu
  Flavors Reservation:
    Name:  default-flavor
    Resources:
      Name:             cpu
      Total:            0
      Name:             ephemeral-storage
      Total:            0
      Name:             memory
      Total:            0
      Name:             nvidia.com/gpu
      Total:            0
  Pending Workloads:    0
  Reserving Workloads:  0
Events:                 <none>


kubectl describe LocalQueue lq-team-b -n team-b
Name:         lq-team-b
Namespace:    team-b
Labels:       <none>
Annotations:  <none>
API Version:  kueue.x-k8s.io/v1beta1
Kind:         LocalQueue
Metadata:
  Creation Timestamp:  2025-10-22T18:36:26Z
  Generation:          1
  Resource Version:    1870561
  UID:                 b1b0bc13-d078-48cb-903f-f1beef23b32f
Spec:
  Cluster Queue:  cluster-queue
  Stop Policy:    None
Status:
  Admitted Workloads:  0
  Conditions:
    Last Transition Time:  2025-10-22T18:36:26Z
    Message:               Can submit new workloads to localQueue
    Observed Generation:   1
    Reason:                Ready
    Status:                True
    Type:                  Active
  Flavor Usage:
    Name:  default-flavor
    Resources:
      Name:   cpu
      Total:  0
      Name:   ephemeral-storage
      Total:  0
      Name:   memory
      Total:  0
      Name:   nvidia.com/gpu
      Total:  0
  Flavors:
    Name:  default-flavor
    Resources:
      cpu
      ephemeral-storage
      memory
      nvidia.com/gpu
  Flavors Reservation:
    Name:  default-flavor
    Resources:
      Name:             cpu
      Total:            0
      Name:             ephemeral-storage
      Total:            0
      Name:             memory
      Total:            0
      Name:             nvidia.com/gpu
      Total:            0
  Pending Workloads:    0
  Reserving Workloads:  0
Events:                 <none>
```

### Create jobs

```shell
kubectl apply -f job-team-a.yaml

kubectl apply -f job-team-b.yaml
```

Simulate jobs every 10 seconds

```shell
./create_jobs.sh job-team-a.yaml job-team-b.yaml 10
```

Monitor the jobs being scheduled and executed

```shell
job.batch/sample-job-team-a-jgcls created
job.batch/sample-job-team-b-9ld2j created
job.batch/sample-job-team-a-cd7hz created
job.batch/sample-job-team-b-tgn2z created
job.batch/sample-job-team-a-mkdts created
job.batch/sample-job-team-b-k6b47 created
job.batch/sample-job-team-a-ht4l5 created
job.batch/sample-job-team-b-5h89p created
job.batch/sample-job-team-a-nqr4w created
job.batch/sample-job-team-b-6xv9k created
job.batch/sample-job-team-a-9nw2g created
job.batch/sample-job-team-b-lnhq7 created
job.batch/sample-job-team-a-t69m5 created
job.batch/sample-job-team-b-dnvzw created
job.batch/sample-job-team-a-s4g4b created
job.batch/sample-job-team-b-mggws created
job.batch/sample-job-team-a-dv8m4 created
job.batch/sample-job-team-b-vgwpw created


kubectl -n team-a get jobs
NAME                      STATUS      COMPLETIONS   DURATION   AGE
sample-job-team-a-9nw2g   Suspended   0/3                      98s
sample-job-team-a-cd7hz   Suspended   0/3                      2m19s
sample-job-team-a-dv8m4   Suspended   0/3                      68s
sample-job-team-a-ht4l5   Suspended   0/3                      119s
sample-job-team-a-jgcls   Suspended   0/3                      2m29s
sample-job-team-a-mkdts   Suspended   0/3                      2m9s
sample-job-team-a-nqr4w   Suspended   0/3                      109s
sample-job-team-a-s4g4b   Suspended   0/3                      78s
sample-job-team-a-t69m5   Suspended   0/3                      88s


kubectl -n team-b get jobs
NAME                      STATUS      COMPLETIONS   DURATION   AGE
sample-job-team-b-7p8xh   Suspended   0/3                      45s
sample-job-team-b-bmzf8   Suspended   0/3                      65s
sample-job-team-b-hgjj5   Suspended   0/3                      35s
sample-job-team-b-ndpll   Running     0/3           12s        75s
sample-job-team-b-p5hqw   Complete    3/3           14s        86s
sample-job-team-b-sdphg   Complete    3/3           13s        96s
sample-job-team-b-xq4rm   Suspended   0/3                      55s
```