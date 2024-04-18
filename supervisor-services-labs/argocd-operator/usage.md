Once the ArgoCD Operator has been deployed successfully on the Supervisor, deploy an ArgoCD object within your vSphere Namespace. To do so, follow the steps below.

1. Download the [example](supervisor-services-labs/argocd-operator/argocd-instance.yaml) as a reference for a simple deployment.
2. Log in to the Supervisor - `10.220.3.18` is the Supervisor IP address in this example - with a user that has owner/edit access to the vSphere Namespace - `user@vsphere.local` in this example. 
```bash
$ kubectl vsphere login --server 10.220.3.18 -u user@vsphere.local
```
3. To deploy ArgoCD to the vSphere Namespace - `demo1` in this example - set the context appropriately. 
```bash
$ kubectl config use-context demo1
```
4. Use kubectl to deploy the file -`argocd-instance.yaml` in this example - that was downloaded in Step 1. 
```bash
$ kubectl apply -f argocd-instance.yaml
```
5. Upon successful deployment, the following should be the status. Use the EXTERNAL-IP address of the argocd-server service to connect to the UI - `10.220.3.20` in this example.  
```bash
$ kubectl get pods
NAME                                        READY   STATUS    RESTARTS   AGE
demo1-argocd-application-controller-0       1/1     Running   0          5m9s
demo1-argocd-redis-cd8c958fd-jltgd          1/1     Running   0          5m9s
demo1-argocd-repo-server-6ccccfc999-rm4ng   1/1     Running   0          5m9s
demo1-argocd-server-945597778-2qfjk         1/1     Running   0          5m9s

$ kubectl get svc
NAME                                          TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)                      AGE
...
demo1-argocd-server                           LoadBalancer   10.96.0.88    10.220.3.20   80:30803/TCP,443:30679/TCP   6m41s
...
```
6. If you encounter a DockerHub rate-limiting for the Redis image, use a proxy-cache or host the image on another registry. The sample `argocd-instance.yaml` shows how to reference an alternate image location.  