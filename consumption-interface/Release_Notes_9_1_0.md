# LCI : Local Consumption Interface 9.1.0

# What's New in 9.1.0

## Container Service

LCI 9.1.0 introduces a major enhancement with Container Service, a new service dedicated to provisioning and managing container instances. Container Service supports standard Kubernetes **StatefulSet** and **Deployment** workloads, using **PodVMs** as the underlying execution environment.
Users can provision and manage these workloads as container instances within LCI, bringing container orchestration and VM-based infrastructure together through a unified control plane.

- **Create**: Configure container images and authentication, replicas, CPU and memory resources, PVCs, ConfigMaps, Secrets, load balancers, runtime settings, and sidecar and init containers.
- **List**: View deployed container instances and their current state.
- **Show Details**: View instance configuration, status, and pod and container details.
- **Delete**: Delete container instances, with an option to force-delete Pods.
- **Scale**: Adjust the number of replicas.

For more information, see [Container Service](https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vcf-consumption/latest/container-service.html) and [vSphere Supervisor concepts](https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vcf-9-0-and-later/9-1/vsphere-supervisor-installation-and-configuration/vsphere-supervisor-concepts/vsphere-iaas-control-plane-concepts/what-is-vsphere-with-tanzu.html#GUID-28421979-f68c-4896-ac99-31a2e6fb3394-en).

## VM Service

LCI 9.1.0 introduces key enhancements and additional capabilities for VM workload management through the Virtual Machine Service. Key features include **additional configuration options** for the VM’s network and storage, **additional UI workflows** for configuring and operation on a VM, and **consumer VM snapshots** for managing point-in-time states.

- **Consumer VM Snapshots**: You can now create, manage, and delete snapshots of VM Service VMs.
- **Edit VM Guest Customization**: You can now edit guest customization settings for existing VMs.
- **VM Labels and Annotations**: You can now add and edit labels and annotations when creating or updating VMs through the UI or API.
- **VM Volume Enhancements**: VM Service now supports Oracle RAC and Windows Server Failover Cluster (WSFC) workloads, and WaitForFirstConsumer (WFFC) PVCs.
- **Edit VM Network Configuration**: You can now configure multiple network interfaces when creating VMs, and add or delete network interfaces on existing VMs.
- **Edit Default Network Interface**: You can now edit the default VM network interface (`eth0`). It cannot be renamed or deleted.
- **VM Network Interface Subnet Inputs**: The VM creation wizard now accepts a subnet gateway address and static IP allocation settings. Subnet size, subnet CIDR, and subnetset CIDR inputs have been removed.
- **Network Interface IP Address for Non-DHCP Subnets**: When adding a network interface, you can enter an IP address only if the selected subnet has DHCP disabled.
- **No Default Gateway for Additional Non-DHCP Network Interfaces**: Additional network interfaces without DHCP are explicitly configured without a default gateway. DHCP-enabled interfaces retain their DHCP-provided gateway settings.

## vSphere Kubernetes Service (VKS)

LCI 9.1.0 introduces support for VKS 3.6 with the following features:

- **Multi-Networking Support**: You can now use multi-NIC and multi-network setups in your VKS Clusters, providing greater network flexibility.
- **RHEL Compatibility**: Worker nodes in VKS Clusters now support the Red Hat Enterprise Linux (RHEL) operating system.
- **New builtin-generic-v3.6.0 ClusterClass & VKr 1.35 Support**: Compatibility for Kubernetes Release (VKr) 1.35 is now available in VKS Clusters.
- **Node Configuration Customization**: You can now customize node configurations through features like automatic node placement to help optimize your resource usage.
- **Flexible Default StorageClass**: You can now set a WaitForFirstConsumer (WFFC), or late-binding, StorageClass as the defaultStorageClass for VKS clusters.
- **PVC Deletion Warning**: The UI now warns that Persistent Volume Claims (PVCs) are automatically deleted when you delete a Cluster, helping you avoid accidental data loss.
- **Redesigned Cluster Creation Workflow**: The "Create Cluster" flow is improved, offering better usability. It now features distinct sections for applying "overrides" to ClusterClass variables.
- **Schema-Driven ClusterClass Variables**: The UI now uses ClusterClass variable schemas to support all variables available on a ClusterClass.
- **ClusterClass Deprecation Indicator**: If a ClusterClass is based on an old VKS version, you'll see a visual warning to help guide you to the latest best practices.

# Fixed Issues

- **In VM Service IaaS plugin**: The UI no longer allows publishing images of currently deployed VKS cluster VMs.
- **In VKS IaaS plugin**: You can now upgrade a Cluster to a VKr (1.33.1 or higher) that supports multiple Ubuntu OS versions without first adding the 'os-version' annotation to the Cluster YAML.
- Resource updates now refresh automatically in the UI; users no longer need to use the reload button to refresh resource views.

# Known Issues and Limitations

- **For 8.0U3 installations**: Occasionally, the plug-in may fail to load on the initial attempt. To check if the plug-in has loaded correctly, click the **vSphere Client** menu icon, then to **Administration** -> **Client** -> **Plug-ins**. Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in Configuration with Reverse Proxy failed.* message, reinstall the plug-in.
- You must uninstall version 1.0.x before using the 9.x.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.
- **In VKS IaaS plugin**: If you want to update the Cluster to newer ClusterClass post retiring its TKC, first remove "kubernetes.vmware.com/skip-auto-cc-rebase: ''" annotation by editing (and saving) the Cluster YAML via the YAML editor shown on click of "View Yaml" button, before proceeding to upgrade the Cluster.

- [Previous release notes](./Release_Notes_9_0_2.md)
