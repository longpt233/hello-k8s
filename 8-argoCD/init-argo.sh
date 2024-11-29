(base) admini@5002544:~$ docker ps                                                                                                                                                            
CONTAINER ID   IMAGE                                 COMMAND                  CREATED        STATUS        PORTS                                                                              
                                          NAMES                                                                                                                                               
5f269069342d   gcr.io/k8s-minikube/kicbase:v0.0.45   "/usr/local/bin/entr…"   16 hours ago   Up 16 hours   0.0.0.0:32777->22/tcp, 0.0.0.0:32776->2376/tcp, 0.0.0.0:32775->5000/tcp, 0.0.0.0:32
774->8443/tcp, 0.0.0.0:32773->32443/tcp   minikube                                                                                                                                            
045c43a8096a   rancher/rancher                       "entrypoint.sh"          16 hours ago   Up 16 hours   0.0.0.0:80->80/tcp, :::80->80/tcp, 0.0.0.0:443->443/tcp, :::443->443/tcp           
                                          rancher-server  


(base) admini@5002544:~$ minikube ip
192.168.49.2

kubectl create namespace argocd 
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc -n argocd argocd-server --patch '{"spec": {"type": "NodePort"}}'


check thoi con dau cx k can chay lenh nay
(base) admini@5002544:~$ minikube service argocd-server  -n argocd  --url                       
http://192.168.49.2:32644
http://192.168.49.2:30519


> k -n argocd get svc argocd-server
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
argocd-server   NodePort   10.110.175.46   <none>        80:32644/TCP,443:30519/TCP   15h
> kubectl get nodes -owide 
NAME       STATUS   ROLES           AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
minikube   Ready    control-plane   16h   v1.29.0   192.168.49.2   <none>        Ubuntu 22.04.4 LTS   5.15.0-125-generic   docker://27.2.0

pkill -f "ssh -f -N"
ssh -f -N -L 9090:192.168.49.2:32644 admini@171.244.xxx.xxx
-> https://localhost:9090

lệnh sau chạy trên shell của rancher lỗi éo jh đấy 
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
*************
>