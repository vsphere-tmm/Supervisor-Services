# Supervisor Services Catalog

Discover current Supervisor Services offered to support modern applications through vSphere Services.  
New service will be added overtime with the goal to continue to empower your DevOps communities.

*Supervisor Services are only available with Supervisor Clusters enabled using NSX-T*
  </br>
  </br>  
    
## vSAN Data Persistence Platform (vDPP): 
  </br>
  vSphere with Tanzu offers the vSAN Data Persistence platform. The platform provides a framework that enables third parties to integrate their cloud native service applications with underlying vSphere infrastructure, so that third-party software can run on vSphere with Tanzu optimally.</br>
</br>

- Using vSAN Data Persistence Platform (vDPP) with vSphere with Tanzu [documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-F7223607-30A5-4B2D-9B06-A55A65FEAA11.html)
- Avaliable vDPP Services [documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-F68B264E-76A3-4A6D-A3B0-17153DDF7A18.html) 

Partner Documentation Links: 
- MinIO partner [documentation](https://docs.min.io/minio/vsphere/core-concepts/core-concepts.html)
- Cloudian partner [documentation](https://cloudian.com/vmware/)

</br>
</br>

## Backup & Recovery Services

</br>
</br>

<p align="left">
  <img src="Velero.svg" width="250" title="Velero Logo">
</p>
Velero vSphere Operator helps users install Velero and its vSphere plugin on a vSphere with Kubernetes Supervisor cluster. Velero is an open source tool to safely backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.</br>
</br>

- Service install [documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-DA21BF67-160E-48D9-8D94-0D3690E51FD0.html)

**Velero vSphere Operator CLI Versions:**     *This is a prerequisite for a cluster admin install.*
- Download latest version: [Velero vSphere Operator CLI - v1.3.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.4.2/velero-vsphere-1.3.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.2.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.4.0/velero-vsphere-1.2.0-linux-amd64.tar.gz)
- Download: [Velero vSphere Operator CLI - v1.1.0](https://github.com/vmware-tanzu/velero-plugin-for-vsphere/releases/download/v1.1.0/velero-vsphere-1.1.0-linux-amd64.tar.gz)  


**Versions:**
- Download latest version: [Velero vSphere Operator v1.3.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.3.0%252Fvelero-supervisorservice-1.3.0.yaml)
- Download: [Velero vSphere Operator v1.2.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.2.0%252Fvelero-supervisorservic-1.2.0.yaml)
- Download version: [Velero vSphere Operator v1.1.0](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=Velero-YAML&path=Velero%252FSupervisorService%252F1.0.0%252Fvelero-supervisorservice-1.0.0.yaml)


</br>
</br>

## Certificate Management

</br>
</br>
<p align="left">
  <img src="cert-manager-logo.PNG" width="250" title="cert-manager Logo">
</p>
ClusterIssuers are Kubernetes resources that represent certificate authorities (CAs) that are able to generate signed certificates by honoring certificate signing requests. All cert-manager certificates require a referenced issuer that is in a ready condition to attempt to honor the request.</br>
</br>

- Service install - Follow steps 1 - 5 in the [documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-4843E6C6-747E-43B1-AC55-8F02299CC10E.html) then continue to the bullet point below.
- Read [Service Configuration](caclusterissuer/README.md) to understand how to install your root CA into the ca-clusterissuer.


**CA Cluster Issuer Versions:**
- Download latest version: [ca-clusterissuer v0.0.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=ca-clusterissuer/v0.0.1/ca-clusterissuer.yml)  

**CA Cluster Issuer Sample values.yaml**
- Download latest version: [values for v0.0.1](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=ca-clusterissuer/v0.0.1/ca-clusterissuer-data-values.yml)


## Cloud Native Registry

</br>
</br>
<p align="left">
  <img src="harbor-logo.png" width="250" title="Harbor Logo">
</p>
</br>
Harbor is an open source trusted cloud native registry project that stores, signs, and scans content. Harbor extends the open source Docker Distribution by adding the functionalities usually required by users such as security, identity and management. Having a registry closer to the build and run environment can improve the image transfer efficiency. Harbor supports replication of images between registries, and also offers advanced security features such as user management, access control and activity auditing.
</br>
</br>

- The [contour package](#contour) is a prerequisite for Harbor, so that must be installed
  first. 
- Service install - Follow steps 1 - 5 in the [documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-EB11DFDE-6ED4-4864-9E60-669F50D64397.html).


**Versions:**
- Download latest version: [Harbor v2.5.3](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.5.3/harbor.yml) 

**Harbor Sample values.yaml**
- Download the latest version: [values for v2.5.3](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=harbor/v2.5.3/harbor-data-values.yml). For details about each of the required properties, [see the configuration details page](harbor/README.md).


## Kubernetes Ingress Controller

</br>
</br>
<p align="left">
  <img src="contour-logo.png" width="250" title="Contour Logo" id="contour">
</p>
</br>
Contour is an Ingress controller for Kubernetes that works by deploying the Envoy proxy as a reverse proxy and load balancer. Contour supports dynamic configuration updates out of the box while maintaining a lightweight profile.
</br>
</br>

- Service install - Follow steps 1 - 5 in the [documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-services-workloads/GUID-4843E6C6-747E-43B1-AC55-8F02299CC10E.html).


**Versions:**
- Download latest version: [Contour v1.18.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.18.2/contour.yml) 

**Contour Sample values.yaml**
- Download the latest version: [values for v1.18.2](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=contour/v1.18.2/contour-data-values.yml). These values can be used _as-is_ and require no configuration changes. 

