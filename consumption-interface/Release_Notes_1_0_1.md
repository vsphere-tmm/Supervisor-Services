Known issues and limitations of the Consumption Interface Supervisor Service

LCI : Local Consumption Interface

What's New

- Minimal support for Kubernetes Service 3.2 is included. This version of the Consumption Interface is compatible with Kubernetes Service 3.2 but does not yet support all operations or features included with Kubernetes Service 3.2. In particular, there is no support for windows or the Cluster Class 3.2 version of the API. Clusters created using the Cluster Class 3.1 version of the API will be successful but day 2 operations need to be handled through the use of kubectl.
Also - because we have auto-rebase to higher version, certain variables which were supported in Cluster Class 3.1 will not be visible in the Cluster Class 3.2

Known Issues

- LCI is not supported on Multi-Zone Supervisors.

- After installing the service into a supervisor, you should expect a delay while the plugin is installed. If you do not see the plugin listed in the Resources tab under Workload Management -> Namespaces -> your namespace, please wait and then refresh the page.

- After installing the service into a supervisor, you will need to reload the web page or login in a new window to allow the plugin to load properly. Failure to do so may result in seeing a 502 error returned on the UI.

- The UI allows users to publish TKG cluster VMs that are currently deployed. The published image will not be usable and users should not leverage this feature for such VMs.

- There is a known issue in the TKG cluster creation wizard. If a user works backward through the wizard, some configuration may be lost. Users should execute the wizard end-to-end in sequence.

- Resource updates will not automatically refresh in the UI. Users need to use the reload button to refresh the views on the resources.

