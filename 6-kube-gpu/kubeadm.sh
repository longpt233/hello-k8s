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


sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

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

# runc
curl -fsSLo runc.amd64 \
  https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

# cni container network interface
curl -fLo cni-plugins-linux-amd64-v1.1.1.tgz \
  https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz

# You need to enable overlay and br_netfilter kernel modules. Additionally, you need to allow iptables see bridged network traffic.

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe -a overlay br_netfilter

# Mặc định, kernel Linux không cho phép định tuyến các gói IPv4 giữa các giao diện mạng, ngăn cản việc truyền dữ liệu qua lại. 
# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system


# Add Kubernetes GPG key
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

# Add Kubernetes apt repository
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Fetch package list
sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

# Prevent them from being updated automatically
sudo apt-mark hold kubelet kubeadm kubectl


root@vupc:~# kubeadm config images pull
failed to pull image "registry.k8s.io/kube-apiserver:v1.31.2": failed to pull image registry.k8s.io/kube-apiserver:v1.31.2: failed to pull and unpack image "registry.k8s.io/kube-apiserver:v1.31.2": failed to resolve reference "registry.k8s.io/kube-apiserver:v1.31.2": failed to do request: Head "https://registry.k8s.io/v2/kube-apiserver/manifests/v1.31.2": dial tcp 34.96.108.209:443: i/o timeout
To see the stack trace of this error execute with --v=5 or higher

https://github.com/kubernetes/kubeadm/issues/182

sudo systemctl set-environment HTTP_PROXY=10.60.117.103:8085
sudo systemctl set-environment HTTPS_PROXY=10.60.117.103:8085
sudo systemctl restart containerd.service
sudo kubeadm config images pull


sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.208.164.173


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



kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
