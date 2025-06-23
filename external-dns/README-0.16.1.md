# External-DNS 0.16.1 Configuration

The table below highlights the required fields for the External-DNS data values file. 

| Property	                                                        | Value	                          | Description                                                                                                                                                         |  
|------------------------------------------------------------------|---------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------| 
| tlsConfig                                                        | -	                              | The TLS enablment configuration parameter.                                                                                                                          |
| tls_enable                                                       | bool(false/true)                | To decide if will enable TLS configuration.  By default value is false.                                                                                             |
| ca_crt                                                           | base64-encode value | The root CA certificate that issued the DNS server's TLS certificate and the value should be a single-line base64-encoded format which contains the CA certificate. |