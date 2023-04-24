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
  - [Service Discovery Service](#service-discovery-service)
    - [ExternalDNS Versions](#externaldns-versions)


# Supervisor Services Catalog

Discover current Supervisor Services offered to support modern applications through vSphere Services.
New service will be added overtime with the goal to continue to empower your DevOps communities.

Prior vSphere 8 Update 1, the Supervisor Services are only available with Supervisor Clusters enabled using VMware NSX-T. With vSphere 8 U1, Supervisor Services are also supported when using the vSphere Distributed Switch networking stack.

| Supervisor Service | vSphere 7 | vSphere 8 |
| :--: | :--: | :--: |
| vSAN Data Persistence Platform Services - MinIO, Cloudian and Dell ObjectScale| ✅ | ✅ |
| Backup \& Recovery Service - Velero | ✅ | ✅ |
| Certificate Management Service - Cert-Manager | ❌ | ✅ |
| Cloud Native Registry Service - Harbor | ❌ * | ✅ |
| Kubernetes Ingress Controller Service - Contour | ❌ | ✅ |
| External DNS Service - External DNS | ❌ | ✅ |
*\* The embedded Harbor Registry feature is still available and supported on vSphere 7 and onwards.*
    
## vSAN Data Persistence Platform (vDPP): 
  </br>
  vSphere with Tanzu offers the vSAN Data Persistence platform. The platform provides a framework that enables third parties to integrate their cloud native service applications with underlying vSphere infrastructure, so that third-party software can run on vSphere with Tanzu optimally.</br>
</br>

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

- Download latest version: [Velero vSphere Operator CLI - v1.3.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.4.2/velero-vsphere-1.3.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.2.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.4.0/velero-vsphere-1.2.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.1.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.1.0/velero-vsphere-1.1.0-linux-amd64.tar.gz)

### Velero Versions

- Download latest version: [Velero vSphere Operator v1.3.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.3.0%252Fvelero-supervisorservice-1.3.0.yaml)
- Download: [Velero vSphere Operator v1.2.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.2.0%252Fvelero-supervisorservic-1.2.0.yaml)
- Download version: [Velero vSphere Operator v1.1.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.0.0%252Fvelero-supervisorservice-1.0.0.yaml)

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

- Download latest version: [Harbor v2.5.3](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.5.3/harbor.yml)

Harbor Sample `values.yaml`

- Download the latest version: [values for v2.5.3](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.5.3/harbor-data-values.yml). For details about each of the required properties, [see the configuration details page](harbor/README.md).

## Kubernetes Ingress Controller Service

<img src="contour-logo.png" width="250" title="Contour Logo" id="contour">

Contour is an Ingress controller for Kubernetes that works by deploying the Envoy proxy as a reverse proxy and load balancer. Contour supports dynamic configuration updates out of the box while maintaining a lightweight profile.

- Service install - Follow steps 1 - 5 in the [documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-4843E6C6-747E-43B1-AC55-8F02299CC10E.html).

### Contour Versions

- Download latest version: [Contour v1.18.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.18.2/contour.yml)

Contour Sample `values.yaml`

- Download the latest version: [values for v1.18.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.18.2/contour-data-values.yml). These values can be used _as-is_ and require no configuration changes.

## External DNS Service

<img src="external-dns-logo.png" width="250" title="External DNS Logo" id="external-dns">

ExternalDNS publishes DNS records for applications to DNS servers, using a declarative, Kubernetes-native interface. This operator connects to your DNS server (not included here). For a list of supported DNS providers and their corresponding configuration settings, see the [upstream external-dns project](https://github.com/kubernetes-sigs/external-dns).

- On Supervisors where Harbor is deployed with Contour, ExternalDNS may be used to publish a DNS hostname for the Harbor service.

### External DNS Versions

- Download latest version: [ExternalDNS v0.11.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=external-dns/v0.11.0/external-dns.yml)

ExternalDNS data `values.yaml`

- Because of the large list of supported DNS providers, we do not supply complete sample configuration values here. If you're deploying ExternalDNS with Harbor and Contour, make sure to include `source=contour-httpproxy` in the configuration values. An *incomplete* example of the service configuration is included below. Make sure to setup API access to your DNS server and include authentication details with the service configuration.

```yaml
deployment:
  args:
  - --source=contour-httpproxy
  - --source=service
  - --log-level=debug
```
