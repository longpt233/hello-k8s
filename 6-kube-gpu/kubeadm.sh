https://viblo.asia/p/devops-k8s-phan-2-setup-kubernetes-cluster-Az45bjjO5xY
https://github.com/sontn/kubeadm
https://viblo.asia/p/su-dung-kubeadm-tao-cluster-deploy-pod-network-flannel-eW65Gb79lDO
https://blog.radwell.codes/2022/07/single-node-kubernetes-cluster-via-kubeadm-on-ubuntu-22-04/
https://github.com/hocchudong/ghichep-kubernetes/blob/master/docs/kubernetes-5min/02.Caidat-Kubernetes.md

https://pwittrock.github.io/docs/setup/independent/install-kubeadm/
https://viblo.asia/p/k8s-xay-dung-kubernetes-cluster-bang-cong-cu-kubeadm-tren-virtual-box-38X4ENOAJN2

free -h
# Đầu tiên là tắt swap
sudo swapoff -a
# Sau đó tắt swap mỗi khi khởi động trong /etc/fstab
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

1. cai containerd
# containerd
curl -fLo containerd-1.6.14-linux-amd64.tar.gz \
  https://github.com/containerd/containerd/releases/download/v1.6.14/containerd-1.6.14-linux-amd64.tar.gz
# Extract the binaries
sudo tar Cxzvf /usr/local containerd-1.6.14-linux-amd64.tar.gz
# Install containerd as a service
sudo curl -fsSLo /etc/systemd/system/containerd.service \
  https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo systemctl daemon-reload
sudo systemctl enable --now containerd

Cach 2

sudo apt-get install containerd.io
hinh nhu no da dc cai tu luc noa roi cay

2. cai runc
curl -fsSLo runc.amd64 \
  https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

3. cni container network interface
curl -fLo cni-plugins-linux-amd64-v1.1.1.tgz \
  https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz


4. mo mang
# You need to enable overlay and br_netfilter kernel modules. Additionally, you need to allow iptables see bridged network traffic.

# cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
# overlay
# br_netfilter
# EOF

# sudo modprobe -a overlay br_netfilter

# Mặc định, kernel Linux không cho phép định tuyến các gói IPv4 giữa các giao diện mạng, ngăn cản việc truyền dữ liệu qua lại. 
# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

5. cai kubelet kubeadm kubectl

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
# Add Kubernetes GPG key
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

# https://kubernetes.io/blog/2023/08/15/pkgs-k8s-io-introduction/
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

# Prevent them from being updated automatically
sudo apt-mark hold kubelet kubeadm kubectl


root@vupc:~# kubeadm config images pull
failed to pull image "registry.k8s.io/kube-apiserver:v1.31.2": failed to pull image registry.k8s.io/kube-apiserver:v1.31.2: failed to pull and unpack image "registry.k8s.io/kube-apiserver:v1.31.2": failed to resolve reference "registry.k8s.io/kube-apiserver:v1.31.2": failed to do request: Head "https://registry.k8s.io/v2/kube-apiserver/manifests/v1.31.2": dial tcp 34.96.108.209:443: i/o timeout
To see the stack trace of this error execute with --v=5 or higher


##### mo proxy
https://github.com/kubernetes/kubeadm/issues/182
sudo systemctl set-environment HTTP_PROXY=10.60.117.103:8085
sudo systemctl set-environment HTTPS_PROXY=10.60.117.103:8085
khong can dau 
root@hello:~# cat /etc/environment
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
http_proxy="http://10.208.164.185:9999/"
https_proxy="http://10.208.164.185:9999/"
ftp_proxy="http://10.208.164.185:9999/"
no_proxy=hadoop12,127.0.0.1,10.208.164.167,localhost,10.208.164.173

sudo systemctl restart containerd.service

##### end mo proxy
sudo kubeadm config images pull

export no_proxy=127.0.0.1,10.208.164.167,localhost,10.208.164.173,kubeadmnexportinit && kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.208.164.167

export no_proxy=hadoop12,127.0.0.1,10.208.164.167,localhost,10.208.164.173,kubeadmjoin  && kubeadm join 10.208.164.167:6443 --token av3kif.ell51auabe7k6zaa \
	--discovery-token-ca-cert-hash sha256:32ba89fc377d8da013b34801ca7e2a0587eaedbb6d60543fad18cf1b1d811aeb

--config=/etc/kubernetes/kubeadm-config.yaml

control plane sẽ tự động phân bổ địa chỉ IP trong CIDR chỉ định cho các pod trên mọi node trong cụm cluster. Bạn sẽ cần phải chọn CIDR sao cho không trùng với bất kỳ dải mạng hiện có để tránh xung đột địa chỉ IP


[api-check] The API server is not healthy after 4m0.00103991s                                                                                                                                 
                                                                                                                                                                                              
Unfortunately, an error has occurred:                                                                                                                                                         
        context deadline exceeded                                                                                                                                                             
                                                                                                                                                                                              
This error is likely caused by:                                                                                                                                                               
        - The kubelet is not running                                                                                                                                                          
        - The kubelet is unhealthy due to a misconfiguration of the node in some way (required cgroups disabled)
                                                                                                                                                                                              
If you are on a systemd-powered system, you can try to troubleshoot the error with the following commands:                                                                                    
        - 'systemctl status kubelet'                                                                                                                                                          
        - 'journalctl -xeu kubelet'                                                                                                                                                                                                                                                          
Additionally, a control plane component may have crashed or exited when started by the container runtime.                                                                                     To troubleshoot, list all containers using your preferred container runtimes CLI.                                                                                                             
Here is one example how you may list all running Kubernetes containers by using crictl:                                                                                                       
        - 'crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock ps -a | grep kube | grep -v pause'                                                                            
        Once you have found the failing container, you can inspect its logs with:                                                                                                             
        - 'crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock logs CONTAINERID'                                                                                             
error execution phase wait-control-plane: could not initialize a Kubernetes cluster                                                                                                           
To see the stack trace of this error execute with --v=5 or higher


systemctl status kubelet



kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


# ừa nó log ra console, méo phải stdout nên ko grep được
systemctl status kubelet | grep E > /tmp/log-k8s.log && cat /tmp/log-k8s.log
journalctl -xeu kubelet -n 2 | grep E > /tmp/log-k8s.log && cat /tmp/log-k8s.log




long@hello:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                            READY   STATUS    RESTARTS   AGE
kube-system   coredns-5dd5756b68-56zsk        0/1     Pending   0          32m
kube-system   coredns-5dd5756b68-m2q88        0/1     Pending   0          32m
kube-system   etcd-hello                      1/1     Running   5          33m
kube-system   kube-apiserver-hello            1/1     Running   1          33m
kube-system   kube-controller-manager-hello   1/1     Running   0          33m
kube-system   kube-proxy-p7hh9                1/1     Running   0          32m
kube-system   kube-proxy-wzfks                1/1     Running   0          6s
kube-system   kube-scheduler-hello            1/1     Running   0          33m
long@hello:~$     kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
serviceaccount/weave-net created
clusterrole.rbac.authorization.k8s.io/weave-net created
clusterrolebinding.rbac.authorization.k8s.io/weave-net created
role.rbac.authorization.k8s.io/weave-net created
rolebinding.rbac.authorization.k8s.io/weave-net created
daemonset.apps/weave-net created
long@hello:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                            READY   STATUS    RESTARTS      AGE
kube-system   coredns-5dd5756b68-56zsk        1/1     Running   0             34m
kube-system   coredns-5dd5756b68-m2q88        1/1     Running   0             34m
kube-system   etcd-hello                      1/1     Running   5             34m
kube-system   kube-apiserver-hello            1/1     Running   1             34m
kube-system   kube-controller-manager-hello   1/1     Running   0             34m
kube-system   kube-proxy-p7hh9                1/1     Running   0             34m
kube-system   kube-proxy-wzfks                1/1     Running   2 (20s ago)   106s
kube-system   kube-scheduler-hello            1/1     Running   0             34m
kube-system   weave-net-5hz97                 2/2     Running   1 (35s ago)   47s
kube-system   weave-net-p6x7c                 2/2     Running   1 (31s ago)   47s


kubectl describe pod --all-namespaces