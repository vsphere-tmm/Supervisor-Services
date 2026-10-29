# LCI : Local Consumption Interface 9.1.1

# What's New in 9.1.1

## vSphere Kubernetes Service (VKS)

LCI 9.1.1 introduces support for VKS 3.7 with the following features:

- **ClusterClass 3.7 Support**: Includes schema changes and consumes variable metadata.
- **Cluster Scaling Enhancements**: Increased the worker node ceiling to 250 and added Pod CIDR limit adjustments.
- **Multi-Control-Plane Nodes**: Added support for up to 5 control plane nodes per cluster.
- **Node Pool Management**: Added day-2 delete operations for node pools.
- **Secondary NIC & Driver Exposure**: Exposed the NIC VFIO-PCI driver field and second-level ClusterClass variables schema handling for advanced networking.
- **CNI Selection**: You can now select a CNI during cluster creation.
- **TKC Support Deprecation**: Removed TKC support from LCI.

# Fixed Issues

- **In VKS IaaS plugin**: After retiring a TKC, you can now update the cluster to a newer ClusterClass without manually removing the `kubernetes.vmware.com/skip-auto-cc-rebase` annotation from the cluster YAML (previously a known issue in 9.1.0).

# Known Issues and Limitations

- **For 8.0U3 installations**: Occasionally, the plug-in may fail to load on the initial attempt. To check if the plug-in has loaded correctly, click the **vSphere Client** menu icon, then to **Administration** -> **Client** -> **Plug-ins**. Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in Configuration with Reverse Proxy failed.* message, reinstall the plug-in.
- You must uninstall version 1.0.x before using the 9.x.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.
- **In VKS IaaS plugin**:
  - Retiring a 1.32.x VMware Kubernetes Service cluster and then upgrading it to 1.33.x fails with an admission webhook error and requires manually editing the cluster object.
  - Windows OS images are visible in Add Nodepool on a cluster when using a non-Antrea CNI.
  - If a nodepool is using a Windows OS image, the OS image field is blank on the cluster's Summary tab for that nodepool.
  - Cluster variables that require CIDR values under Create Cluster - Advanced Settings reject valid CIDR values.
  - Provisioning a cluster using the Default Configuration may trigger an admission webhook error in the event Pod CIDR blocks overlap with Supervisor-managed IP ranges. To ensure successful cluster deployment, select the Custom configuration and specify the Pod CIDR to prevent IP range overlap.

- [Previous release notes](./Release_Notes_9_1_0.md)
