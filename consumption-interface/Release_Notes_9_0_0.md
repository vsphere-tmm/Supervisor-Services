
# LCI : Local Consumption Interface 9.0.0
Known issues and limitations of the Consumption Interface Supervisor Service

# What's New in 9.0.0
## VM Service
- Guided workflows now include CloudInit, Sysprep, LinuxPrep, vAppConfig
- Support for creating VMs in zones
- Guided workflow for creating VM from an ISO image
- Ability to update VM service class to resize CPU/memory usage only
- Ability to create multiple network interfaces with different subnet selection


## VKS
- LCI 9.0.0 is compatible with VKS 3.0 through 3.4, and can be used for managing the lifecycle of clusters with any of these versions.
- However, LCI 9.0.0 does not support functionality introduced in VKS 3.3 and VKS 3.4. This will be addressed in a future LCI patch.
- New features
    - Add support for consuming multiple Content Libraries configured for Kubernetes Service on Supervisor for both Cluster and TanzuKubernetesCluster API
    - Add support for vSphere Zones for both Cluster and TanzuKubernetesCluster API
    - Ability to configure a Windows node pool to use Group Managed Service Accounts
    - Introduced following Cluster Day 2 actions
        - Increase Replicas
        - Update VM Class
        - Add/Update/Delete Volumes
    - Support for variables introduced in builtin-generic-v3.2.0 cluster class

VKS v3.2.0 introduced the concept of versioned cluster class objects. It shipped with cluster class builtin-generic-v3.2.0 which introduces a new variable schema. LCI 9.0.0 adds supports for this.

Please see the documentation for these variables here: [ClusterClass Variables for Customizing a Cluster](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere-supervisor/8-0/using-tkg-service-with-vsphere-supervisor/provisioning-tkg-service-clusters/using-the-builtin-generic-v3-2-0-clusterclass/clusterclass-variables-for-customizing-a-cluster.html)

--- 

## Standalone LCI
Admins can provide a link to launch LCI independent of granting access to the vSphere client

# Known Issues

- For 8.0U3 installations: Occasionally, the plug-in may fail to load on the initial
attempt. To check if the plug-in has loaded correctly, click the **vSphere Client**
menu icon, then to **Administration** -> **Client** -> **Plug-ins**.
Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in
configuration with Reverse Proxy failed.* message, reinstall the plug-in.

- You must uninstall version 1.0.x before using the 9.0.0 version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.

- The UI allows users to publish TKG cluster VMs that are currently deployed. The published image will not be usable and users should not leverage this feature for such VMs.

- Resource updates will not automatically refresh in the UI. Users need to use the reload button to refresh the views on the resources.

- [Previous release notes](./Release_Notes_1_0_2.md)


