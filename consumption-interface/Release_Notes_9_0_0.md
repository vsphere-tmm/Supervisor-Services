
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
- Supports VKS up until 3.2.
- The new features for VKS 3.3/3.4 are not supported with LCI 9.0.0. Support for the new features will be available with an upcoming release of LCI 9.0.1. You can still use VKS for managing the lifecycle of the cluster for VKS 3.3/3.4.
- New features
    - Multiple CL on Supervisor for both TKC and CAPI Cluster
    - vSphere Zones for both TKC and CAPI Cluster
    - Windows OS worker nodes
    - Windows AD
    - Day 2 actions
        - Increase Replicas
        - Update VM CLass
        - Add/Update/Delete Volumes
- VKS 3.2 variables

VKS v3.2.0 introduced the concept of versioned ClusterClass objects. It shipped with ClusterClass builtin-generic-v3.2.0 which introduces a new variable schema. LCI 9.0.0 adds supports for this.

Please see the documentation for these variables here: [ClusterClass Variables for Customizing a Cluster](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere-supervisor/8-0/using-tkg-service-with-vsphere-supervisor/provisioning-tkg-service-clusters/using-the-builtin-generic-v3-2-0-clusterclass/clusterclass-variables-for-customizing-a-cluster.html)

--- 

## Standalone LCI
Admins can provide a link to launch LCI independent of granting access to the vSphere client

## Known Issues

- You must uninstall version 1.0.x before using the 9.0.0 version of LCI. Failure to do so will result in the interface not starting correctly when looking at the Resources tab for a namespace.

- The UI allows users to publish TKG cluster VMs that are currently deployed. The published image will not be usable and users should not leverage this feature for such VMs.

- Resource updates will not automatically refresh in the UI. Users need to use the reload button to refresh the views on the resources.

- [Previous release notes](./Release_Notes_1_0_2.md)


