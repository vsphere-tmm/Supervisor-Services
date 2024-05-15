Once Keda has been deployed successfully on the Supervisor, deploy NGINX within your vSphere Namespace. To do so, follow the steps below.

1. Download the [NGINX example](supervisor-services-labs/keda/nginx-deployment.yaml) as a reference for a simple deployment.

2. Log in to the Supervisor - `10.220.3.18` is the Supervisor IP address in this example - with a user with owner/edit access to the vSphere Namespace - `user@vsphere.local` in this example. 
```bash
$ kubectl vsphere login --server 10.220.3.18 -u user@vsphere.local
```

3. To deploy NGINX to the vSphere Namespace - `demo1` in this example - set the context appropriately. 
```bash
$ kubectl config use-context demo1
```

4. Use kubectl to deploy the file -`nginx-deployment.yaml` in this example - downloaded in Step 1. 
```bash
$ kubectl apply -f nginx-deployment.yaml 
```

5. Upon successful deployment, the following should be the status. There should be 0 NGINX pods deployed as the deployment manifest states `replicas: 0`
```bash
$ kubectl get deployment
k get deployment -n demo1
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment    0/0    0            0           43m
```

6. Download the [scaledobject example](supervisor-services-labs/keda/scaledobject-instance.yaml) as a reference yaml for scaling the NGINX deployment based on a trigger type `cron`. The example will scale the `nginx-deployment` to 10 replicas from **6AM to 8PM EST**. Modify the values in the YAML accordingly.  

7. Use kubectl to deploy the file -`scaledobject-instance.yaml` in this example - downloaded in Step 6. 
```bash
$ kubectl apply -f scaledobject-instance.yaml
```

8. The NGINX deployment should have scaled to 10 replicas if you are within the cron window.
```bash
$ date
Fri May 03 15:48:52 EDT 2024

$ kubectl get pods -n demo1
NAME                               READY   STATUS    RESTARTS   AGE
...
nginx-deployment-8bdf8c964-5g579   1/1     Running   0          58m
nginx-deployment-8bdf8c964-7g5jn   1/1     Running   0          58m
nginx-deployment-8bdf8c964-c7s4q   1/1     Running   0          58m
nginx-deployment-8bdf8c964-cgmx4   1/1     Running   0          58m
nginx-deployment-8bdf8c964-l54jj   1/1     Running   0          58m
nginx-deployment-8bdf8c964-pptp8   1/1     Running   0          58m
nginx-deployment-8bdf8c964-tj5p9   1/1     Running   0          58m
nginx-deployment-8bdf8c964-vqjgc   1/1     Running   0          58m
nginx-deployment-8bdf8c964-w92rg   1/1     Running   0          58m
nginx-deployment-8bdf8c964-zxbl2   1/1     Running   0          58m
```