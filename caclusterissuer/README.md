# CA Cluster Issuer Configuration

This guide assumes that you have already generated your root certificate and
key. 

The ca-clusterissuer only needs to be supplied two values to function. 
- `tls_crt` - This is a base64 encoded root certificate. 
- `tls_key` - This is the base64 encoded key/secret. 

These values need to be supplied when attempting to install the ca-clusterissuer
into a supervisor. We include a working [values.yml](https://vmwaresaas.jfrog.io/ui/api/v1/download?repoKey=supervisor-services&path=ca-clusterissuer/v0.0.1/ca-clusterissuer-data-values.yml) file here for convenience, but
this file should not be used in a production system. To generate a base64
version of your certificate and your key, you can run the following commands: 

```
$ cat crt.pem | base64 -w0 # or at crt.pem | base64 -b0 on BSD based systems
$ cat key.pem | base64 -w0 # or at key.pem | base64 -b0 on BSD based systems
```

These values can then be copied into the vCenter text box when prompted. 

⚠️ **Caution** CA issuers are generally for advanced users with a good idea of
how to run a PKI. To be used safely in production, CA issuers introduce complex
planning requirements around rotation, trust store distribution and disaster
recovery.

For more information on CA issuers, visit the [ca cert-manager
documentation](https://cert-manager.io/docs/configuration/ca/). 
