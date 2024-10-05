Once the RabbitMQ Cluster Kubernetes Operator has been deployed successfully on the Supervisor, deploy a RabbitMQ Cluster object within your vSphere Namespace. To do so, follow the steps below.

1. Download the [example](rabbitmq-instance.yaml) as a reference for a simple deployment. You will need to modify the value of the `storageClassName` object as per your environment. 
2. Log in to the Supervisor - `10.220.3.18` is the Supervisor IP address in this example - with a user that has owner/edit access to the vSphere Namespace - `user@vsphere.local` in this example. 
```bash
$ kubectl vsphere login --server 10.220.3.18 -u user@vsphere.local
```
3. To deploy RabbitMQ Cluster to the vSphere Namespace - `demo1` in this example - set the context appropriately. 
```bash
$ kubectl config use-context demo1
```
4. Use kubectl to deploy the file -`rabbitmq-instance.yaml` in this example - that was downloaded in Step 1. 
```bash
$ kubectl apply -f rabbitmq-instance.yaml
```
5. Upon successful deployment, the following should be the status. Use the EXTERNAL-IP address of the rabbitmq-cluster service to connect to the cluster - `10.220.8.1` in this example.  
```bash
$ kubectl get all
NAME                                   READY   STATUS    RESTARTS   AGE
pod/demo1-rabbitmq-cluster0-server-0   1/1     Running   0          6d22h

$ kubectl get svc
NAME                                    TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)                                          AGE
service/demo1-rabbitmq-cluster0         LoadBalancer   10.96.0.53    10.220.8.1    5672:31907/TCP,15672:30104/TCP,15692:32637/TCP   6d22h
service/demo1-rabbitmq-cluster0-nodes   ClusterIP      None          <none>        4369/TCP,25672/TCP                               6d22h

NAME                                              READY   AGE
statefulset.apps/demo1-rabbitmq-cluster0-server   1/1     6d22h

NAME                                                   ALLREPLICASREADY   RECONCILESUCCESS   AGE
rabbitmqcluster.rabbitmq.com/demo1-rabbitmq-cluster0   True               False              6d22h
...
```
6. If you encounter a Dockerhub rate limiting for the RabbitMQ image, use a proxy-cache or host the image on another registry. The sample `rabbitmq-instance.yaml` shows how to reference an alternate image location.  