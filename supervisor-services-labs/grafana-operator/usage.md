Once the Grafana Operator has been successfully deployed on the Supervisor, deploy a Grafana object within your vSphere Namespace. To do so, follow the steps below.

1. Download the [example](grafana-instance.yaml) as a reference for a simple deployment.
2. Log in to the Supervisor - `10.220.3.18` is the Supervisor IP address in this example - with a user that has owner/edit access to the vSphere Namespace - `user@vsphere.local` in this example. 
```bash
$ kubectl vsphere login --server 10.220.3.18 -u user@vsphere.local
```
3. To deploy Grafana to the vSphere Namespace - `demo1` in this example - set the context appropriately. 
```bash
$ kubectl config use-context demo1
```
4. Use kubectl to deploy the file -`grafana-instance.yaml` in this example - that was downloaded in Step 1. 
```bash
$ kubectl apply -f grafana-instance.yaml
```
5. Upon successful deployment, the following should be the status. 
```bash
$ kubectl get all -n demo1
NAME                                      READY   STATUS    RESTARTS   AGE
pod/grafana-deployment-58bcb66668-hbhsf   1/1     Running   0          20h
...

NAME                          TYPE           CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
service/grafana-service       LoadBalancer   10.96.0.59   10.43.16.68   3000:32063/TCP   20h
...

NAME                                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/grafana-deployment      1/1     1            1           20h
...

NAME                                               DESIRED   CURRENT   READY   AGE
replicaset.apps/grafana-deployment-58bcb66668      1         1         1       20h
...
```
Use the EXTERNAL-IP address / PORT 3000 of the grafana-service service to connect to the UI - `10.43.16.68:3000` in this example. The login credentials are in the  `grafana-instance.yaml` file.

6. If you are deploying Grafana on an NSX-based deployment, some of the additional custom resources may not be deployed due to the NSX firewall, which prevents communication across vSphere Namespaces. To bypass this restriction, use the sample K8s NetworkPolicy provided in the [example](supervisor-services-labs/grafana-operator/networkpolicy.yaml).

```bash
$ cat networkpolicy.yaml
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: grafana-network-policy
spec:
  podSelector:
    matchLabels:
      app: grafana
  policyTypes:
  - Ingress
  ingress:
  - from:
    - ipBlock:
        cidr: "0.0.0.0/0"
    ports:
    - port: 3000

$ kubectl apply -f networkpolicy.yaml -n demo1
```