
# ArgoCD Service v1.1.0 Release Notes

## What's New

ArgoCD Service 1.1.0 introduces the following features:

- ✅ Supports creating and configuring ArgoCD v3.0.19 instances. Refer to the official documentation for detailed instructions.

- ✅ Support managing VKS add-ons.

- ✅ Enforce TLS 1.2 as TLS Min Version.

- ✅ Sets the default resources.requests.cpu and resources.requests.memory for ArgoCD instance pods to "0". If values are explicitly set in ArgoCD.Spec, the user defined values will be used instead of the default.

