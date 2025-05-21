- [Supervisor Services Catalog](#supervisor-services-catalog)
  - [TKG Service](#tkg-service)
    - [TKG Service Versions](#tkg-service-versions)
  - [Consumption Interface](#consumption-interface)
    - [Consumption Interface Versions](#consumption-interface-versions)
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
  - [Data Services Manager Consumption Operator](#data-services-manager-consumption-operator)
    - [Data Services Manager Consumption Operator Versions](#data-services-manager-consumption-operator-versions)
---
- [Supervisor Services Labs Catalog](#supervisor-services-labs-catalog)
  - [ArgoCD Operator](#argocd-operator)
    - [ArgoCD Operator Versions](#argocd-operator-versions)
  - [External Secrets Operator](#external-secrets-operator)
    - [External Secrets Operator Versions](#external-secrets-operator-versions)
  - [RabbitMQ Cluster Kubernetes Operator](#rabbitmq-cluster-kubernetes-operator)
    - [RabbitMQ Cluster Kubernetes Operator Versions](#rabbitmq-cluster-kubernetes-operator-versions)
  - [Redis Operator](#redis-operator)
    - [Redis Operator Versions](#redis-operator-versions)
  - [KEDA](#keda)
    - [KEDA Versions](#keda-versions)
  - [Grafana Operator](#grafana-operator)
    - [Grafana Operator Versions](#grafana-operator-versions)


# Supervisor Services Catalog

Discover current Supervisor Services offered to support modern applications through vSphere Services.
New service will be added overtime with the goal to continue to empower your DevOps communities.

Prior vSphere 8 Update 1, the Supervisor Services are only available with Supervisor Clusters enabled using VMware NSX-T. With vSphere 8 U1, Supervisor Services are also supported when using the vSphere Distributed Switch networking stack.

| Supervisor Service | vSphere 7 | vSphere 8 |
| :--: | :--: | :--: |
| TKG Service | ❌ * | ✅ <br> _requires vSphere 8.0 Update 3 or later_|
| Consumption Interface | ❌ | ✅ <br> _requires vSphere 8.0 Update 3 or later_|
| vSAN Data Persistence Platform Services - MinIO | ✅ | ✅ |
| Backup \& Recovery Service - Velero | ✅ | ✅ |
| Certificate Management Service - cert-manager | ❌ | ✅ |
| Cloud Native Registry Service - Harbor | ❌ * | ✅ |
| Kubernetes Ingress Controller Service - Contour | ❌ | ✅ |
| External DNS Service - ExternalDNS | ❌ | ✅ |
| NSX Management Proxy | ❌ | ✅ <br> _requires vSphere 8.0 Update 3 or later with Supervisor Clusters enabled using VMware NSX-T_  |
| Data Services Manager Consumption Operator | ❌ | ✅ <br> _requires vSphere 8.0 Update 3 or later with additional configuration.<br> Please contact Global Support Services (GSS) for the additional configuration_ |
*\* The embedded Harbor Registry and TKG Service features are still available and supported on vSphere 7 and onwards.*

## TKG Service

VMware Tanzu Kubernetes Grid Service (TKG Service) lets you deploy Kubernetes workload clusters on the vSphere IaaS control plane. Starting with vSphere 8.0 Update 3, Tanzu Kubernetes Grid is installed as a Supervisor Service. This architectural change decouples TKG from vSphere IaaS control plane releases and lets you upgrade the TKG Service independent of vCenter Server and Supervisor.

- Service install [documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-iaas-cp-update/GUID-2005FFCD-07F4-450E-BAE5-445BE9D629AE.html)

### TKG Service Versions
The [Interoperability Matrix](https://interopmatrix.broadcom.com/Interoperability?col=820,17000,18237,17284,18034,18430,18431,18448,18667,18589,18562&row=2,%261794,&isHidePatch=true&isHideLegacyReleases=false) shows each TKG Service version below, including compatible Kubernetes releases and the vCenter Server versions containing compatible Supervisor versions. Note that some compatible Kubernetes releases may have reached End of Service; refer to the [Product Lifecycle](https://support.broadcom.com/group/ecx/productlifecycle) tool (Division: "VMware Cloud Foundation", Product Name: "Tanzu Kubernetes releases") to view End of Service dates for Kubernetes releases.

- Download latest version [TKG Service v3.3.2](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.3.2-package.yaml)
  - [Release Notes](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere-supervisor/8-0/release-notes/vmware-tanzu-kubernetes-grid-service-release-notes.html#GUID-4e548863-c753-46af-b78a-c308d560981d-en_id-72280637-4785-49e0-8728-860db0f1c284)
  - [OSS Information](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.3.2-package.open_source_license.txt)
- Download [TKG Service v3.3.1](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.3.1-package.yaml)
  - [Release Notes](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere-supervisor/8-0/release-notes/vmware-tanzu-kubernetes-grid-service-release-notes.html#GUID-4e548863-c753-46af-b78a-c308d560981d-en_id-d980858e-865c-4182-bc2d-6270521e9a19)
  - [OSS Information](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.3.1-package.open_source_license.txt)
- Download [TKG Service v3.3.0](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.3.0-package.yaml)
  - [Release Notes](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere-supervisor/8-0/release-notes/vmware-tanzu-kubernetes-grid-service-release-notes.html#GUID-4e548863-c753-46af-b78a-c308d560981d-en_id-9a8726db-dc10-44f5-8a7c-a030c6366c94)
  - [OSS Information](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.3.0-package.open_source_license.txt)
- Download [TKG Service v3.2.0](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.2.0-package.yaml)
  - [Release Notes](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere-supervisor/8-0/release-notes/vmware-tanzu-kubernetes-grid-service-release-notes.html#GUID-4e548863-c753-46af-b78a-c308d560981d-en_id-dc37abc7-0aa5-4d4c-8118-1a041f1afe65)
  - [OSS Information](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.2.0-package.open_source_license.txt)
- Download [TKG Service v3.1.1](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.1.1-package.yaml)
  - [Release Notes](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere-supervisor/8-0/release-notes/vmware-tanzu-kubernetes-grid-service-release-notes.html#GUID-4e548863-c753-46af-b78a-c308d560981d-en_id-79e16754-ab76-47cf-a500-9b9ddea90907)
  - [OSS Information](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.1.1-package.open_source_license.txt)
- Download [TKG Service v3.1.0](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.1.0-package.yaml)
  - [Release Notes](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere-supervisor/8-0/release-notes/vmware-tanzu-kubernetes-grid-service-release-notes.html#GUID-4e548863-c753-46af-b78a-c308d560981d-en_id-7580485a-27a3-4b85-99b8-412c2d61d6fe)
  - [OSS Information](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/kubernetes-service/3.1.0-package.open_source_license.txt)


## Consumption Interface

Provides the Local Consumption Interface (LCI) for Namespaces within vSphere Client. This also includes the Single Sign On (SSO) component required by the Cloud Consumption Interface (CCI) in Aria Automation within VMware Cloud Foundation.

The minimum required version for using this interface is vSphere 8 Update 3.

### Consumption Interface Versions

Installation instructions can be found [here in VMware documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-4843E6C6-747E-43B1-AC55-8F02299CC10E.html).

**IMPORTANT NOTICE**: Occasionally, the plug-in may fail to load on the initial
attempt. To check if the plug-in has loaded correctly, click the **vSphere Client**
menu icon, then to **Administration** -> **Client** -> **Plug-ins**.
Check the Status column of the Namespace UI plug-in, and in case you see a "Plug-in
configuration with Reverse Proxy failed." Message, reinstall the plug-in.

Download latest version:
- [Consumption Interface v1.0.2](https://vmwaresaas.jfrog.io/artifactory/supervisor-services/cci-supervisor-service/v1.0.2/cci-supervisor-service.yml)

- [Release notes](./consumption-interface/Release_Notes_1_0_2.md)

### OSS information

[LCI OSS](./consumption-interface/ConsumptionInterface_LocalConsumptionInterface_1_0_0.zip)

[SSO OSS](https://support.broadcom.com/group/ecx/productfiles?displayGroup=VMware%20Aria%20Suite%20-%20Enterprise&release=2019&os=&servicePk=202420&language=EN&groupId=204007) Refer to the Open Source Tab


## vSAN Data Persistence Platform (vDPP) Services:

vSphere with Tanzu offers the vSAN Data Persistence platform. The platform provides a framework that enables third parties to integrate their cloud native service applications with underlying vSphere infrastructure, so that third-party software can run on vSphere with Tanzu optimally.

- Using vSAN Data Persistence Platform (vDPP) with vSphere with Tanzu [documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-F7223607-30A5-4B2D-9B06-A55A65FEAA11.html)
- Enable Stateful Services in vSphere with Tanzu [documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-F68B264E-76A3-4A6D-A3B0-17153DDF7A18.html)


Available vDPP Services

- MinIO partner [documentation](https://docs.min.io/minio/vsphere/core-concepts/core-concepts.html)
  - Download version: [Minio 2.0.10](https://projects.packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/minio/minio-service-definition-v2.0.10-3.yaml)


## Backup & Recovery Service

<img src="Velero.svg" width="250" title="Velero Logo">

Velero vSphere Operator helps users install Velero and its vSphere plugin on a vSphere with Kubernetes Supervisor cluster. Velero is an open source tool to safely backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.

- Service install [documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-DA21BF67-160E-48D9-8D94-0D3690E51FD0.html)

### Velero vSphere Operator CLI Versions

*This is a prerequisite for a cluster admin install.*

- Download latest version: [Velero vSphere Operator CLI - v1.6.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.6.1%252Fvelero-vsphere-1.6.1-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.6.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.5.3/velero-vsphere-1.6.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.5.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.5.1/velero-vsphere-1.5.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.4.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.5.1/velero-vsphere-1.4.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.3.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.4.2/velero-vsphere-1.3.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.2.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.4.0/velero-vsphere-1.2.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.1.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.1.0/velero-vsphere-1.1.0-linux-amd64.tar.gz)

### Velero Versions

- Download latest version: [Velero vSphere Operator v1.6.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.6.1%252Fvelero-vsphere-1.6.1-def.yaml)
- Download: [Velero vSphere Operator v1.6.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.6.0%252Fvelero-vsphere-1.6.0-def.yaml)
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

- The [contour package](#contour) is a prerequisite for Harbor v2.9.x, so that must be installed
  first if you are using v2.9.x.
- Harbor v2.11.2 supports exposing the registry using loadbalancer, and contour is not required.
- Follow the instructions under [Installing and Configuring Harbor on a Supervisor](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-8C645717-C473-4E67-8DEE-049B71447B86.html).

### Harbor Versions

- Download latest version: [Harbor v2.11.2](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/harbor/harbor-service-v2.11.2-respin.yml)
- Download version: [Harbor v2.9.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.9.1/harbor.yml)

Harbor Sample `values.yaml`

- Download version: [values for v2.11.2](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/harbor/harbor-data-values-v2.11.2-respin.yml) For details about each of the required properties, [see the configuration details page](harbor/README-v2.11.2.md).
- Download version: [values for v2.9.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.9.1/harbor-data-values.yml). For details about each of the required properties, [see the configuration details page](harbor/README.md).

## Kubernetes Ingress Controller Service

<img src="contour-logo.png" width="250" title="Contour Logo" id="contour">

Contour is an Ingress controller for Kubernetes that works by deploying the Envoy proxy as a reverse proxy and load balancer. Contour supports dynamic configuration updates out of the box while maintaining a lightweight profile.

- Service install - Follow steps 1 - 5 in the [documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-4843E6C6-747E-43B1-AC55-8F02299CC10E.html).

### Contour Versions

- Download latest version: [Contour v1.29.3](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/contour/v1.29.3/contour-service-v1.29.3.yml)
- Download version: [Contour v1.28.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.28.2/contour.yml)
- Download version: [Contour v1.24.4](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.24.4/contour.yml)
- Download version: [Contour v1.18.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.18.2/contour.yml)

Contour Sample `values.yaml`

- Download latest [values for v1.29.3](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/contour/v1.29.3/contour-data-values.yml). These values can be used _as-is_ and require no configuration changes.
- Download [values for versions before v1.29.3](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.24.4/contour-data-values.yml). These values can be used _as-is_ and require no configuration changes.

## External DNS Service

<img src="external-dns-logo.png" width="250" title="External DNS Logo" id="external-dns">

ExternalDNS publishes DNS records for applications to DNS servers, using a declarative, Kubernetes-native interface. This operator connects to your DNS server (not included here). For a list of supported DNS providers and their corresponding configuration settings, see the [upstream external-dns project](https://github.com/kubernetes-sigs/external-dns).

- On Supervisors where Harbor is deployed with Contour, ExternalDNS may be used to publish a DNS hostname for the Harbor service.

### ExternalDNS Versions

- Download latest version: [ExternalDNS v0.14.2](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/external-dns/external-dns-service-0.14.2.yml)
- Download v0.13.4 version: [ExternalDNS v0.13.4](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=external-dns/v0.13.4/external-dns.yml)
- Download v0.11.0 version: [ExternalDNS v0.11.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=external-dns/v0.11.0/external-dns.yml)

ExternalDNS data `values.yaml`

- Because of the large list of supported DNS providers, we do not supply complete sample configuration values here. If you're deploying ExternalDNS with Harbor and Contour, make sure to include `source=contour-httpproxy` in the configuration values. An *incomplete* example of the service configuration is included below. Make sure to setup API access to your DNS server and include authentication details with the service configuration.

```yaml
deployment:
  args:
  - --source=contour-httpproxy
  - --source=service
  - --log-level=debug
```

Validated Supported DNS Server Example:
- RFC2136 BIND DNS Server: [values.yaml](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/external-dns/external-dns-data-values_0.14.2.yaml). Replace the values indicated by the comments with your own DNS server details.

## NSX Management Proxy

NSX Management Proxy is for Antrea-NSX adapter in TKG workload cluster to reach NSX manager. We recommend to use NSX Management Proxy when there is isolation between management network and workload network and the workloads running in TKG workload clusters cannot reach NSX manager.

### NSX Management Proxy Versions
- For vSphere 8.0 Update 3 or later
  - Download latest version: [nsx-management-proxy v0.2.2](https://packages.broadcom.com/artifactory/vsphere-distro/vsphere/iaas/nsx-management-proxy/v0.2.2/nsx-management-proxy.yml)
- For vSphere 8.0 Update 3
  - Download version: [nsx-management-proxy v0.2.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=nsx-management-proxy/v0.2.1/nsx-management-proxy.yml)
  - Download version: [nsx-management-proxy v0.2.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=nsx-management-proxy/v0.2.0/nsx-management-proxy.yml)
  - Download version: [nsx-management-proxy v0.1.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=nsx-management-proxy/v0.1.1/nsx-management-proxy.yml)

NSX Management Proxy Sample `values.yaml`

- Download [values for all versions](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=nsx-management-proxy/v0.1.1/nsx-management-proxy-data-values.yml). Make sure to fill the property `nsxManagers` with your NSX Manager IP(s).

**Note:** NSX Management Proxy is supported in vSphere 8.0 Update 3 when Supervisor Clusters are enabled using VMware NSX-T networking stack under following configurations:
- NSX Load Balancer is configured as load balancing solution.
- NSX Gateway Firewall is enabled.

## Data Services Manager Consumption Operator

The Data Services Manager(DSM) Consumption Operator facilitates native, self-service access to DSM within a Kubernetes environment. It exposes a selection of resources supported by the DSM provider, allowing customers to connect to the DSM provider from Kubernetes. Although the DSM provider does not currently support tenancy natively, the DSM Consumption Operator enables customers to seamlessly integrate their existing tenancy model, effectively introducing tenancy into the DSM provider.

- The DSM provider is a prerequisite for DSM consumption operator, so that must be installed first.
- Installation instructions can be found [here in VMware documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-A0A5F6D4-87A4-46CA-A50A-33664F43F299.html)
- Configuration instructions can be found [here in VMware documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-4843E6C6-747E-43B1-AC55-8F02299CC10E.html).

### Data Services Manager Consumption Operator Versions

- Download latest version: [DSM Consumption Operator v2.2.1](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/2.2.1/package.yaml)
- Download version: [DSM Consumption Operator v2.2.0](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/2.2.0/package.yaml)
- Download version: [DSM Consumption Operator v1.2.0](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/1.2.0/package.yaml)
- Download version: [DSM Consumption Operator v1.1.2](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/1.1.2/package.yaml)
- Download version: [DSM Consumption Operator v1.1.1](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/1.1.1/package.yaml)
- Download version: [DSM Consumption Operator v1.1.0](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/1.1.0/package.yaml)

Data Services Manager Consumption Operator Sample values. yaml

- Download latest version: [values for v2.2.1](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/2.2.1/values.yaml). For details about each of the required properties, [see the configuration details page](dsm-co/README_2_2_1.md#data-services-manager-consumption-operator-2.2.1-configuration).
- Download version: [values for v2.2.0](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/2.2.0/values.yaml). For details about each of the required properties, [see the configuration details page](dsm-co/README_2_2_0.md#data-services-manager-consumption-operator-2.2.0-configuration).
- Download version: [values for v1.2.0](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/1.2.0/values.yaml). For details about each of the required properties, [see the configuration details page](dsm-co/README_1_2_0.md#data-services-manager-consumption-operator-1.2.0-configuration).
- Download version: [values for v1.1.2](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/1.1.2/values.yaml).
- Download version: [values for v1.1.1](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/1.1.1/values.yaml).
- Download version: [values for v1.1.0](https://packages.broadcom.com/artifactory/dsm-distro/dsm-consumption-operator/supervisor-service/1.1.0/values.yaml).

**Installation Note:** DSM Consumption Operator v2.2.X<br>
When installing DSM Consumption Operator v2.2.X as a Supervisor Service, if you encounter any issues related to the Service-id, please contact Global Support Services (GSS) for immediate assistance.

**Upgrade Note:** DSM Consumption Operator v2.2.X<br>
Earlier versions of the DSM Consumption Operator, including v1.1.0, v1.1.1, v1.1.2 and v1.2.0 are deprecated and should not be used for new Supervisor Service installation.
If you are upgrading from these older versions to v2.2.X, do not uninstall the existing version. Instead, we highly recommend contacting GSS for guidance and support. This will ensure a smooth upgrade process and prevent potential disruptions.
For additional help, please refer to the support documentation or reach out to our technical support team.

---
# Supervisor Services Labs Catalog

## *Experimental*

The following Supervisor Services Labs catalog is only provided for testing and educational purposes. Please do not use these services in a production environment. These services are intended to demonstrate Supervisor Services' capabilities and usability. VMware will strive to provide regular updates to these services. The Labs services have been tested starting from vSphere 8.0. Over time, depending on usage and customer needs, some of these services may be included in the core product.

**WARNING** - By downloading and using these solutions from the Supervisor Services Labs catalog, you explicitly agree to the conditional use **[license agreement](supervisor-services-labs/licence-agreement.md)**.

## ArgoCD Operator

<img src="supervisor-services-labs/argocd-operator/argocd.png" width="200" title="ArgoCD Logo" id="argocd">

The Argo CD Operator manages the entire lifecycle of Argo CD and its components. The operator aims to automate the tasks required to operate an Argo CD deployment. Beyond installation, the operator helps automate the process of upgrading, backing up, and restoring as needed and removes the human toil as much as possible. For a detailed description of how to consume the ArgoCD Operator, see the [ArgoCD Operator project.](https://argocd-operator.readthedocs.io/en/latest/)

### ArgoCD Operator Versions

- Download the latest version: [ArgoCD Operator v0.12.0](supervisor-services-labs/argocd-operator/v0.12.0/argocd-operator.yaml)
- Download previous v0.8.0:    [ArgoCD Operator v0.8.0](supervisor-services-labs/argocd-operator/v0.8.0/argocd-operator.yaml)

ArgoCD Operator Sample `values.yaml` for v0.12.0 - [values.yaml](supervisor-services-labs/argocd-operator/v0.12.0/values.yaml)
ArgoCD Operator Sample `values.yaml` for v0.8.0  - None

- The sample `values.yaml` for the latest version has been provided above. This operator requires minimal configurations, and the necessary pods get deployed in the  `svc-argocd-operator-domain-xxx` namespace.

#### Usage:

- Check out this example on deploying an ArgoCD instance with the Argo CD Operator [here.](supervisor-services-labs/argocd-operator/usage.md)
- For advanced configurations, check the [detailed reference](https://argocd-operator.readthedocs.io/en/latest/reference/argocd/) and [sample usage](https://argocd-operator.readthedocs.io/en/latest/usage/basics/)

## External Secrets Operator

<img src="supervisor-services-labs/external-secrets-operator/externalsecrets.png" width="200" title="External Secrets Logo" id="externalsecrets">

External Secrets Operator is a Kubernetes operator that integrates external secret management systems like AWS Secrets Manager, HashiCorp Vault, Google Secrets Manager, Azure Key Vault, IBM Cloud Secrets Manager, CyberArk Conjur, etc. The operator reads information from external APIs and automatically injects the values into a Kubernetes Secret. For a detailed description of how to consume External Secrets Operator, visit [External Secrets Operator project](https://external-secrets.io/latest/)

### External Secrets Operator Versions

- Download latest version: [External Secrets Operator v0.9.14](supervisor-services-labs/external-secrets-operator/v0.9.14/external-secrets-operator.yaml)

External Secrets Operator Sample `values.yaml` - None

- We do not provide this package's default `values.yaml`. This operator requires minimal configurations, and the necessary pods get deployed in the `svc-external-secrets-operator-domain-xxx` namespace.

#### Usage:

- Check out this example on how to access a secret from **GCP Secret Manager** using External Secrets Operator [here](supervisor-services-labs/external-secrets-operator/usage.md)

## RabbitMQ Cluster Kubernetes Operator

<img src="supervisor-services-labs/rabbitmq-operator/rabbitmq-logo.svg" width="150" title="RabbitMQ Logo" id="rabbitmq">

The RabbitMQ Cluster Kubernetes Operator provides a consistent and easy way to deploy RabbitMQ clusters to Kubernetes and run them, including "day two" (continuous) operations. RabbitMQ clusters deployed using the Operator can be used by applications running on or outside Kubernetes. For a detailed description of how to consume the RabbitMQ Cluster Kubernetes Operator, see the [RabbitMQ Cluster Kubernetes Operator project.](https://www.rabbitmq.com/kubernetes/operator/operator-overview)

### RabbitMQ Cluster Kubernetes Operator Versions

- Download latest version: [RabbitMQ Cluster Kubernetes Operator v2.8.0](supervisor-services-labs/rabbitmq-operator/v2.8.0/rabbitmq-operator.yaml)

RabbitMQ Cluster Kubernetes Operator Sample `values.yaml` -

- Modify the latest [values.yaml](supervisor-services-labs/rabbitmq-operator/v2.8.0/values.yaml) by providing a new location for the RabbitMQ Cluster Kubernetes Operator image. This may be required to overcome DockerHub's rate-limiting issues. The RabbitMQ Cluster Kubernetes Operator pods and related artifacts get deployed in the `svc-rabbitmq-operator-domain-xx` namespace.

#### Usage:

- Check out this example on how to deploy a RabbitMQ cluster using the RabbitMQ Cluster Kubernetes Operator [here](supervisor-services-labs/rabbitmq-operator/usage.md)
- For advanced configurations, check the [detailed reference](https://www.rabbitmq.com/kubernetes/operator/operator-overview).

## Redis Operator

<img src="supervisor-services-labs/redis-operator/redis.png" width="200" title="Redis Logo" id="redis">

A Golang-based Redis operator that oversees Redis standalone/cluster/replication/sentinel mode setup on top of Kubernetes. It can create a Redis cluster setup using best practices. It also provides an in-built monitoring capability using Redis-exporter. For a detailed description of how to consume the Redis Operator, see the [Redis Operator project.](https://ot-redis-operator.netlify.app/docs/overview/)

### Redis Operator Versions

- Download latest version: [Redis Operator v0.16.0](supervisor-services-labs/redis-operator/v0.16.0/redis-operator.yaml)

Redis Operator Sample `values.yaml` -

- We do not provide this package's default `values.yaml`. This operator requires minimal configurations, and the necessary pods get deployed in the `svc-redis-operator-domain-xxx` namespace.

#### Usage:

- View an example of how to use the Redis Operator to deploy a Redis standalone instance [here](supervisor-services-labs/redis-operator/redis-instance.yaml)
- For advanced configurations, check the [detailed reference](https://ot-redis-operator.netlify.app/docs/getting-started/).

## KEDA

<img src="supervisor-services-labs/keda/keda.svg" width="200" title="Keda Logo" id="keda">

KEDA is a single-purpose and lightweight component that can be added into any Kubernetes cluster. KEDA works alongside standard Kubernetes components like the Horizontal Pod Autoscaler and can extend functionality without overwriting or duplication. With KEDA you can explicitly map the apps you want to use event-driven scale, with other apps continuing to function. This makes KEDA a flexible and safe option to run alongside any number of any other Kubernetes applications or frameworks. For a detailed description of how to use KEDA, see the [Keda project.](https://keda.sh/)

### KEDA Versions

- Download latest version: [KEDA v2.13.1](supervisor-services-labs/keda/v2.13.1/keda.yaml) Note: This version supports Kubernetes v1.27 - v1.29.

KEDA Sample `values.yaml` -

- We do not provide this package's default `values.yaml`. This operator requires minimal configurations, and the necessary pods get deployed in the `svc-kedaxxx` namespace.

#### Usage:

- View an example of how to use KEDA `ScaledObject` to scale an NGINX deployment [here](supervisor-services-labs/keda/usage.md).
- For additonal examples, check the [detailed reference](https://github.com/kedacore/samples).

## Grafana Operator

<img src="supervisor-services-labs/grafana-operator/Grafana.png" width="200" title="Grafana Logo" id="grafana">

Grafana Operator is a Kubernetes operator built to help you manage your Grafana instances and its resources from within Kubernetes. The operator can install and manage local Grafana instances, Dashboards and Datasources through Kubernetes Custom resources. The Grafana Operator automatically syncs the Kubernetes Custom resources and the actual resources in the Grafana Instance. For a detailed description of how to use Grafana Operator, see the [Grafana Project.](https://grafana.com/docs/grafana-cloud/developer-resources/infrastructure-as-code/grafana-operator/)

### Grafana Operator Versions

- Download latest version: [Grafana Operator v5.15.0](supervisor-services-labs/grafana-operator/v5.15.0/grafana-operator.yaml).

Grafana Operator Sample `values.yaml` for v5.15.0 - [values.yaml](supervisor-services-labs/grafana-operator/v5.15.0/values.yaml)

- The sample `values.yaml` for the latest version has been provided above. This operator requires minimal configurations, and the necessary pods get deployed in the `svc-grafana-operator-xxx` namespace.

#### Usage:

- View an example of how to use Grafana Operator to create a Grafana instance [here](supervisor-services-labs/grafana-operator/usage.md).
- For additonal examples, check the [detailed reference](https://grafana.github.io/grafana-operator/docs/examples/).
