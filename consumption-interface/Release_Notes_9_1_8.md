# LCI : Local Consumption Interface 9.1.8

# What's New in 9.1.8
LCI 9.1.8 supports VCFA 9.1.2 release with the following features:

## Container Service

- **Container Logs**: View and search live logs for a specific container in a vSphere Pod to pinpoint startup failures and application errors without setting up `kubectl`.
- **Log Downloads**: Download a container's logs from Pod details for offline investigation or sharing with support.
- **Interactive Terminal**: Open a browser terminal in a running container to inspect files and configuration or run diagnostic commands without node access.

## VM Service

- **In-Place NIC Edit**: Update a VM's NIC network directly without deleting and recreating the interface.
- **ISO Mount Support**: Mount ISO images to VMs for OS installation, upgrades, or recovery.
- **Default Gateway**: Configure or update the default gateway for VMs.
- **YAML Viewer Redaction**: Added support for redacting sensitive data in the YAML viewer.

## vSphere Kubernetes Service (VKS)
This release supports the features introduced in VKS 3.8, including:

- **New builtin-generic-v3.8.0 ClusterClass and VKr 1.37 Support**: VKS clusters now support vSphere Kubernetes Release (VKR) 1.37 and include the updated builtin-generic-v3.8.0 ClusterClass.
- **Rollout Required Indicator**: When modifying a Cluster variable that triggers a node rollout, the user interface displays an indicator (**R**) next to the corresponding label.
- **Immutable PhotonOS Compatibility**: Control plane and worker nodes in VKS Clusters now support the **Immutable** variant of Photon OS.
- **Updated VM Class Requirements**: VM classes below the minimum required sizing for VKS (such as **x-small/xsmall** or custom VM classes below minimum specs) are no longer available during VKS Cluster creation.
- **Addon Repositories Configuration**: Users can now configure VKS AddonRepositories directly from the Supervisor > Configure tab.

# Fixed Issues

- **In VM Service IaaS plugin**:
  - The actual namespace default network name for `eth0` is now displayed correctly.
  - Added RFC-1035 compliance validation for new VM Load Balancer names to prevent deployment errors.
  - The PVC Increase Capacity modal now displays WaitForFirstConsumer (WFFC) storage class names when applicable.

# Known Issues and Limitations

- **For 8.0U3 installations**: Occasionally, the plug-in may fail to load on the initial attempt. To check if the plug-in has loaded correctly, click the **vSphere Client** menu icon, then to **Administration** -> **Client** -> **Plug-ins**. Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in Configuration with Reverse Proxy failed.* message, reinstall the plug-in.
- You must uninstall version 1.0.x before using the 9.x.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.
- **In VKS IaaS plugin**: Provisioning a cluster using the Default Configuration may trigger an admission webhook error in the event Pod CIDR blocks overlap with Supervisor-managed IP ranges. To ensure successful cluster deployment, select the Custom configuration and specify the Pod CIDR to prevent IP range overlap.

- [Previous release notes](./Release_Notes_9_1_3.md)
