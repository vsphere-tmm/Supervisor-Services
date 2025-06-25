
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
- VKS 3.3/3.4 are not supported with LCI 9.0.0. Support will come with an upcoming release of LCI 9.0.1.
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

A cluster can be created with the following cluster variables.
UI supports all versions of ClusterClass variables and will update the yaml based on the version selected. Variables supported for ClusterClass 3.2 and higher are listed below

| Variable Name | Property |
| ----------- | ----------- |
| vmClass| vmClass|
| storageClass | storageclass |
| volumes | volumes|
| node | Labels Taints |
| kubernetes | certificateRotation - ‘enabled’ and set to 90 days by default |
| kubernetes | endpointFQDNs |
| vsphereOptions | persistentVolumes (availableStorageClasses, defaultStorageClass) |
| osConfiguration | ntp |
| osConfiguration | systemProxy (Http, https, noProxy)
| osConfiguration | trust additionalTrustedCAs |

--- 

## Standalone LCI
Admins can provide a link to launch LCI independent of granting access to the vSphere client

## Known Issues

- The UI allows users to publish TKG cluster VMs that are currently deployed. The published image will not be usable and users should not leverage this feature for such VMs.

- Resource updates will not automatically refresh in the UI. Users need to use the reload button to refresh the views on the resources.

- [Previous release notes](./Release_Notes_1_0_2.md)


