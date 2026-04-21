# External-DNS 0.18.0 Configuration

The table below highlights the new supported fields for the External-DNS data values file from 0.18.0 release. 

| Property	                                                        | Value	  | Description                                                   |  
|------------------------------------------------------------------|---------|---------------------------------------------------------------| 
| externalDns.deployment.resources                                 | -	      | Resource quota of external-dns container.                     |
| externalDns.deployment.resources.requests.cpu                    | String  | Resource requests cpu quota.  By default value is "100m".     |
| externalDns.deployment.resources.requests.memory                 | String  | Resource requests memory quota.  By default value is "128Mi". |
| externalDns.deployment.resources.limits.cpu                      | String  | Resource limits cpu quota.  By default does not set.          |
| externalDns.deployment.resources.limits.memory                   | String  | Resource limits memory quota.  By default does not set.       |