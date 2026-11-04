# LCI : Local Consumption Interface 9.1.2

# What's New in 9.1.2

## Container Service

- **Temporary Writable Storage**: Configure container instances with `emptyDir` volumes to give applications space for caches, intermediate files, or data shared between containers in the same Pod.
- **CPU and Memory Controls**: Set requests and limits for the primary container so its resource needs are declared for scheduling and its usage is bounded.
- **Advanced Runtime Settings**: Configure health probes, security contexts, and lifecycle hooks so applications can report readiness, run with the required permissions, and shut down cleanly.

# Fixed Issues

- **In VM Service IaaS plugin**:
  - **Persistent Volume Claims (PVC)**: The VM volume attachment workflow now allows only block-mode PVCs, preventing attachment of unsupported filesystem-mode PVCs.
  - **VM Migration Age Display**: Resolved an issue to ensure the original age of migrated VMs is accurately displayed.
  - **Windows Hostname Length Limit**: Restricted the hostname length to a maximum of 15 characters for Windows VMs configured with Sysprep.
  - **NIC Details Visibility**: Ensured Network Interface Card (NIC) details remain accessible for viewing even when the VM is powered off.
- **In VKS IaaS plugin**:
  - Windows OS images are no longer visible in Add Nodepool on a cluster that uses a non-Antrea CNI.
  - If a nodepool has a Windows OS image set, the OS image field is now correctly populated on the cluster's Summary tab for that nodepool.
  - Cluster variables that require CIDR values under Create Cluster - Advanced Settings now accept valid CIDR values.

# Known Issues and Limitations

- **For 8.0U3 installations**: Occasionally, the plug-in may fail to load on the initial attempt. To check if the plug-in has loaded correctly, click the **vSphere Client** menu icon, then to **Administration** -> **Client** -> **Plug-ins**. Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in Configuration with Reverse Proxy failed.* message, reinstall the plug-in.
- You must uninstall version 1.0.x before using the 9.x.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.
- **In VKS IaaS plugin**:
  - Retiring a 1.32.x VMware Kubernetes Service cluster and then upgrading it to 1.33.x fails with an admission webhook error and requires manually editing the cluster object.
  - Provisioning a cluster using the Default Configuration may trigger an admission webhook error in the event Pod CIDR blocks overlap with Supervisor-managed IP ranges. To ensure successful cluster deployment, select the Custom configuration and specify the Pod CIDR to prevent IP range overlap.

- [Previous release notes](./Release_Notes_9_1_1.md)
