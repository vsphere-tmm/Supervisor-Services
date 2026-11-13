# LCI : Local Consumption Interface 9.1.8

# What's New in 9.1.8
LCI 9.1.8 supports VCFA 9.1.2 release with the following features:

## Container Service

- **Container Logs**: View and search live logs for a specific container in a vSphere Pod to pinpoint startup failures and application errors without setting up `kubectl`.
- **Log Downloads**: Download a container's logs from Pod details for offline investigation or sharing with support.
- **Interactive Terminal**: Open a browser terminal in a running container to inspect files and configuration or run diagnostic commands without node access.

## VM Service

### Features and Enhancements

- **In-Place NIC Edit**: Added support for in-place NIC editing, allowing NIC Network updates without requiring deletion and recreation.
- **ISO Mount Support**: Added support for mounting ISO images.
- **Default Gateway**: Added support for changing the default gateway.
- **YAML Viewer Redaction**: Added support for redaction of sensitive data in the YAML viewer.

## vSphere Kubernetes Service (VKS)

LCI 9.1.8 introduces support for VKS 3.8 with the following features:

- **New builtin-generic-v3.8.0 ClusterClass & VKr 1.37 Support**: Compatibility for Kubernetes Release (VKr) 1.37 is now available in VKS Clusters.
- **Rollout Required Indicator**: When modifying a Cluster variable triggers a node rollout, the user interface displays an indicator (**R**) adjacent to the respective label for guidance.
- **Immutable PhotonOS Compatibility**: Control plane and worker nodes in VKS Clusters now support the **Immutable** variant of Photon operating system.
- **Updated VM Class Requirements**: VM classes below the minimum required sizing for VKS (such as **x-small/xsmall** or custom VM classes with lower specifications) are no longer available during VKS Cluster creation.
- **Addon Repositories Configuration**: VKS AddonRepositories can be configured by Admins via the Supervisor/Configure tab.

# Fixed Issues

- **In VM Service IaaS plugin**:
  - The actual namespace default network name for `eth0` is now displayed correctly.
  - New VM Load Balancer names are now validated for RFC-1035 compliance.
  - The PVC Increase Capacity modal now displays WFFC storage class names when applicable.

# Known Issues and Limitations

- **For 8.0U3 installations**: Occasionally, the plug-in may fail to load on the initial attempt. To check if the plug-in has loaded correctly, click the **vSphere Client** menu icon, then to **Administration** -> **Client** -> **Plug-ins**. Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in Configuration with Reverse Proxy failed.* message, reinstall the plug-in.
- You must uninstall version 1.0.x before using the 9.x.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.
- **In VKS IaaS plugin**: Provisioning a cluster using the Default Configuration may trigger an admission webhook error in the event Pod CIDR blocks overlap with Supervisor-managed IP ranges. To ensure successful cluster deployment, select the Custom configuration and specify the Pod CIDR to prevent IP range overlap.

- [Previous release notes](./Release_Notes_9_1_3.md)
