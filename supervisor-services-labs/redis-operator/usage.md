Once the Redis Operator has been deployed successfully on the Supervisor, deploy a Redis Instance within your vSphere Namespace. To do so, follow the steps below.

1. Download the [example](redis-instance.yaml) as a reference for a simple deployment. You must modify the value of the `storageClassName` object as per your environment. The file also contains a Secret with the password `VMware123!` BASE64 encoded. Modify the file with your own BASE64 encoded password string. 
2. Log in to the Supervisor - `10.220.3.18` is the Supervisor IP address in this example - with a user that has owner/edit access to the vSphere Namespace - `user@vsphere.local` in this example. 
```bash
$ kubectl vsphere login --server 10.220.3.18 -u user@vsphere.local
```
3. To deploy Redis Instance to the vSphere Namespace - `demo1` in this example - set the context appropriately. 
```bash
$ kubectl config use-context demo1
```
4. Use kubectl to deploy the file -`redis-instance.yaml` in this example - that was downloaded in Step 1. 
```bash
$ kubectl apply -f redis-instance.yaml
```
5. Upon successful deployment, the following should be the status. Use the EXTERNAL-IP address of the redis-standalone-additional service to connect to the cluster - `10.220.8.6` in this example.  
```bash
$ kubectl get all
k get all -n demo1
NAME                                   READY   STATUS    RESTARTS   AGE
pod/demo1-redis-standalone-0           1/1     Running   0          6h21m

NAME                                        TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)                                          AGE
service/demo1-redis-standalone              ClusterIP      10.96.0.121   <none>        6379/TCP                                         6h21m
service/demo1-redis-standalone-additional   LoadBalancer   10.96.1.172   10.220.8.6    6379:31610/TCP                                   6h21m
service/demo1-redis-standalone-headless     ClusterIP      None          <none>        6379/TCP                                         6h21m

NAME                                              READY   AGE
statefulset.apps/demo1-redis-standalone           1/1     6h21m
...
```
6. Use the `redis-cli` to connect to the Redis instance that was just deployed. When prompted, provide the password - `VMware123!` in this example - to connect to the instance. 
```
$ redis-cli -h 10.220.8.6 --askpass
Please input password: *********
10.220.8.6:6379>
```