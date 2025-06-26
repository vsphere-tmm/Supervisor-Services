Known issues and limitations of the Consumption Interface Supervisor Service for version 1.0.2

**IMPORTANT NOTICE**: Occasionally, the plug-in may fail to load on the initial
attempt. To check if the plug-in has loaded correctly, click the **vSphere Client**
menu icon, then to **Administration** -> **Client** -> **Plug-ins**.
Check the Status column of the Namespace UI plug-in, and in case you see a "Plug-in
configuration with Reverse Proxy failed." Message, reinstall the plug-in.

LCI : Local Consumption Interface

What's New in 1.0.2

- Fix for customers running in environments with large numbers of groups associated with users in Active Directory. The supervisor service would install correctly but none of the services are operational.

Known Issues

- LCI is not supported on Multi-Zone Supervisors.

- After installing the service into a supervisor, you should expect a delay while the plugin is installed. If you do not see the plugin listed in the Resources tab under Workload Management -> Namespaces -> your namespace, please wait and then refresh the page.

- After installing the service into a supervisor, you will need to reload the web page or login in a new window to allow the plugin to load properly. Failure to do so may result in seeing a 502 error returned on the UI.

- The UI allows users to publish TKG cluster VMs that are currently deployed. The published image will not be usable and users should not leverage this feature for such VMs.

- There is a known issue in the TKG cluster creation wizard. If a user works backward through the wizard, some configuration may be lost. Users should execute the wizard end-to-end in sequence.

- Resource updates will not automatically refresh in the UI. Users need to use the reload button to refresh the views on the resources.

- [Previous release notes](./Release_Notes_1_0_1.md)


