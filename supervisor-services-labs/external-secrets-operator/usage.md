Since the External Secrets Operator integrates with multiple providers, usage varies based on the types of secret stores accessed and secrets consumed. Once the External Secrets Operator has been deployed successfully on the Supervisor, basic operations include creating a `SecretStore` object and an `ExternalSecret` object within your vSphere Namespace.

1. Download the [example](supervisor-services-labs/external-secrets-operator/external-secrets-example.yaml) as a reference for a simple usage. For this example to work, store an SSH private key as a secret called `tkg-ssh-priv-keys` in **GCP Secret Manager**. A service account with the `Secret Manager Secret Accessor` role should be granted access to the secret. The service account's key has to been downloaded and kept in a secure location. (*Note* - Service account keys could pose a security risk if compromised, and this exercise is for demo purposes only) 
2. Log in to the Supervisor - `10.220.3.18` is the Supervisor IP address in this example - with a user with owner/edit access to the vSphere Namespace - `user@vsphere.local` in this example. 
```bash
$ kubectl vsphere login --server 10.220.3.18 -u user@vsphere.local
```
3. To create External Secrets objects within the vSphere Namespace - `demo1` in this example - set the context appropriately. 
```bash
$ kubectl config use-context demo1
```
4. Create a secret to store the GCP service account's key downloaded in step 1 - `key.json` in this example.
```bash
$ kubectl create secret generic gcpsm-secret --from-file=secret-access-credentials=key.json -n demo1
```
5. Modify Line 14 `projectID: my-gcp-projectid` of the file -`external-secrets-example.yaml` in this example - that was downloaded in Step 1, per your GCP ProjectID and use kubectl to deploy the file. 
```bash
$ kubectl apply -f external-secrets-example.yaml
```
6. Upon successful deployment, a new secret object `workload-vsphere-tkg2-ssh` should have been created and its data should match the one uploaded in the GCP Secret Manager. 
```bash
$ kubectl get secret -n demo1 workload-vsphere-tkg2-ssh -o json |jq -r '.data."ssh-privatekey"'|base64 -d
``` 