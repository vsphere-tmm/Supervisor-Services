
# LCI : Local Consumption Interface 9.0.1

# What's New in 9.0.1
## vSphere Kubernetes Service (VKS)
- LCI 9.0.1 supports features introduced in VKS 3.4 and VKS 3.3
- VKS 3.4 features
    - Ability to define custom labels and annotations for StorageClass instances that are synced from the Supervisor to the VKS cluster.
    - Efficient ClusterClass consumption across namespaces by referencing the ClusterClass from _vmware-system-vks-public_ namespace.
    - Prevents the use of the deprecated TKC API to create Kubernetes 1.33 cluster, or upgrade an existing TKC cluster to Kubernetes release 1.33
    - Include both 'os-name' and 'os-version' annotations to the cluster configuration to enable Ubuntu Pro and FIPS during an Ubuntu based VKS cluster creation.
    - Adds support for VKr version 1.33
- VKS 3.3 features
    - Ability to configure Operating System FIPS and SSHD on the vSphere Kubernetes Service cluster nodes during the creation of the VKS cluster.
    - Ability to set the Ubuntu Pro Configuration to configure Ubuntu Pro subscription when using a Ubuntu based VKS cluster.
    - Provides a means to retire a TKC and continue managing existing VKS clusters using the cluster-api’s Cluster API.
    - Adds support for VKr version 1.32
- Allows the user to Upgrade an existing cluster by updating its VKr version.
--- 

# Known Issues and Limitations

- For 8.0U3 installations: 
    - Occasionally, the plug-in may fail to load on the initial attempt. To check if the plug-in has loaded correctly, click the **vSphere Client** menu icon, then to **Administration** -> **Client** -> **Plug-ins**. Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in Configuration with Reverse Proxy failed.* message, reinstall the plug-in.
    - VKS will not support following features:
        - Ability to retire a TKC is not supported and hence the upgrade from VKr 1.32.x --> 1.33.x for a TKC will fail.
        - Ability to configure a Windows node pool to use Group Managed Service Accounts.
        - Ability to upgrade a CAPI Cluster with atleast one Ubuntu worker nodes from VKr 1.32.x --> 1.33.x
        - Cluster class 3.4.0 and VKr 1.33.x and higher.

- You must uninstall version 1.0.x before using the 9.0.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.

- The UI allows users to publish VKS cluster VMs that are currently deployed. The published image will not be usable and users should not leverage this feature for such VMs.

- When using the VKS IaaS plugin, you must enter a new value on the volume dialog when adding a volume.

- Resource updates will not automatically refresh in the UI. Users need to use the reload button to refresh the views on the resources.

- [Previous release notes](./Release_Notes_9_0_0.md)

# Fixed Issues

- Storage classes in non stretch supervisor environments should be correctly populated to allow successful deployment of VM, VKS Clusters and Volumes.
