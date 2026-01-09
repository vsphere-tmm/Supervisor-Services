
# LCI : Local Consumption Interface 9.0.2

# What's New in 9.0.2
## vSphere Kubernetes Service (VKS)
- LCI 9.0.2 supports features introduced in VKS 3.5 (and continues to support VKS 3.3 and 3.4)
- Other updates:
    - Cluster Auto-scaler: We can configure Cluster Auto-scaler add-on during creation and in Day-2 actions of a VKS Cluster.
    - Clusters can now be created using cluster.x-k8s.io/v1beta2 API version.
    - Kubernetes Releases are listed based on the selected ClusterClass.

# Known Issues and Limitations
- For 8.0U3 installations: Occasionally, the plug-in may fail to load on the initial attempt. To check if the plug-in has loaded correctly, click the **vSphere Client** menu icon, then to **Administration** -> **Client** -> **Plug-ins**. Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in Configuration with Reverse Proxy failed.* message, reinstall the plug-in.

- You must uninstall version 1.0.x before using the 9.0.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.

- The UI allows users to publish VKS cluster VMs that are currently deployed. The published image will not be usable and users should not leverage this feature for such VMs.

- In VKS IaaS plugin:
    - If you want to update the Cluster to newer ClusterClass post retiring its TKC, first remove "kubernetes.vmware.com/skip-auto-cc-rebase: ''" annotation by editing (and saving) the Cluster YAML via the YAML editor shown on click of "View Yaml" button, before proceeding to upgrade the Cluster.
    - To upgrade a Cluster to a VKR containing multiple Ubuntu OS versions, add 'os-version' field to the annotations by editing (and saving) the Cluster YAML via the YAML editor shown on click of "View Yaml" button, before proceeding to upgrade the Cluster.

- Resource updates will not automatically refresh in the UI. Users need to use the reload button to refresh the views on the resources.

- [Previous release notes](./Release_Notes_9_0_0.md)

# Fixed Issues
- For 8.0U3 installations using VKS-3.4 or higher, the following features are now available (previously unsupported in 9.0.1):
    - Ability to retire a TKC and upgrade a TKC from VKr 1.32.x --> 1.33.x
    - Ability to configure a Windows node pool to use Group Managed Service Accounts
    - Ability to upgrade a CAPI Cluster with at least one Ubuntu worker node from VKr 1.32.x --> 1.33.x
    - Support for ClusterClass 3.4.0 onwards, VKr 1.33.x and higher
- Creation of a Kubernetes Cluster with zero nodepools is allowed.
