# LCI : Local Consumption Interface 9.1.3

# Fixed Issues

- **In VKS IaaS plugin**: A TKC on 1.32.x, once retired, can now be upgraded to 1.33.x (or a higher VKr) directly from the upgrade cluster workflow, without an admission webhook error or manual editing of the cluster object (previously a known issue in 9.1.1 and 9.1.2).

# Known Issues and Limitations

- **For 8.0U3 installations**: Occasionally, the plug-in may fail to load on the initial attempt. To check if the plug-in has loaded correctly, click the **vSphere Client** menu icon, then to **Administration** -> **Client** -> **Plug-ins**. Check the Status column of the VMware Local Consumption Interface plug-in, and in case you see a *Plug-in Configuration with Reverse Proxy failed.* message, reinstall the plug-in.
- You must uninstall version 1.0.x before using the 9.x.x version of LCI. Failure to do so will result in the interface not starting correctly when looking at the `Resources` tab for a namespace.
- **In VKS IaaS plugin**: Provisioning a cluster using the Default Configuration may trigger an admission webhook error in the event Pod CIDR blocks overlap with Supervisor-managed IP ranges. To ensure successful cluster deployment, select the Custom configuration and specify the Pod CIDR to prevent IP range overlap.

- [Previous release notes](./Release_Notes_9_1_2.md)
