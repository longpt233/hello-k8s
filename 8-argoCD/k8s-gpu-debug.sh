
1. k8s  unracaple k3s.-> helm khogon tìm dc config k8s

root@5002544:~# helm install --wait --generate-name \
     -n gpu-operator --create-namespace \
     nvidia/gpu-operator \
     --set driver.enabled=false
Error: INSTALLATION FAILED: Kubernetes cluster unreachable: Get "http://localhost:8080/version": dial tcp 127.0.0.1:8080: connect: connection refused
root@5002544:~# helm install --wait --generate-name      -n gpu-operator --create-namespace      nvidia/gpu-operator      --set driver.enabled=false --debug
install.go:224: 2024-12-07 01:52:23.488115504 +0000 UTC m=+0.042725651 [debug] Original chart version: ""
install.go:241: 2024-12-07 01:52:24.137367579 +0000 UTC m=+0.691977802 [debug] CHART PATH: /root/.cache/helm/repository/gpu-operator-v24.9.1.tgz

Error: INSTALLATION FAILED: Kubernetes cluster unreachable: Get "http://localhost:8080/version": dial tcp 127.0.0.1:8080: connect: connection refused
helm.go:86: 2024-12-07 01:52:24.148357488 +0000 UTC m=+0.702967701 [debug] Get "http://localhost:8080/version": dial tcp 127.0.0.1:8080: connect: connection refused
Kubernetes cluster unreachable

-> root@5002544:~# export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

2. no file /usr/local/bin thì tọa thêm thôi 

mkdir /usr/local/bin

3. loi install helm khogn dc mac du tren cai kubectl cua rancher chay bthg -> chắc do phiên bản gì đó, cài lại thôi
admini@5002544:~$ helm install gpu-operator \
    -n gpu-operator --create-namespace \
    nvidia/gpu-operator \
    --version=v24.9.0 \
    --set driver.enabled=false
Error: INSTALLATION FAILED: template: gpu-operator/templates/clusterpolicy.yaml:514:53: executing "gpu-operator/templates/clusterpolicy.yaml" at <.Values.dcgmExporter.config.name>: nil pointer evaluating interface {}.name

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

4. loi khi chay voi driver none bao thieu thu viện -> thì cài thêm thôi

https://minikube.sigs.k8s.io/docs/tutorials/nvidia/

admini@5002544:~$ minikube start --driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost
😄  minikube v1.34.0 on Ubuntu 22.04
✨  Using the none driver based on user configuration

❌  Exiting due to GUEST_MISSING_CONNTRACK: Sorry, Kubernetes 1.31.0 requires conntrack to be installed in root's path
admini@5002544:~$ sudo apt-get install -y conntrack

admini@5002544:~$ wget https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.26.0/crictl-v1.26.0-linux-amd64.tar.gz
admini@5002544:~$ sudo tar zxvf crictl-v1.26.0-linux-amd64.tar.gz -C /usr/local/bin
admini@5002544:~$ minikube start --driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost  --kubernetes-version=v1.29.0
😄  minikube v1.34.0 on Ubuntu 22.04
✨  Using the none driver based on user configuration
👍  Starting "minikube" primary control-plane node in "minikube" cluster
🤹  Running on localhost (CPUs=16, Memory=32057MB, Disk=501807MB) ...

🐳  Exiting due to NOT_FOUND_CRI_DOCKERD: 

💡  Suggestion: 

    The none driver with Kubernetes v1.24+ and the docker container-runtime requires cri-dockerd.
    
    Please install cri-dockerd using these instructions:
    
    https://github.com/Mirantis/cri-dockerd


5. nếu k là single khi get stangtegy 

root@5002544:~# kubectl get node -o json | jq '.items[].metadata.labels'
"nvidia.com/mig.strategy": "single",

kubectl patch clusterpolicies.nvidia.com/cluster-policy \
    --type='json' \
    -p='[{"op":"replace", "path":"/spec/mig/strategy", "value":"single"}]'

6. fail   "nvidia.com/mig.config.state": "failed",

kubectl logs -n gpu-operator -l app=nvidia-mig-manager -c nvidia-mig-manager

root@5002544:~# kubectl logs -n gpu-operator -l app=nvidia-mig-manager -c nvidia-mig-manager
time="2024-12-07T02:19:30Z" level=error msg="\nThe following GPUs could not be reset:\n  GPU 00000000:0B:00.0: In use by another client\n\n1 device is currently being used by one or more other processes (e.g., Fabric Manager, CUDA application, graphics application such as an X server, or a monitoring application such as another instance of nvidia-smi). Please first kill all processes using this device and all compute applications running in the system.\n"
time="2024-12-07T02:19:30Z" level=debug msg="Running apply-exit hook"
time="2024-12-07T02:19:30Z" level=fatal msg="Error applying MIG configuration with hooks: error resetting all GPUs: exit status 255"
Restarting any GPU clients previously shutdown on the host by restarting their systemd services
Restarting any GPU clients previously shutdown in Kubernetes by reenabling their component-specific nodeSelector labels
node/5002544 labeled
Changing the 'nvidia.com/mig.config.state' node label to 'failed'
node/5002544 labeled
time="2024-12-07T02:19:31Z" level=error msg="Error: exit status 1"
time="2024-12-07T02:19:31Z" level=info msg="Waiting for change to 'nvidia.com/mig.config' label"

root@5002544:~# sudo fuser -v /dev/nvidia0
                     USER        PID ACCESS COMMAND
/dev/nvidia0:        root      88449 F.... dcgm-exporter
                     root      88508 F.... nvidia-device-p
                     admini    1625300 F.... nvitop
                     admini    1733506 F.... nvitop
                     admini    1907987 F.... nvitop
root@5002544:~# kill -9 1625300 1733506 1907987 88449  88508

kill di no tu bat lai hic ? how? 
root@5002544:~# kubectl get all -owide -n gpu-operator
NAME                                                                  READY   STATUS    RESTARTS   AGE     IP           NODE      NOMINATED NODE   READINESS GATES
pod/gpu-feature-discovery-m4mt5                                       1/1     Running   0          3m42s   10.42.0.36   5002544   <none>           <none>
pod/nvidia-dcgm-exporter-q4hjz                                        1/1     Running   0          3m42s   10.42.0.34   5002544   <none>           <none>
pod/nvidia-device-plugin-daemonset-fzw9g                              1/1     Running   0          3m42s   10.42.0.35   5002544   <none>           <none>

-> phải chạy thêm với REBOOT.

helm install --wait --generate-name -n gpu-operator --create-namespace nvidia/gpu-operator --set driver.enabled=false --set migManager.env[0].name=WITH_REBOOT --set-string migManager.env[0].value=true

kubectl get all -owide -n gpu-operator


7.  nvidia-device-plugin crash
(base) admini@5002544:~$ kubectl get pods -owide -n gpu-operator
NAME                                                         READY   STATUS             RESTARTS       AGE     IP            NODE       NOMINATED NODE   READINESS GATES
gpu-feature-discovery-ckssr                                  0/1     CrashLoopBackOff   5 (103s ago)   5m30s   10.244.0.66   minikube   <none>           <none>
gpu-operator-5b6b99f58-zbk66                                 1/1     Running            0              6m6s    10.244.0.59   minikube   <none>           <none>
gpu-operator-node-feature-discovery-gc-75ddf784b-xjwwh       1/1     Running            0              6m6s    10.244.0.61   minikube   <none>           <none>
gpu-operator-node-feature-discovery-master-f8c54b974-62vsg   1/1     Running            0              6m6s    10.244.0.60   minikube   <none>           <none>
gpu-operator-node-feature-discovery-worker-5724f             1/1     Running            0              6m6s    10.244.0.58   minikube   <none>           <none>
nvidia-container-toolkit-daemonset-s2bl4                     1/1     Running            0              5m24s   10.244.0.67   minikube   <none>           <none>
nvidia-cuda-validator-mxjbh                                  0/1     Completed          0              5m21s   10.244.0.68   minikube   <none>           <none>
nvidia-dcgm-exporter-drqh7                                   1/1     Running            0              5m30s   10.244.0.65   minikube   <none>           <none>
nvidia-device-plugin-daemonset-s48d4                         0/1     CrashLoopBackOff   5 (118s ago)   5m30s   10.244.0.64   minikube   <none>           <none>
nvidia-operator-validator-9sppd                              1/1     Running            0              5m30s   10.244.0.63   minikube   <none>           <none>

admini@5002544:~$ kubectl describe pod  nvidia-device-plugin-daemonset-bstnr  -n gpu-operator
Warning  Failed     14s (x3 over 42s)  kubelet            Error: failed to start container "nvidia-device-plugin": 
Error response from daemon: failed to create task for container: failed to create shim task: 
OCI runtime create failed: runc create failed: unable to start container process: 
error during container init: error running hook 
#0: error running hook: exit status 1, stdout: , 
stderr: nvidia-container-cli.real: mount error: stat failed: /proc/driver/nvidia/capabilities: no such file or directory: unknown


hoặc check kubectl logs -n gpu-operator -l app=nvidia-mig-manager -c nvidia-mig-manager


-> chuyển sng cài bằng k3s

8. nvidia-container-toolkit-daemonset-j9gsn  crash loop

root@5002544:~# kubectl get pods -owide -n gpu-operator
NAME                                                              READY   STATUS             RESTARTS      AGE     IP           NODE      NOMINATED NODE   READINESS GATES
gpu-feature-discovery-jbg2k                                       1/1     Running            0             41m     10.42.0.50   5002544   <none>           <none>
gpu-operator-1733539736-node-feature-discovery-gc-9b4684bbsxccj   1/1     Running            0             42m     10.42.0.39   5002544   <none>           <none>
gpu-operator-1733539736-node-feature-discovery-master-869796ktd   1/1     Running            0             42m     10.42.0.41   5002544   <none>           <none>
gpu-operator-1733539736-node-feature-discovery-worker-d5c6q       1/1     Running            0             42m     10.42.0.38   5002544   <none>           <none>
gpu-operator-696f79947d-kwphp                                     1/1     Running            0             42m     10.42.0.40   5002544   <none>           <none>
nvidia-container-toolkit-daemonset-j9gsn                          0/1     CrashLoopBackOff   4 (30s ago)   4m30s   10.42.0.54   5002544   <none>           <none>

nvidia-cuda-validator-4wmfc                                       0/1     Completed          0             41m     10.42.0.53   5002544   <none>           <none>
nvidia-dcgm-exporter-t9d6r                                        1/1     Running            0             41m     10.42.0.52   5002544   <none>           <none>
nvidia-device-plugin-daemonset-jchcc                              1/1     Running            0             41m     10.42.0.51   5002544   <none>           <none>
nvidia-mig-manager-gppxd                                          1/1     Running            0             41m     10.42.0.47   5002544   <none>           <none>
nvidia-operator-validator-m4kcq                                   1/1     Running            0             41m     10.42.0.49   5002544   <none>           <none>

root@5002544:~# kubectl logs pod nvidia-container-toolkit-daemonset-j9gsn   -n gpu-operator
error: error from server (NotFound): pods "pod" not found in namespace "gpu-operator"
root@5002544:~# kubectl logs pod/nvidia-container-toolkit-daemonset-j9gsn   -n gpu-operator
time="2024-12-07T03:35:49Z" level=error msg="error running nvidia-toolkit: unable to setup runtime: unable to restart containerd: unable to dial: dial unix /runtime/sock-dir/containerd.sock: connect: connection refused"


helm install --wait --generate-name -n gpu-operator \
 --create-namespace nvidia/gpu-operator \
  --set driver.enabled=false --set migManager.env[0].name=WITH_REBOOT \
  --set-string migManager.env[0].value=true \
--set toolkit.enabled=false

root@5002544:~# kubectl get pods -owide -n gpu-operator
NAME                                                              READY   STATUS      RESTARTS   AGE   IP           NODE      NOMINATED NODE   READINESS GATES
gpu-feature-discovery-2bz9r                                       1/1     Running     0          12s   10.42.0.87   5002544   <none>           <none>
gpu-operator-1733542989-node-feature-discovery-gc-7758f84bfvxjb   1/1     Running     0          31s   10.42.0.81   5002544   <none>           <none>
gpu-operator-1733542989-node-feature-discovery-master-ffd5wdnzp   1/1     Running     0          31s   10.42.0.80   5002544   <none>           <none>
gpu-operator-1733542989-node-feature-discovery-worker-rwzdw       1/1     Running     0          31s   10.42.0.82   5002544   <none>           <none>
gpu-operator-69544cb756-c2flw                                     1/1     Running     0          31s   10.42.0.83   5002544   <none>           <none>

nvidia-cuda-validator-wwv4s                                       0/1     Completed   0          10s   10.42.0.89   5002544   <none>           <none>
nvidia-dcgm-exporter-gwhwq                                        1/1     Running     0          12s   10.42.0.86   5002544   <none>           <none>
nvidia-device-plugin-daemonset-mx86h                              1/1     Running     0          12s   10.42.0.85   5002544   <none>           <none>
nvidia-mig-manager-jlhmv                                          1/1     Running     0          12s   10.42.0.88   5002544   <none>           <none>
nvidia-operator-validator-mwpxz                                   1/1     Running     0          12s   10.42.0.84   5002544   <none>           <none>

-> k chay nvidia-container-toolkit-daemonset-j9gsn  nua 

9. check runtime
cat /etc/containerd/config.toml

version = 2
[plugins]
  [plugins."io.containerd.grpc.v1.cri"]
    [plugins."io.containerd.grpc.v1.cri".containerd]
      default_runtime_name = "nvidia"

      [plugins."io.containerd.grpc.v1.cri".containerd.runtimes]
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia]
          privileged_without_host_devices = false
          runtime_engine = ""
          runtime_root = ""
          runtime_type = "io.containerd.runc.v2"
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia.options]
            BinaryName = "/usr/bin/nvidia-container-runtime"


/usr/local/nvidia/toolkit/nvidia-container-runtime




