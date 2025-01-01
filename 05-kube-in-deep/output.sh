long@hello:~$ kubectl get nodes -o wide
NAME    STATUS   ROLES           AGE   VERSION    INTERNAL-IP      EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
hello   Ready    control-plane   22h   v1.28.15   10.208.164.167   <none>        Ubuntu 24.04.1 LTS   6.8.0-48-generic   containerd://1.7.22
vupc    Ready    <none>          22h   v1.28.15   10.208.164.173   <none>        Ubuntu 24.04 LTS     6.8.0-48-generic   containerd://1.6.14


long@hello:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                            READY   STATUS             RESTARTS        AGE
kube-system   coredns-5dd5756b68-56zsk        1/1     Running            0               22h
kube-system   coredns-5dd5756b68-m2q88        1/1     Running            0               22h
kube-system   etcd-hello                      1/1     Running            5               22h
kube-system   kube-apiserver-hello            1/1     Running            1               22h
kube-system   kube-controller-manager-hello   1/1     Running            0               22h
kube-system   kube-proxy-p7hh9                1/1     Running            0               22h
kube-system   kube-proxy-wzfks                0/1     CrashLoopBackOff   121 (99s ago)   22h
kube-system   kube-scheduler-hello            1/1     Running            0               22h
kube-system   weave-net-5hz97                 0/2     CrashLoopBackOff   261 (29s ago)   22h
kube-system   weave-net-p6x7c                 2/2     Running            1 (22h ago)     22h


long@hello:~$ kubectl get all --all-namespaces
NAMESPACE     NAME                                READY   STATUS             RESTARTS          AGE
kube-system   pod/coredns-5dd5756b68-56zsk        1/1     Running            0                 39h
kube-system   pod/coredns-5dd5756b68-m2q88        1/1     Running            0                 39h
kube-system   pod/etcd-hello                      1/1     Running            5                 39h
kube-system   pod/kube-apiserver-hello            1/1     Running            1                 39h
kube-system   pod/kube-controller-manager-hello   1/1     Running            0                 39h
kube-system   pod/kube-proxy-p7hh9                1/1     Running            0                 39h
kube-system   pod/kube-proxy-wzfks                1/1     Running            286 (6m14s ago)   39h
kube-system   pod/kube-scheduler-hello            1/1     Running            0                 39h
kube-system   pod/weave-net-5hz97                 0/2     CrashLoopBackOff   320 (69s ago)     39h
kube-system   pod/weave-net-p6x7c                 2/2     Running            1 (39h ago)       39h

NAMESPACE     NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  39h
kube-system   service/kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   39h

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/kube-proxy   2         2         2       2            2           kubernetes.io/os=linux   39h
kube-system   daemonset.apps/weave-net    2         2         1       2            1           <none>                   39h

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/coredns   2/2     2            2           39h

NAMESPACE     NAME                                 DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/coredns-5dd5756b68   2         2         2       39h

long@hello:~$ kubectl describe pod -n kube-system  kube-proxy-wzfks
Name:                 kube-proxy-wzfks
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Service Account:      kube-proxy
Node:                 vupc/10.208.164.173
Start Time:           Mon, 04 Nov 2024 17:55:28 +0700
Labels:               controller-revision-hash=858b89474b
                      k8s-app=kube-proxy
                      pod-template-generation=1
Annotations:          <none>
Status:               Running
IP:                   10.208.164.173
IPs:
  IP:           10.208.164.173
Controlled By:  DaemonSet/kube-proxy
Containers:
  kube-proxy:
    Container ID:  containerd://b2d849dcff1b6c22b114938a9142beef781fea7ab2dc095fee7515953f7b8bc7
    Image:         registry.k8s.io/kube-proxy:v1.28.15
    Image ID:      registry.k8s.io/kube-proxy@sha256:8e039a309ca0dc220e6d4350f78d96d1c4c76dd7444354a3ea6142a890ae8ae5
    Port:          <none>
    Host Port:     <none>
    Command:
      /usr/local/bin/kube-proxy
      --config=/var/lib/kube-proxy/config.conf
      --hostname-override=$(NODE_NAME)
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    2
      Started:      Wed, 06 Nov 2024 09:02:46 +0700
      Finished:     Wed, 06 Nov 2024 09:04:09 +0700
    Ready:          False
    Restart Count:  287
    Environment:
      NODE_NAME:     (v1:spec.nodeName)
      no_proxy:     127.0.0.1,10.208.164.167
      ftp_proxy:    http://10.208.164.185:9999/
      https_proxy:  http://10.208.164.185:9999/
      http_proxy:   http://10.208.164.185:9999/
    Mounts:
      /lib/modules from lib-modules (ro)
      /run/xtables.lock from xtables-lock (rw)
      /var/lib/kube-proxy from kube-proxy (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-nmjkt (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  kube-proxy:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      kube-proxy
    Optional:  false
  xtables-lock:
    Type:          HostPath (bare host directory volume)
    Path:          /run/xtables.lock
    HostPathType:  FileOrCreate
  lib-modules:
    Type:          HostPath (bare host directory volume)
    Path:          /lib/modules
    HostPathType:  
  kube-api-access-nmjkt:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              kubernetes.io/os=linux
Tolerations:                 op=Exists
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/network-unavailable:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
Events:
  Type     Reason          Age                    From     Message
  ----     ------          ----                   ----     -------
  Normal   Pulled          59m (x4 over 61m)      kubelet  Container image "registry.k8s.io/kube-proxy:v1.28.15" already present on machine
  Normal   Created         59m (x2 over 61m)      kubelet  Created container kube-proxy
  Normal   Started         59m (x2 over 61m)      kubelet  Started container kube-proxy
  Normal   SandboxChanged  58m (x3 over 61m)      kubelet  Pod sandbox changed, it will be killed and re-created.
  Warning  BackOff         6m41s (x200 over 60m)  kubelet  Back-off restarting failed container kube-proxy in pod kube-proxy-wzfks_kube-system(be3f39c6-8188-4c22-9564-99a3c8bbceb0)
  Normal   Killing         32s (x12 over 60m)     kubelet  Stopping container kube-proxy


long@hello:~$ kubectl get events --field-selector involvedObject.name=kube-proxy-wzfks -n kube-system
LAST SEEN   TYPE      REASON           OBJECT                 MESSAGE
60m         Normal    SandboxChanged   pod/kube-proxy-wzfks   Pod sandbox changed, it will be killed and re-created.
2m37s       Normal    Killing          pod/kube-proxy-wzfks   Stopping container kube-proxy
8m46s       Warning   BackOff          pod/kube-proxy-wzfks   Back-off restarting failed container kube-proxy in pod kube-proxy-wzfks_kube-system(be3f39c6-8188-4c22-9564-99a3c8bbceb0)


long@hello:~$ kubectl logs kube-proxy-wzfks  -n kube-system
Error from server: Get "https://10.208.164.173:10250/containerLogs/kube-system/kube-proxy-wzfks/kube-proxy": Forbidden



-> từ pod k call được tới kubelet của đích 

thêm sudo nano /etc/kubernetes/manifests/kube-apiserver.yaml no_proxy vao -> nó tự restart


long@hello:~$ kubectl get configmap -n kube-system
NAME                                                   DATA   AGE
coredns                                                1      42h
extension-apiserver-authentication                     6      42h
kube-apiserver-legacy-service-account-token-tracking   1      42h
kube-proxy                                             2      42h
kube-root-ca.crt                                       1      42h
kubeadm-config                                         1      42h
kubelet-config                                         1      42h
weave-net                                              0      41h

long@hello:~$ kubectl -n kube-system get configmap kubeadm-config -o yaml
apiVersion: v1
data:
  ClusterConfiguration: |
    apiServer:
      extraArgs:
        authorization-mode: Node,RBAC
      timeoutForControlPlane: 4m0s
    apiVersion: kubeadm.k8s.io/v1beta3
    certificatesDir: /etc/kubernetes/pki
    clusterName: kubernetes
    controllerManager: {}
    dns: {}
    etcd:
      local:
        dataDir: /var/lib/etcd
    imageRepository: registry.k8s.io
    kind: ClusterConfiguration
    kubernetesVersion: v1.28.15
    networking:
      dnsDomain: cluster.local
      podSubnet: 10.244.0.0/16
      serviceSubnet: 10.96.0.0/12
    scheduler: {}
kind: ConfigMap
metadata:
  creationTimestamp: "2024-11-04T10:22:30Z"
  name: kubeadm-config
  namespace: kube-system
  resourceVersion: "246"
  uid: d00c1d62-430c-4ec3-95be-d78973654268


long@hello:~$ kubectl set env pod/kube-proxy-sk7sq no_proxy=git.viettelpost.vn,hadoop12,127.0.0.1,10.208.164.167,localhost,10.208.164.173 -n kube-system 
error: failed to patch env update to pod template: Pod "kube-proxy-sk7sq" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`,`spec.initContainers[*].image`,`spec.activeDeadlineSeconds`,`spec.tolerations` (only additions to existing tolerations),`spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)


long@hello:~$ kubectl -n kube-system edit daemonset kube-proxy
daemonset.apps/kube-proxy edited

# khogn thay dc pod 
long@hello:~$ kubectl edit pods/kube-proxy-sk7sq -n kube-system
Error from server (NotFound): pods "kube-proxy-sk7sq" not found

# thay cm thi k co thogn tin env
kubectl edit cm/kube-proxy -n kube-system


sau khi cai waeve + rancher

long@hello:~$ kubectl get all -A -o wide
NAMESPACE             NAME                                        READY   STATUS    RESTARTS   AGE   IP               NODE    NOMINATED NODE   READINESS GATES
cattle-fleet-system   pod/fleet-agent-0                           2/2     Running   0          11h   10.32.0.5        vupc    <none>           <none>
cattle-system         pod/cattle-cluster-agent-7c95bb564b-9bmtv   1/1     Running   0          11h   10.32.0.4        vupc    <none>           <none>
cattle-system         pod/cattle-cluster-agent-7c95bb564b-crpgv   1/1     Running   0          11h   10.32.0.3        vupc    <none>           <none>
cattle-system         pod/rancher-webhook-7d6f65cdc9-d58k6        1/1     Running   0          11h   10.32.0.2        vupc    <none>           <none>
kube-system           pod/coredns-5dd5756b68-cdrn2                1/1     Running   0          15h   10.36.0.2        hello   <none>           <none>
kube-system           pod/coredns-5dd5756b68-xrkjj                1/1     Running   0          15h   10.36.0.1        hello   <none>           <none>
kube-system           pod/etcd-hello                              1/1     Running   6          15h   10.208.164.167   hello   <none>           <none>
kube-system           pod/kube-apiserver-hello                    1/1     Running   0          15h   10.208.164.167   hello   <none>           <none>
kube-system           pod/kube-controller-manager-hello           1/1     Running   0          15h   10.208.164.167   hello   <none>           <none>
kube-system           pod/kube-proxy-pr2sj                        1/1     Running   0          15h   10.208.164.167   hello   <none>           <none>
kube-system           pod/kube-proxy-r9s5g                        1/1     Running   0          14h   10.208.164.173   vupc    <none>           <none>
kube-system           pod/kube-scheduler-hello                    1/1     Running   0          15h   10.208.164.167   hello   <none>           <none>
kube-system           pod/weave-net-mprwk                         2/2     Running   0          14h   10.208.164.167   hello   <none>           <none>
kube-system           pod/weave-net-r6lwg                         2/2     Running   0          14h   10.208.164.173   vupc    <none>           <none>

NAMESPACE             NAME                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
cattle-fleet-system   service/fleet-agent            ClusterIP   None           <none>        <none>                   11h   app=fleet-agent
cattle-system         service/cattle-cluster-agent   ClusterIP   10.111.13.78   <none>        80/TCP,443/TCP           11h   app=cattle-cluster-agent
cattle-system         service/rancher-webhook        ClusterIP   10.104.128.5   <none>        443/TCP                  11h   app=rancher-webhook
default               service/kubernetes             ClusterIP   10.96.0.1      <none>        443/TCP                  15h   <none>
kube-system           service/kube-dns               ClusterIP   10.96.0.10     <none>        53/UDP,53/TCP,9153/TCP   15h   k8s-app=kube-dns

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS        IMAGES                                                     SELECTOR
kube-system   daemonset.apps/kube-proxy   2         2         2       2            2           kubernetes.io/os=linux   15h   kube-proxy        registry.k8s.io/kube-proxy:v1.28.15                        k8s-app=kube-proxy
kube-system   daemonset.apps/weave-net    2         2         2       2            2           <none>                   14h   weave,weave-npc   weaveworks/weave-kube:latest,weaveworks/weave-npc:latest   name=weave-net

NAMESPACE       NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS         IMAGES                                    SELECTOR
cattle-system   deployment.apps/cattle-cluster-agent   2/2     2            2           11h   cluster-register   rancher/rancher-agent:v2.9.3              app=cattle-cluster-agent
cattle-system   deployment.apps/rancher-webhook        1/1     1            1           11h   rancher-webhook    rancher/rancher-webhook:v0.5.3            app=rancher-webhook
kube-system     deployment.apps/coredns                2/2     2            2           15h   coredns            registry.k8s.io/coredns/coredns:v1.10.1   k8s-app=kube-dns

NAMESPACE       NAME                                              DESIRED   CURRENT   READY   AGE   CONTAINERS         IMAGES                                    SELECTOR
cattle-system   replicaset.apps/cattle-cluster-agent-59875c6ff    0         0         0       11h   cluster-register   rancher/rancher-agent:v2.9.3              app=cattle-cluster-agent,pod-template-hash=59875c6ff
cattle-system   replicaset.apps/cattle-cluster-agent-7c95bb564b   2         2         2       11h   cluster-register   rancher/rancher-agent:v2.9.3              app=cattle-cluster-agent,pod-template-hash=7c95bb564b
cattle-system   replicaset.apps/rancher-webhook-7d6f65cdc9        1         1         1       11h   rancher-webhook    rancher/rancher-webhook:v0.5.3            app=rancher-webhook,pod-template-hash=7d6f65cdc9
kube-system     replicaset.apps/coredns-5dd5756b68                2         2         2       15h   coredns            registry.k8s.io/coredns/coredns:v1.10.1   k8s-app=kube-dns,pod-template-hash=5dd5756b68

NAMESPACE             NAME                           READY   AGE   CONTAINERS                              IMAGES
cattle-fleet-system   statefulset.apps/fleet-agent   1/1     11h   fleet-agent,fleet-agent-clusterstatus   rancher/fleet-agent:v0.10.4,rancher/fleet-agent:v0.10.4
