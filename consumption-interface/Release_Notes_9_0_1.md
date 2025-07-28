
# LCI : Local Consumption Interface 9.0.1
Known issues and limitations of the Consumption Interface Supervisor Service

# What's New in 9.0.1
## VKS
- LCI 9.0.1 supports features introduced in VKS 3.3 and VKS 3.4.
- New features
    - Feature compatiblity with VKS 3.3
        This release introduces support for following features made available in VKS 3.3
        - Provide an ability to configure Operating System FIPS and SSHD on the vSphere Kubernetes Service cluster nodes during the creation of the VKS - Ability to set the Ubuntu Pro Configuration to configure Ubuntu Pro subscription when using a Ubuntu based VKS cluster.
        - Provides a means to retire a TKC and continue managing existing VKS clusters using the cluster-api’s Cluster API.
        - Adds support for VKr version 1.32
    - Feature compatiblity with VKS 3.4
        This release introduces support for following features made available in VKS 3.4
        - Provide an ability to define custom labels and annotations for StorageClass instances that are synced from the Supervisor to the VKS cluster
        - Efficient ClusterClass consumption across namespaces by referencing the ClusterClass from _vmware-system-vks-public_ namespace.
        - Prevents the use of the deprecated TKC API to create Kubernetes 1.33 cluster, or upgrade an existing TKC cluster to Kubernetes release 1.33
        - Include both 'os-name' and 'os-version' annotations to the cluster configuration to enable Ubuntu Pro and FIPS during an Ubuntu based VKS cluster creation.
        - Adds support for VKr version 1.33
    - Allows the user to Upgrade an existing cluster by updating its VKr version.
--- 

# Known Issues

- For 8.0U3 installations: Occasionally, the plug-in may fail to load on the initial
attempt. To check if the plug-in has loaded correctly, click the **vSphere Client**
menu icon, then to **Administration** -> **Client** -> **Plug-ins**.
Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in
Configuration with Reverse Proxy failed.* message, reinstall the plug-in.

- You must uninstall version 1.0.x before using the 9.0.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.

- The UI allows users to publish TKG cluster VMs that are currently deployed. The published image will not be usable and users should not leverage this feature for such VMs.

- Resource updates will not automatically refresh in the UI. Users need to use the reload button to refresh the views on the resources.

- For 8.0U3 installations, LCI will not support following features:
    - Retire TKC is not supported and hence the upgrade from 1.32.x --> 1.33.x for a TKC will fail.
    - Ability to configure a Windows node pool to use Group Managed Service Accounts.
    - Cluster class 3.4.0 or VKr 1.33.x and higher.

- [Previous release notes](./Release_Notes_9_0_0.md)

# Fixed Issues

- Storage classes in non stretch supervisor environments should be correctly populated to allow successful deployment of VM, VKS Clusters and Volumes.
