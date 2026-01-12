
# LCI : Local Consumption Interface 9.0.2

# What's New in 9.0.2
## vSphere Kubernetes Service (VKS)
- LCI 9.0.2 supports features introduced in VKS 3.5 (and continues to support VKS 3.3 and 3.4)
- Other updates:
    - Cluster Autoscaler: You can configure Cluster Autoscaler add-on during Cluster creation and update.
    - Clusters can now be created using cluster.x-k8s.io/v1beta2 API version.
    - Kubernetes Releases are filtered based on the selected ClusterClass.

# Known Issues and Limitations
- For 8.0U3 installations: Occasionally, the plug-in may fail to load on the initial attempt. To check if the plug-in has loaded correctly, click the **vSphere Client** menu icon, then to **Administration** -> **Client** -> **Plug-ins**. Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in Configuration with Reverse Proxy failed.* message, reinstall the plug-in.

- You must uninstall version 1.0.x before using the 9.0.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.

- The UI allows users to publish VKS cluster VMs that are currently deployed. The published image will not be usable and users should not leverage this feature for such VMs.

- In VKS IaaS plugin:
    - If you want to update the Cluster to newer ClusterClass post retiring its TKC, first remove "kubernetes.vmware.com/skip-auto-cc-rebase: ''" annotation by editing (and saving) the Cluster YAML via the YAML editor shown on click of "View Yaml" button, before proceeding to upgrade the Cluster.
    - To upgrade a Cluster to **VKr(1.33.1)** or higher to support multiple Ubuntu OS versions, add 'os-version' field to the annotations by editing (and saving) the Cluster YAML via the YAML editor shown on click of "View Yaml" button, before proceeding to upgrade the Cluster. Please see https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/release-notes/vmware-vkr-release-notes.html#GUID-4075ed17-85c9-4865-b0cd-12c22eb06e60-en_id-e043d381-038c-4b81-bfb3-e7bf3c5e26de for more details.
    - When using Windows worker node with Cluster Autoscaler enabled, specific annotations need to be configured. Please see https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vsphere-supervisor-services-and-standalone-components/latest/managing-vsphere-kuberenetes-service-clusters-and-workloads/autoscaling-tkg-service-clusters/about-cluster-autoscaling.html for more details.

- Resource updates will not automatically refresh in the UI. Users need to use the reload button to refresh the views on the resources.

- [Previous release notes](./Release_Notes_9_0_1.md)

# Fixed Issues
- For 8.0U3 installations using VKS-3.4 or higher, the following features are now available (previously unsupported in 9.0.1):
    - Ability to Retire a TKC for transition to Cluster API.
    - Ability to configure Windows node pools to use Group Managed Service Accounts (GMSA).
    - Support for ClusterClass 3.4.0 and higher, and VKr 1.33.x and higher.
- Creation of a Kubernetes Cluster with zero nodepools is allowed.
