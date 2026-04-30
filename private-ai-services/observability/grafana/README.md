# Public Grafana Dashboards

This folder contains sample Grafana dashboards that a VCF namespace user can import into their Grafana instance to visualize metrics for their Private AI Services (PAIS) deployment. Instructions for importing dashboards are available in the [Grafana documentation](https://grafana.com/docs/grafana/latest/visualizations/dashboards/build-dashboards/import-dashboards/).

> **Note:** Prometheus-based metrics collection must be enabled in the `PAISConfiguration` before using these dashboards. Refer to the official Private AI Services documentation for detailed instructions.

## Available Dashboards

| Dashboard | Description |
|-----------|-------------|
| `PAIS_LlamaCPP_ModelEndpoints.json` | Llama.cpp inference metrics including token throughput, prompt and generation processing times, and request queue status. |
| `PAIS_ModelEndpoints_Pod_Status.json` | Uptime and readiness status for model endpoint pods. |
| `PAIS_NVIDIA_GPU_Metrics.json` | Physical GPU metrics from the NVIDIA DCGM Exporter, including utilization, memory, temperature, and power usage. |
| `PAIS_NVIDIA_vGPU_Metrics.json` | Virtual GPU (vGPU) metrics from the NVIDIA DCGM Exporter, including utilization, memory, and clock speeds. |
