# Private AI Services

Private AI Services (PAIS) 2.0 was released as part of [VMware Private AI Foundation with NVIDIA 9.0][pdf-docs].
More information is available in [this blog post][official-blog-post] and [this blog series][wlam-blog].

The 1.0 version of PAIS did not provide a Supervisor Service component.
The PAIS Supervisor Service is available as PAIS 2.0:

| VCF  |  PAIS  |
| ---- | ------ |
| 9.0  | [2.0][pais-2.0-download] |

## PAIS CRDs
PAIS 2.0 is operated via two new Custom Resource Definitions (CRDs) into your Supervisor cluster:
- `PAISConfiguration` is a singleton per-namespace, where you specify a database, certificates, authentication, and other configuration for a PAIS "instance" within that namespace, including a PAIS API server and web UI.
- `ModelEndpoint`s configure inference servers for a given AI model, using VMs within your namespace, with routing via the namespace-level PAIS API server.

After you've installed the PAIS Supervisor Service, you can use [`kubectl explain`][kubectl-explain] to see the full documentation for each of these resources.  For example:
```
kubectl explain paisconfiguration.spec
```
or
```
kubectl explain modelendpoint.spec.engine
```


## Example resources

Here we're publishing example YAML files to help you get started with Private AI Services on VCF 9.

You must first [install the Private AI Services (PAIS) Supervisor Service][pdf-docs].

Then you can customize and apply:

- [An example `PAISConfiguration`](paisconfiguration.yaml) to configure Private AI Services within the tenant namespace
- [Example `ModelEndpoint` resources](modelendpoints.yaml) for running language models in a tenant namespace

[kubectl-explain]: https://kubernetes.io/docs/reference/kubectl/generated/kubectl_explain/
[official-blog-post]: https://blogs.vmware.com/cloud-foundation/2025/06/19/private-ai-services-new-in-vmware-private-ai-foundation-with-nvidia-in-vcf-9-0/
[pais-2.0-download]: ../README.md#how-to-find-and-install-supervisor-services
[pdf-docs]: https://techdocs.broadcom.com/content/dam/broadcom/techdocs/us/en/pdf/vmware/private-ai/private-ai-nvidia/vmware-private-ai-foundation-with-nvidia-9-0.pdf
[wlam-blog]: https://williamlam.com/category/private-ai-services
