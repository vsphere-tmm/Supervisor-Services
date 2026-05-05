# Private AI Services

Private AI Services (PAIS) supervisor service was introduced at version 2.0 as part of [VMware Private AI Foundation with NVIDIA 9.0][pdf-docs].
More information is available in [this blog post][official-blog-post] and [this blog series][wlam-blog].
(The 1.0 version of PAIS did not provide a Supervisor Service component.)
Following versions of PAIS Supervisor Services are available:

| Supported VCF/Supervisor versions  |  PAIS  |
| ---------------------------------- | ------ |
| 9.0.\*                             | [2.0][pais-download] |
| 9.0.\*, 9.1.\*                     | [2.1][pais-download] |

## PAIS CRDs
PAIS is operated via two new Custom Resource Definitions (CRDs) into your Supervisor cluster:
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

## PAIS features

### Observability: Metrics Configuration

PAIS 2.1 supports collecting metrics from various PAIS components into a
Prometheus server with TimeseriesDB storage and provides access to those
metrics through Prometheus server query interface (ref: Prometheus [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/)).

`PAISConfiguration` CRD supports an optional field `spec.observability.prometheusRuntime`,
specifying following fields enables metrics collection. If `prometheusRuntime` is
unspecified (default behavior), it implies that metrics collection is not enabled.
* `metricsRetention`: Unit is number of days, min 1d, max 90d, and also default if unspecified.
* `storageClass`: Used for placing the PVC for Prometheus TSDB storage, default is value of
   top level `spec.defaultStorageClassName`), useful to override if default storage class is
   unsuitable for metrics storage (e.g. space constraints, IO perf constraints etc.).

Please see [`PAISConfiguration`](paisconfiguration.yaml) for example values.

[kubectl-explain]: https://kubernetes.io/docs/reference/kubectl/generated/kubectl_explain/
[official-blog-post]: https://blogs.vmware.com/cloud-foundation/2025/06/19/private-ai-services-new-in-vmware-private-ai-foundation-with-nvidia-in-vcf-9-0/
[pais-download]: ../README.md#how-to-find-and-install-supervisor-services
[pais-install]: https://techdocs.broadcom.com/us/en/vmware-cis/private-ai/foundation-with-nvidia/9-0/private-ai-foundation-9-x/deploying-private-ai-foundation-with-nvidia/install-private-ai-services-on-the-supervisor.html
[pdf-docs]: https://techdocs.broadcom.com/content/dam/broadcom/techdocs/us/en/pdf/vmware/private-ai/private-ai-nvidia/vmware-private-ai-foundation-with-nvidia-9-0.pdf
[wlam-blog]: https://williamlam.com/category/private-ai-services
