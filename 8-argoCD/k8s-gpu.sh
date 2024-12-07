helm repo add nvidia https://nvidia.github.io/gpu-operator \
   && helm repo update
helm install gpu-operator \
    -n gpu-operator --create-namespace \
    nvidia/gpu-operator \
    --version=v24.9.0 \
    --set driver.enabled=false

(base) admini@5002544:~$ helm list -A
NAME                  	NAMESPACE          	REVISION	UPDATED                                	STATUS  	CHART                                                                                        	APP VERSION
fleet-agent-local-mini	cattle-fleet-system	1       	2024-11-21 09:40:06.206965001 +0000 UTC	deployed	fleet-agent-local-mini-v0.0.0+s-fb08a70a3d3042040ae8c5c15d5cdb4bd39684de27038ff3b13941a046544	           
gpu-operator          	gpu-operator       	1       	2024-11-27 01:55:00.541233538 +0000 UTC	deployed	gpu-operator-v24.9.0                                                                         	v24.9.0    
nginx-ingress         	nginx-ingress      	1       	2024-11-21 10:12:44.636854461 +0000 UTC	deployed	nginx-ingress-0.13.0                                                                         	2.2.0      
rancher-webhook       	cattle-system      	2       	2024-11-21 09:40:33.173724742 +0000 UTC	deployed	rancher-webhook-105.0.0+up0.6.1                                                              	0.6.1  

(base) admini@5002544:~$ helm uninstall gpu-operator
Error: uninstall: Release not loaded: gpu-operator: release: not found
(base) admini@5002544:~$ helm uninstall gpu-operator -n gpu-operator
release "gpu-operator" uninstalled


helm install --wait --generate-name \
    -n gpu-operator --create-namespace \
    nvidia/gpu-operator \
    --version=v24.9.1 \
    --set mig.strategy=mixed \    # nhieu gpu: mỗi gpu chia k đều: ví dụ tỉ lệ 2:1:1 -  single: chia đều: 1:1:1:1
    --set driver.enabled=false       # khong can cai driver nua (neu có nvidia-smi roi chagn chan)      
    
# --set toolkit.enabled=false # khong can cai NVIDIA Container Toolkit (dudo nvidia-ctk runtime configure --runtime=docker)

    
minikube start --driver docker --kubernetes-version=v1.29.0 --listen-address='0.0.0.0' --memory='6000m' --cpus='6' --container-runtime docker --gpus all
minikube start --driver virtualbox --kubernetes-version=v1.29.0 --listen-address='0.0.0.0' --memory='6000m' --cpus='6' --container-runtime containerd

--driver: virtualbox, kvm2, qemu2, qemu, vmware, none, docker, podman, ssh (defaults to auto-detect)
--container-runtime: docker, cri-o, containerd (default: auto)
-g, --gpus='': Allow pods to use your NVIDIA GPUs. Options include: [all,nvidia] (Docker driver with Docker container-runtime only)

kubectl get events --field-selector involvedObject.name=mypod


https://github.com/NNDam/AI-Engineer-Note/blob/master/Deploy/NVIDIA/docs/multi_instance_gpu.md
https://medium.com/bumble-tech/gpu-powered-kubernetes-clusters-7fc6505125c
https://towardsdatascience.com/dynamic-mig-partitioning-in-kubernetes-89db6cdde7a3


thay bao dung k3s cho oke (ma van can 2 node thi phai)
https://viblo.asia/p/cau-hinh-cum-kubernetes-de-su-dung-nvidia-gpu-PwlVmyaEV5Z


(base) admini@5002544:~$ curl -sfL https://get.k3s.io | sh -
[sudo] password for admini: 
[INFO]  Finding release for channel stable
[INFO]  Using v1.30.6+k3s1 as release
[INFO]  Downloading hash https://github.com/k3s-io/k3s/releases/download/v1.30.6+k3s1/sha256sum-amd64.txt
[INFO]  Skipping binary downloaded, installed k3s matches hash
[INFO]  Skipping installation of SELinux RPM
[INFO]  Skipping /usr/local/bin/kubectl symlink to k3s, command exists in PATH at /usr/bin/kubectl
[INFO]  Skipping /usr/local/bin/crictl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
[INFO]  systemd: Starting k3s
root@5002544:~# helm install --wait --generate-name      -n gpu-operator --create-namespace      nvidia/gpu-operator      --set driver.enabled=false --debug
root@5002544:~# kubectl get all -owide -A
NAMESPACE      NAME                                                                  READY   STATUS      RESTARTS   AGE     IP           NODE      NOMINATED NODE   READINESS GATES
gpu-operator   pod/gpu-feature-discovery-bbrfx                                       1/1     Running     0          3m40s   10.42.0.17   5002544   <none>           <none>
gpu-operator   pod/gpu-operator-1733536372-node-feature-discovery-gc-678b9d65m49p4   1/1     Running     0          3m58s   10.42.0.10   5002544   <none>           <none>
gpu-operator   pod/gpu-operator-1733536372-node-feature-discovery-master-55d5kngxf   1/1     Running     0          3m58s   10.42.0.12   5002544   <none>           <none>
gpu-operator   pod/gpu-operator-1733536372-node-feature-discovery-worker-lgmtb       1/1     Running     0          3m58s   10.42.0.9    5002544   <none>           <none>
gpu-operator   pod/gpu-operator-7f845bb85c-dbp5v                                     1/1     Running     0          3m58s   10.42.0.11   5002544   <none>           <none>
gpu-operator   pod/nvidia-container-toolkit-daemonset-w4kkz                          1/1     Running     0          3m40s   10.42.0.13   5002544   <none>           <none>
gpu-operator   pod/nvidia-cuda-validator-q9pd5                                       0/1     Completed   0          3m28s   10.42.0.18   5002544   <none>           <none>
gpu-operator   pod/nvidia-dcgm-exporter-fc5jf                                        1/1     Running     0          3m40s   10.42.0.16   5002544   <none>           <none>
gpu-operator   pod/nvidia-device-plugin-daemonset-p77bh                              1/1     Running     0          3m40s   10.42.0.15   5002544   <none>           <none>
gpu-operator   pod/nvidia-mig-manager-xb8x9                                          1/1     Running     0          2m40s   10.42.0.19   5002544   <none>           <none>
gpu-operator   pod/nvidia-operator-validator-fxkt5                                   1/1     Running     0          3m40s   10.42.0.14   5002544   <none>           <none>
kube-system    pod/coredns-7b98449c4-7h7c9                                           1/1     Running     0          31m     10.42.0.4    5002544   <none>           <none>
kube-system    pod/helm-install-traefik-crd-sjsrk                                    0/1     Completed   0          31m     10.42.0.3    5002544   <none>           <none>
kube-system    pod/helm-install-traefik-fnrjk                                        0/1     Completed   1          31m     10.42.0.6    5002544   <none>           <none>
kube-system    pod/local-path-provisioner-595dcfc56f-wccvd                           1/1     Running     0          31m     10.42.0.2    5002544   <none>           <none>
kube-system    pod/metrics-server-cdcc87586-flsjr                                    1/1     Running     0          31m     10.42.0.5    5002544   <none>           <none>
kube-system    pod/svclb-traefik-3d6b2304-dnf8z                                      2/2     Running     0          31m     10.42.0.7    5002544   <none>           <none>
kube-system    pod/traefik-d7c9c5778-lrsqg                                           1/1     Running     0          31m     10.42.0.8    5002544   <none>           <none>


chu y cac thanh phan sau: 
pod/nvidia-container-toolkit-daemonset-w4kkz
pod/nvidia-mig-manager-xb8x9


root@5002544:~# apt  install jq
root@5002544:~# kubectl get node -o json | jq '.items[].metadata.labels'

"nvidia.com/mig.config": "all-disabled",
"nvidia.com/gpu.product": "NVIDIA-A30"
"nvidia.com/mig.config.state": "success",
"nvidia.com/mig.strategy": "single",

MIG Manager requires that no user workloads are running on the GPUs being configured. 
In some cases, the node may need to be rebooted, such as a CSP, so the node might need to be cordoned before changing the MIG mode or the MIG geometry on the GPUs.

root@5002544:~# kubectl get node
NAME      STATUS   ROLES                  AGE   VERSION
5002544   Ready    control-plane,master   39m   v1.30.6+k3s1
root@5002544:~# kubectl label nodes 5002544 nvidia.com/mig.config=all-1g.10gb --overwrite
node/5002544 labeled

-> 1g.6gb chỉnh lại cái mig này cho phù hợp máy : nvidia-smi mig -lgip
kubectl label nodes 5002544 nvidia.com/mig.config=all-2g.12gb  --overwrite
kubectl label nodes 5002544 nvidia.com/mig.config=all-1g.6gb --overwrite

root@5002544:~# kubectl get node 5002544 -o=jsonpath='{.metadata.labels}' | jq .
"nvidia.com/mig.config": "all-disabled",
-------- chuyển thành
"nvidia.com/mig.config": "all-1g.10gb",


đợi một lát:   "nvidia.com/mig.config.state": "pending",
chú ý là nếu thành công nó sẽ reboot vm thì phải

check lại các thoogn tin nhưu sau là oke 
kubectl get node 5002544 -o=jsonpath='{.metadata.labels}' | jq .

  "nvidia.com/gpu.count": "2",
  "nvidia.com/gpu.slices.ci": "2",
  "nvidia.com/gpu.slices.gi": "2",
 "nvidia.com/mig.config.state": "success",

  "nvidia.com/gpu.product": "NVIDIA-A30-MIG-2g.12gb",   -> node selector, truoc no ten la NVIDIA-A30
  "nvidia.com/gpu.replicas": "1",
  "nvidia.com/mig.capable": "true",
  "nvidia.com/mig.config": "all-2g.12gb",
  "nvidia.com/mig.strategy": "single",
  "nvidia.com/mps.capable": "false",
  "nvidia.com/vgpu.present": "false"

root@5002544:~# nvidia-smi
Sat Dec  7 03:56:31 2024       
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.183.01             Driver Version: 535.183.01   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  NVIDIA A30                     Off | 00000000:0B:00.0 Off |                   On |
| N/A   64C    P0              76W / 165W |     50MiB / 24576MiB |     N/A      Default |
|                                         |                      |              Enabled |
+-----------------------------------------+----------------------+----------------------+

+---------------------------------------------------------------------------------------+
| MIG devices:                                                                          |
+------------------+--------------------------------+-----------+-----------------------+
| GPU  GI  CI  MIG |                   Memory-Usage |        Vol|      Shared           |
|      ID  ID  Dev |                     BAR1-Usage | SM     Unc| CE ENC DEC OFA JPG    |
|                  |                                |        ECC|                       |
|==================+================================+===========+=======================|
|  0    1   0   0  |              25MiB / 11968MiB  | 28      0 |  2   0    2    0    0 |
|                  |               0MiB / 16383MiB  |           |                       |
+------------------+--------------------------------+-----------+-----------------------+
|  0    2   0   1  |              25MiB / 11968MiB  | 28      0 |  2   0    2    0    0 |
|                  |               0MiB / 16383MiB  |           |                       |
+------------------+--------------------------------+-----------+-----------------------+
                                                                                         
+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|  No running processes found                                                           |
+---------------------------------------------------------------------------------------+


link operator: https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/gpu-operator-mig.html
troubleshooting: https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/troubleshooting.html


TEST: https://docs.nvidia.com/datacenter/cloud-native/kubernetes/latest/index.html

for i in $(seq 2); do
   kubectl run \
      --image=nvidia/cuda:11.0-base \
      --restart=Never \
      --limits=nvidia.com/gpu=1 \
      mig-single-example-${i} -- bash -c "nvidia-smi -L; sleep infinity"
done

   kubectl run \
      --image=nvidia/cuda:11.0-base \
      --restart=Never \
      --limits=nvidia.com/gpu=1 \
      mig-single-example-1 -- bash -c "nvidia-smi -L; sleep infinity"

root@5002544:~# vim deploy-mig.yaml
root@5002544:~# kubectl create -f deploy-mig.yaml 
pod/test-11 created
pod/test-22 created
kubectl describe pod test-11


nvidia.com/gpu.product

root@5002544:~# kubectl get all -owide
NAME         READY   STATUS      RESTARTS   AGE     IP            NODE      NOMINATED NODE   READINESS GATES
pod/test-1   0/1     Completed   0          6m48s   10.42.0.115   5002544   <none>           <none>
pod/test-2   0/1     Completed   0          6m48s   10.42.0.116   5002544   <none>           <none>

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE     SELECTOR
service/kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   3h19m   <none>
root@5002544:~# kubectl get -f deploy-mig.yaml -o name | xargs -I{} kubectl logs {}  
GPU 0: NVIDIA A30 (UUID: GPU-e28f423e-c8af-4063-e053-c464cd477fed)
  MIG 2g.12gb     Device  0: (UUID: MIG-19db5564-eef7-53fa-82f2-af838d10fecc)
GPU 0: NVIDIA A30 (UUID: GPU-e28f423e-c8af-4063-e053-c464cd477fed)
  MIG 2g.12gb     Device  0: (UUID: MIG-5effae5b-c755-597e-b5e0-4a91b98edcfe)

root@5002544:~# nvidia-smi -L
GPU 0: NVIDIA A30 (UUID: GPU-e28f423e-c8af-4063-e053-c464cd477fed)
  MIG 2g.12gb     Device  0: (UUID: MIG-19db5564-eef7-53fa-82f2-af838d10fecc)
  MIG 2g.12gb     Device  1: (UUID: MIG-5effae5b-c755-597e-b5e0-4a91b98edcfe)










