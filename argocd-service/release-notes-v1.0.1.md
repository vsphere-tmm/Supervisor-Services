
# ArgoCD Service v1.0.1 Release Notes

## What's New

ArgoCD Service v1.0.1 introduces the following features:

- ✅ Supports creating and configuring **ArgoCD v2.14.15** instances.
  Refer to the [official documentation](https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/using-supervisor-services/using-argo-cd-service.html) for detailed instructions.

- ✅ Supports deploying ArgoCD Service and ArgoCD Intance from registry that requires authenticated access.
  Refer to the [official documentation](https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/managing-supervisor-services-with-vsphere-iaas-control-plane/deploying-supervisor-services-from-a-private-container-image-registry.html) for more details about deploying supervisor services from a private or self-hosted container image registry.

- ✅ Supports managing workloads on **vCenter Server 8.0 Update 3g**.

- ✅ Bug Fix: The field server.tlsCert in ArgoCD Spec causes ArgoCD Instance deployment to fail.