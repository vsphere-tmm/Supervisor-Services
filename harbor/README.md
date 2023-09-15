# Harbor Configuration 

Below is table that highlights the required fields for the Harbor data values file. 

| Property	                                                        | Value	              | Description    |                                                                                         
|------------------------------------------------------------------| -------------------- | -------------- |                                                                                        
| hostname	                                                        | FQDN	                | The FQDN that you have designated to access the Harbor UI and for referencing the registry in client applications. The domain should be configured in an external DNS server such that it resolves to the Envoy Service IP created by Contour.|
| tlsCertificate.tlsSecretLabels	                                  | {"managed-by": "vmware-vRegistry"}|	The certificate that Tanzu Kubernetes Grid uses to install the Harbor CA as a trusted root on Tanzu Kubernetes Grid clusters.|
| persistence.persistentVolumeClaim.registry.storageClass 	        | A storage policy name.|	A storage class that is used for the Harbor registry PVCs.|
| persistence.persistentVolumeClaim.jobservice.jobLog.storageClass | A storage policy name.|	A storage class that is used for the Harbor jobservice PVCs.|
| persistence.persistentVolumeClaim.database.storageClass	         | A storage policy name.|	A storage class that is used for the Harbor database PVCs.|
| persistence.persistentVolumeClaim.redis.storageClass	            | A storage policy name.|	A storage class that is used for the Harbor redis PVCs.|
| persistence.persistentVolumeClaim.trivy.storageClass	            | A storage policy name.|	A storage class that is used for Harbor trivy PVCs.|
