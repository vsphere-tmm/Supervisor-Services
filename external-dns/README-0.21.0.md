# External-DNS 0.21.0 Configuration

The table below highlights the new supported fields for the External-DNS data values file from 0.21.0 release. 

| Property	          | Value	  | Description                                                                         |  
|--------------------|---------|-------------------------------------------------------------------------------------| 
| rfc2136            | -	      | RFC2136 provider specified configuration definition section.                        |
| rfc2136.tsigSecret | String  | TSIG secret value. Replace the deprecating `deployment.args "--rfc2136-tsig-secret"`. |