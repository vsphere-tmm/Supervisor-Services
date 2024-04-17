- [Supervisor Services Catalog](#supervisor-services-catalog)
  - [vSAN Data Persistence Platform (vDPP) Services:](#vsan-data-persistence-platform-vdpp-services)
  - [Backup \& Recovery Service](#backup--recovery-service)
    - [Velero vSphere Operator CLI Versions](#velero-vsphere-operator-cli-versions)
    - [Velero Versions](#velero-versions)
  - [Certificate Management Service](#certificate-management-service)
    - [CA Cluster Issuer Versions](#ca-cluster-issuer-versions)
  - [Cloud Native Registry Service](#cloud-native-registry-service)
    - [Harbor Versions](#harbor-versions)
  - [Kubernetes Ingress Controller Service](#kubernetes-ingress-controller-service)
    - [Contour Versions](#contour-versions)
  - [External DNS Service](#external-dns-service)
    - [ExternalDNS Versions](#externaldns-versions)
  - [NSX Management Proxy](#nsx-management-proxy)
    - [NSX Management Proxy Versions](#nsx-management-proxy-versions)
---
- [Supervisor Services Labs Catalog](#supervisor-services-labs-catalog)
  - [ArgoCD Operator](#argocd-operator)
    - [ArgoCD Operator Versions](#argocd-operator-versions)
  - [External Secrets Operator](#external-secrets-operator)
    - [External Secrets Operator Versions](#external-secrets-operator-versions)
  - [RabbitMQ Cluster Kubernetes Operator](#rabbitmq-cluster-kubernetes-operator)
    - [RabbitMQ Cluster Kubernetes Operator Versions](#rabbitmq-cluster-kubernetes-operator-versions)


# Supervisor Services Catalog

Discover current Supervisor Services offered to support modern applications through vSphere Services.
New service will be added overtime with the goal to continue to empower your DevOps communities.

Prior vSphere 8 Update 1, the Supervisor Services are only available with Supervisor Clusters enabled using VMware NSX-T. With vSphere 8 U1, Supervisor Services are also supported when using the vSphere Distributed Switch networking stack.

| Supervisor Service | vSphere 7 | vSphere 8 |
| :--: | :--: | :--: |
| vSAN Data Persistence Platform Services - MinIO, Cloudian and Dell ObjectScale| ✅ | ✅ |
| Backup \& Recovery Service - Velero | ✅ | ✅ |
| Certificate Management Service - cert-manager | ❌ | ✅ |
| Cloud Native Registry Service - Harbor | ❌ * | ✅ |
| Kubernetes Ingress Controller Service - Contour | ❌ | ✅ |
| External DNS Service - ExternalDNS | ❌ | ✅ |
*\* The embedded Harbor Registry feature is still available and supported on vSphere 7 and onwards.*

## vSAN Data Persistence Platform (vDPP) Services:

vSphere with Tanzu offers the vSAN Data Persistence platform. The platform provides a framework that enables third parties to integrate their cloud native service applications with underlying vSphere infrastructure, so that third-party software can run on vSphere with Tanzu optimally.

- Using vSAN Data Persistence Platform (vDPP) with vSphere with Tanzu [documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-F7223607-30A5-4B2D-9B06-A55A65FEAA11.html)
- Avaliable vDPP Services [documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-F68B264E-76A3-4A6D-A3B0-17153DDF7A18.html)

Partner Documentation Links:

- MinIO partner [documentation](https://docs.min.io/minio/vsphere/core-concepts/core-concepts.html)
- Cloudian partner [documentation](https://cloudian.com/vmware/)
- Dell ObjectScale partner [documentation](https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/docs/vmware-dell-objectscale.pdf)

## Backup & Recovery Service

<img src="Velero.svg" width="250" title="Velero Logo">

Velero vSphere Operator helps users install Velero and its vSphere plugin on a vSphere with Kubernetes Supervisor cluster. Velero is an open source tool to safely backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.

- Service install [documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-DA21BF67-160E-48D9-8D94-0D3690E51FD0.html)

### Velero vSphere Operator CLI Versions

*This is a prerequisite for a cluster admin install.*

- Download latest version: [Velero vSphere Operator CLI - v1.6.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.5.3/velero-vsphere-1.6.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.5.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.5.1/velero-vsphere-1.5.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.4.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.5.1/velero-vsphere-1.4.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.3.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.4.2/velero-vsphere-1.3.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.2.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.4.0/velero-vsphere-1.2.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.1.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.1.0/velero-vsphere-1.1.0-linux-amd64.tar.gz)

### Velero Versions

- Download latest version: [Velero vSphere Operator v1.6.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.6.0%252Fvelero-vsphere-1.6.0-def.yaml)
- Download: [Velero vSphere Operator v1.5.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.5.0%252Fvelero-vsphere-1.5.0-def.yaml)
- Download: [Velero vSphere Operator v1.4.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.4.0%252Fvelero-vsphere-1.4.0-def.yaml)
- Download: [Velero vSphere Operator v1.3.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.3.0%252Fvelero-supervisorservice-1.3.0.yaml)
- Download: [Velero vSphere Operator v1.2.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.2.0%252Fvelero-supervisorservic-1.2.0.yaml)
- Download: [Velero vSphere Operator v1.1.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.0.0%252Fvelero-supervisorservice-1.0.0.yaml)

## Certificate Management Service

<img src="cert-manager-logo.PNG" width="250" title="cert-manager Logo">

ClusterIssuers are Kubernetes resources that represent certificate authorities (CAs) that are able to generate signed certificates by honoring certificate signing requests. All cert-manager certificates require a referenced issuer that is in a ready condition to attempt to honor the request.

- Service install - Follow steps 1 - 5 in the [documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-4843E6C6-747E-43B1-AC55-8F02299CC10E.html) then continue to the bullet point below.
- Read [Service Configuration](caclusterissuer/README.md) to understand how to install your root CA into the ca-clusterissuer.

### CA Cluster Issuer Versions

- Download latest version: [ca-clusterissuer v0.0.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=ca-clusterissuer/v0.0.2/ca-clusterissuer.yml)
- Download version: [ca-clusterissuer v0.0.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=ca-clusterissuer/v0.0.1/ca-clusterissuer.yml)

CA Cluster Issuer Sample `values.yaml`

- We do not provide any default values for this package. Instead, we encourage that you generate certificates. Please read [How-To Deploy a self-signed CA Issuer and Request a Certificate](https://github.com/vsphere-tmm/vsphere-with-tanzu-dev-center/tree/main/cert-manager#how-to-deploy-a-self-signed-ca-issuer-and-request-a-certificate) for information on how to create a self-signed certificate.

## Cloud Native Registry Service

<img src="harbor-logo.png" width="250" title="Harbor Logo">

Harbor is an open source trusted cloud native registry project that stores, signs, and scans content. Harbor extends the open source Docker Distribution by adding the functionalities usually required by users such as security, identity and management. Having a registry closer to the build and run environment can improve the image transfer efficiency. Harbor supports replication of images between registries, and also offers advanced security features such as user management, access control and activity auditing.

- The [contour package](#contour) is a prerequisite for Harbor, so that must be installed
  first.
- Follow the instructions under [Installing and Configuring Harbor on a Supervisor](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-8C645717-C473-4E67-8DEE-049B71447B86.html).

### Harbor Versions

- Download latest version: [Harbor v2.8.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.8.2/harbor.yml)
- Download version: [Harbor v2.5.3](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.5.3/harbor.yml)

Harbor Sample `values.yaml`

- Download latest version: [values for v2.8.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.8.2/harbor-data-values.yml). For details about each of the required properties, [see the configuration details page](harbor/README.md).
- Download version: [values for v2.5.3](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.5.3/harbor-data-values.yml). For details about each of the required properties, [see the configuration details page](https://github.com/vsphere-tmm/Supervisor-Services/blob/33a424992a03eff5c13fea45807f2b578e3b65d4/harbor/README.md).


## Kubernetes Ingress Controller Service

<img src="contour-logo.png" width="250" title="Contour Logo" id="contour">

Contour is an Ingress controller for Kubernetes that works by deploying the Envoy proxy as a reverse proxy and load balancer. Contour supports dynamic configuration updates out of the box while maintaining a lightweight profile.

- Service install - Follow steps 1 - 5 in the [documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-4843E6C6-747E-43B1-AC55-8F02299CC10E.html).

### Contour Versions

- Download latest version: [Contour v1.24.4](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.24.4/contour.yml)
- Download version: [Contour v1.18.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.18.2/contour.yml)

Contour Sample `values.yaml`

- Download [values for all versions](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.24.4/contour-data-values.yml). These values can be used _as-is_ and require no configuration changes.

## External DNS Service

<img src="external-dns-logo.png" width="250" title="External DNS Logo" id="external-dns">

ExternalDNS publishes DNS records for applications to DNS servers, using a declarative, Kubernetes-native interface. This operator connects to your DNS server (not included here). For a list of supported DNS providers and their corresponding configuration settings, see the [upstream external-dns project](https://github.com/kubernetes-sigs/external-dns).

- On Supervisors where Harbor is deployed with Contour, ExternalDNS may be used to publish a DNS hostname for the Harbor service.

### ExternalDNS Versions

- Download latest version: [ExternalDNS v0.13.4](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=external-dns/v0.13.4/external-dns.yml)
- Download version: [ExternalDNS v0.11.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=external-dns/v0.11.0/external-dns.yml)

ExternalDNS data `values.yaml`

- Because of the large list of supported DNS providers, we do not supply complete sample configuration values here. If you're deploying ExternalDNS with Harbor and Contour, make sure to include `source=contour-httpproxy` in the configuration values. An *incomplete* example of the service configuration is included below. Make sure to setup API access to your DNS server and include authentication details with the service configuration.

```yaml
deployment:
  args:
  - --source=contour-httpproxy
  - --source=service
  - --log-level=debug
```

## NSX Management Proxy

NSX Management Proxy is for Antrea-NSX adapter in TKG workload cluster to reach NSX manager. We recommend to use NSX Management Proxy when there is isolation between management network and workload network and the workloads running in TKG workload clusters cannot reach NSX manager.

### NSX Management Proxy Versions

- Download latest version: [nsx-management-proxy v0.1.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=nsx-management-proxy/v0.1.1/nsx-management-proxy.yml)

NSX Management Proxy Sample `values.yaml`

- Download latest version: [values for v0.1.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=nsx-management-proxy/v0.1.1/nsx-management-proxy-data-values.yml). Make sure to fill the property `nsxManagers` with your NSX Manager IP(s).

---
---
# Supervisor Services Labs Catalog

## *Experimental* 

The following Supervisor Services Labs catalog is only provided for testing and educational purposes. Please do not use these services in a production environment. These services are intended to demonstrate Supervisor Services' capabilities and usability. VMware will strive to provide regular updates to these services. The Labs services have been tested starting from vSphere 8.0. Over time, depending on usage and customer needs, some of these services may be included in the core product. 

**WARNING** - By downloading and using these solutions from the Supervisor Services Labs catalog, you explicitly agree to the conditional use **[license agreement](supervisor-services-labs/licence-agreement.md)**.

## ArgoCD Operator 

<img src="supervisor-services-labs/argocd-operator/argocd.png" width="200" title="ArgoCD Logo" id="argocd">

The Argo CD Operator manages the entire lifecycle of Argo CD and its components. The operator aims to automate the tasks required to operate an Argo CD deployment. Beyond installation, the operator helps automate the process of upgrading, backing up, and restoring as needed and removes the human toil as much as possible. For a detailed description of how to consume the ArgoCD Operator, see the [ArgoCD Operator project.](https://argocd-operator.readthedocs.io/en/latest/)

### ArgoCD Operator Versions

- Download the latest version: [ArgoCD Operator v0.8.0](supervisor-services-labs/argocd-operator/argocd-operator.yaml)

ArgoCD Operator Sample `values.yaml` - None

- We do not provide any default `values.yaml` for this package. This operator requires minimal configurations, and the necessary pods get deployed in the `svc-argocd-operator-domain-xxx` namespace. 

#### Usage:
- Once the ArgoCD Operator has been deployed successfully on the Supervisor, deploy an ArgoCD object within your vSphere Namespace. To do so, follow the steps below.
1. Download the [example](supervisor-services-labs/argocd-operator/argocd-instance.yaml) as a reference for a simple deployment.
2. Log in to the Supervisor - `10.220.3.18` is the Supervisor IP address in this example - with a user that has owner/edit access to the vSphere Namespace - `user@vsphere.local` in this example. 
```bash
$ kubectl vsphere login --server 10.220.3.18 -u user@vsphere.local
```
3. To deploy ArgoCD to the vSphere Namespace - `demo1` in this example - set the context appropriately. 
```bash
$ kubectl config use-context demo1
```
4. Use kubectl to deploy the file -`argocd-instance.yaml` in this example - that was downloaded in Step 1. 
```bash
$ kubectl apply -f argocd-instance.yaml
```
5. Upon successful deployment, the following should be the status. Use the EXTERNAL-IP address of the argocd-server service to connect to the UI - `10.220.3.20` in this example.  
```bash
$ kubectl get pods
NAME                                        READY   STATUS    RESTARTS   AGE
demo1-argocd-application-controller-0       1/1     Running   0          5m9s
demo1-argocd-redis-cd8c958fd-jltgd          1/1     Running   0          5m9s
demo1-argocd-repo-server-6ccccfc999-rm4ng   1/1     Running   0          5m9s
demo1-argocd-server-945597778-2qfjk         1/1     Running   0          5m9s

$ kubectl get svc
NAME                                          TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)                      AGE
...
demo1-argocd-server                           LoadBalancer   10.96.0.88    10.220.3.20   80:30803/TCP,443:30679/TCP   6m41s
...
```
6. If you encounter a DockerHub rate-limiting for the Redis image, use a proxy-cache or host the image on another registry. The sample `argocd-instance.yaml` shows how to reference an alternate image location.  

- For advanced configurations, check the [detailed reference](https://argocd-operator.readthedocs.io/en/latest/reference/argocd/) and [sample usage](https://argocd-operator.readthedocs.io/en/latest/usage/basics/)

## External Secrets Operator

<img src="supervisor-services-labs/external-secrets-operator/externalsecrets.png" width="200" title="External Secrets Logo" id="externalsecrets">

External Secrets Operator is a Kubernetes operator that integrates external secret management systems like AWS Secrets Manager, HashiCorp Vault, Google Secrets Manager, Azure Key Vault, IBM Cloud Secrets Manager, CyberArk Conjur, etc. The operator reads information from external APIs and automatically injects the values into a Kubernetes Secret. For a detailed description of how to consume External Secrets Operator, visit [External Secrets Operator project](https://external-secrets.io/latest/)

### External Secrets Operator Versions

- Download latest version: [External Secrets Operator v0.9.14](supervisor-services-labs/external-secrets-operator/external-secrets-operator.yaml)

External Secrets Operator Sample `values.yaml` - None

- We do not provide any default `values.yaml` for this package. This operator requires minimal configurations, and the necessary pods get deployed in the `svc-external-secrets-operator-domain-xxx` namespace.

#### Usage: 
- Since the External Secrets Operator integrates with multiple providers, usage varies based on the types of secret stores accessed and secrets consumed. Once the External Secrets Operator has been deployed successfully on the Supervisor, basic operations include creating a `SecretStore` object and an `ExternalSecret` object within your vSphere Namespace.
1. Download the [example](supervisor-services-labs/external-secrets-operator/external-secrets-example.yaml) as a reference for a simple usage. For this example to work, store an SSH private key as a secret called `tkg-ssh-priv-keys` in **GCP Secret Manager**. A service account with the `Secret Manager Secret Accessor` role should be granted access to the secret. The service account's key has to been downloaded and kept in a secure location. (*Note* - Service account keys could pose a security risk if compromised, and this exercise is for demo purposes only) 
2. Log in to the Supervisor - `10.220.3.18` is the Supervisor IP address in this example - with a user with owner/edit access to the vSphere Namespace - `user@vsphere.local` in this example. 
```bash
$ kubectl vsphere login --server 10.220.3.18 -u user@vsphere.local
```
3. To create External Secrets objects within the vSphere Namespace - `demo1` in this example - set the context appropriately. 
```bash
$ kubectl config use-context demo1
```
4. Create a secret to store the GCP service account's key downloaded in step 1 - `key.json` in this example.
```bash
$ kubectl create secret generic gcpsm-secret --from-file=secret-access-credentials=key.json -n demo1
```
5. Modify Line 14 `projectID: my-gcp-projectid` of the file -`external-secrets-example.yaml` in this example - that was downloaded in Step 1, per your GCP ProjectID and use kubectl to deploy the file. 
```bash
$ kubectl apply -f external-secrets-example.yaml
```
6. Upon successful deployment, a new secret object `workload-vsphere-tkg2-ssh` should have been created and its data should match the one uploaded in the GCP Secret Manager. 
```bash
$ kubectl get secret -n demo1 workload-vsphere-tkg2-ssh -o json |jq -r '.data."ssh-privatekey"'|base64 -d
``` 

## RabbitMQ Cluster Kubernetes Operator

<img src="supervisor-services-labs/rabbitmq-operator/rabbitmq-logo.svg" width="150" title="RabbitMQ Logo" id="rabbitmq">

The RabbitMQ Cluster Kubernetes Operator provides a consistent and easy way to deploy RabbitMQ clusters to Kubernetes and run them, including "day two" (continuous) operations. RabbitMQ clusters deployed using the Operator can be used by applications running on Kubernetes or outside of Kubernetes. For a detailed description of how to consume the RabbitMQ Cluster Kubernetes Operator, see the [RabbitMQ Cluster Kubernetes Operator project.](https://www.rabbitmq.com/kubernetes/operator/operator-overview)

### RabbitMQ Cluster Kubernetes Operator Versions

- Download latest version: [RabbitMQ Cluster Kubernetes Operator v2.8.0](supervisor-services-labs/rabbitmq-operator/rabbitmq-operator.yaml)

RabbitMQ Cluster Kubernetes Operator Sample `values.yaml` - 

- Modify the latest [values.yaml](supervisor-services-labs/rabbitmq-operator/values.yaml) by providing a new location for the RabbitMQ Cluster Kubernetes Operator image. The may be required to overcome DockerHub's rate limiting issues. The RabbitMQ Cluster Kubernetes Operator pods and related artifacts get deployed in the `svc-rabbitmq-operator-domain-xx` namespace.

#### Usage:

- Once the RabbitMQ Cluster Kubernetes Operator has been deployed successfully on the Supervisor, deploy an RabbitMQ Cluster object within your vSphere Namespace. To do so, follow the steps below.
1. Download the [example](supervisor-services-labs/rabbitmq-operator/rabbitmq-instance.yaml) as a reference for a simple deployment. You will need to modify the value of the `storageClassName` object. 
2. Log in to the Supervisor - `10.220.3.18` is the Supervisor IP address in this example - with a user that has owner/edit access to the vSphere Namespace - `user@vsphere.local` in this example. 
```bash
$ kubectl vsphere login --server 10.220.3.18 -u user@vsphere.local
```
3. To deploy RabbitMQ Cluster to the vSphere Namespace - `demo1` in this example - set the context appropriately. 
```bash
$ kubectl config use-context demo1
```
4. Use kubectl to deploy the file -`rabbitmq-instance.yaml` in this example - that was downloaded in Step 1. 
```bash
$ kubectl apply -f rabbitmq-instance.yaml
```
5. Upon successful deployment, the following should be the status. Use the EXTERNAL-IP address of the rabbitmq-cluster service to connect to the cluster - `10.220.8.1` in this example.  
```bash
$ kubectl get all
NAME                                   READY   STATUS    RESTARTS   AGE
pod/demo1-rabbitmq-cluster0-server-0   1/1     Running   0          6d22h

$ kubectl get svc
NAME                                    TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)                                          AGE
service/demo1-rabbitmq-cluster0         LoadBalancer   10.96.0.53    10.220.8.1    5672:31907/TCP,15672:30104/TCP,15692:32637/TCP   6d22h
service/demo1-rabbitmq-cluster0-nodes   ClusterIP      None          <none>        4369/TCP,25672/TCP                               6d22h

NAME                                              READY   AGE
statefulset.apps/demo1-rabbitmq-cluster0-server   1/1     6d22h

NAME                                                   ALLREPLICASREADY   RECONCILESUCCESS   AGE
rabbitmqcluster.rabbitmq.com/demo1-rabbitmq-cluster0   True               False              6d22h
...
```
6. If you encounter a DockerHub rate-limiting for the RabbitMQ image, use a proxy-cache or host the image on another registry. The sample `rabbitmq-instance.yaml` shows how to reference an alternate image location.  

- For advanced configurations, check the [detailed reference](https://www.rabbitmq.com/kubernetes/operator/operator-overview).