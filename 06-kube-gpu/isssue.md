1. 

failed-to-run-kubelet-validate-service-connection-cri-v1-runtime-api-is-not-im

FATA[0000] listing containers failed: rpc error: code = Unimplemented desc = unknown service runtime.v1alpha2.RuntimeService

sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

sudo nano /etc/containerd/config.toml set SystemdCgroup = true
sudo systemctl restart containerd


root@hello:~# kubeadm config images pull --kubernetes-version=1.28.0 --v=5
I1101 18:50:43.619872  235970 initconfiguration.go:117] detected and using CRI socket: unix:///var/run/containerd/containerd.sock
I1101 18:50:43.620000  235970 interface.go:432] Looking for default routes with IPv4 addresses
I1101 18:50:43.620008  235970 interface.go:437] Default route transits interface "enp3s0"
I1101 18:50:43.620169  235970 interface.go:209] Interface enp3s0 is up
I1101 18:50:43.620210  235970 interface.go:257] Interface "enp3s0" has 1 addresses :[10.208.164.167/22].
I1101 18:50:43.620221  235970 interface.go:224] Checking addr  10.208.164.167/22.
I1101 18:50:43.620230  235970 interface.go:231] IP found 10.208.164.167
I1101 18:50:43.620244  235970 interface.go:263] Found valid IPv4 address 10.208.164.167 for interface "enp3s0".
I1101 18:50:43.620252  235970 interface.go:443] Found active IP 10.208.164.167 
I1101 18:50:43.620277  235970 kubelet.go:196] the value of KubeletConfiguration.cgroupDriver is empty; setting it to "systemd"
[config/images] Pulled registry.k8s.io/kube-apiserver:v1.28.0
[config/images] Pulled registry.k8s.io/kube-controller-manager:v1.28.0
[config/images] Pulled registry.k8s.io/kube-scheduler:v1.28.0
[config/images] Pulled registry.k8s.io/kube-proxy:v1.28.0
[config/images] Pulled registry.k8s.io/pause:3.9
[config/images] Pulled registry.k8s.io/etcd:3.5.15-0
[config/images] Pulled registry.k8s.io/coredns/coredns:v1.10.1


may pod chay ben may kia cung bi loi crash lien tuc ma khong bao loi ro rang -> cx can fix nhu nay (add host ben may woker cx khong an thua)

[kube-proxy](https://stackoverflow.com/questions/75935431/kube-proxy-and-kube-flannel-crashloopbackoff)

https://serverfault.com/questions/1117961/pods-from-kube-system-crashloopbackoff

2. /proc/sys/net/bridge/bridge-nf-call-iptables 

root@hello:~# kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.208.164.173
I1104 16:52:39.935839 2876932 version.go:256] remote version is much newer: v1.31.2; falling back to: stable-1.28
[init] Using Kubernetes version: v1.28.15
[preflight] Running pre-flight checks
	[WARNING HTTPProxy]: Connection to "https://10.208.164.173" uses proxy "http://10.208.164.185:9999/". If that is not intended, adjust your proxy settings
	[WARNING HTTPProxyCIDR]: connection to "10.96.0.0/12" uses proxy "http://10.208.164.185:9999/". This may lead to malfunctional cluster setup. Make sure that Pod and Services IP ranges specified correctly as exceptions in proxy configuration
	[WARNING HTTPProxyCIDR]: connection to "10.244.0.0/16" uses proxy "http://10.208.164.185:9999/". This may lead to malfunctional cluster setup. Make sure that Pod and Services IP ranges specified correctly as exceptions in proxy configuration
error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
To see the stack trace of this error execute with --v=5 or higher
root@hello:~# echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
-bash: /proc/sys/net/bridge/bridge-nf-call-iptables: No such file or directory
root@hello:~# ls -la /proc/sys/net/
core/             ipv4/             ipv6/             mptcp/            netfilter/        nf_conntrack_max  unix/             
root@hello:~# modprobe -a overlay br_netfilter
root@hello:~# echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
root@hello:~# 


3. cni plugin not initialized

Nov 04 17:10:38 hello kubelet[2889161]: E1104 17:10:38.583368 2889161 kubelet.go:2874] "Container runtime network not ready" networkReady="NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized"


curl -fLo cni-plugins-linux-amd64-v1.1.1.tgz \
  https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

-> eo lien quan, set no proxy la dc

export no_proxy=127.0.0.1,10.208.164.167 && kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.208.164.167

4. 



[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
error execution phase preflight: unable to fetch the kubeadm-config ConfigMap: this version of kubeadm only supports deploying clusters with the control plane version >= 1.30.0. Current version: v1.28.15

-> remove cai cu tren woker di roi cai lai

5.  ImagePullBackOff worker


long@hello:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                            READY   STATUS             RESTARTS   AGE
kube-system   coredns-5dd5756b68-56zsk        0/1     Pending            0          21m
kube-system   coredns-5dd5756b68-m2q88        0/1     Pending            0          21m
kube-system   etcd-hello                      1/1     Running            5          21m
kube-system   kube-apiserver-hello            1/1     Running            1          21m
kube-system   kube-controller-manager-hello   1/1     Running            0          21m
kube-system   kube-proxy-8hs49                0/1     ImagePullBackOff   0          8m27s
kube-system   kube-proxy-p7hh9                1/1     Running            0          21m
kube-system   kube-scheduler-hello            1/1     Running            0          21m

long@hello:~$ cat /etc/systemd/system/docker.service.d/http-proxy.conf 
[Service]
Environment="HTTP_PROXY=http://10.60.117.103:8085/"
Environment="HTTPS_PROXY=http://10.60.117.103:8085/"

root@vupc:~# mkdir -p /etc/systemd/system/containerd.service.d
root@vupc:~# nano /etc/systemd/system/containerd.service.d/http-proxy.conf
root@vupc:~# sudo systemctl daemon-reload
root@vupc:~# sudo systemctl restart containerd
root@vupc:~# sudo systemctl show --property=Environment containerd
Environment=HTTP_PROXY=http://10.60.117.103:8085/ HTTPS_PROXY=http://10.60.117.103:8085/


long@hello:~$ kubectl delete pod --namespace=kube-system kube-proxy-8hs49
pod "kube-proxy-8hs49" deleted


6. khong xoa dc calico 

 2199  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/tigera-operator.yaml
 2200  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/custom-resources.yaml
 2201  kubectl delete -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/custom-resources.yaml
 2202  kubectl delete -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/tigera-operator.yaml


khogn hieu sao bao loi port 6784 cua wave

Thg 11 06 17:10:47 vupc kubelet[793002]: E1106 17:10:47.609207  793002 kubelet.go:2009] failed to "KillPodSandbox" for "a186f989-a5df-4359-8f56-d306ac874a8b" with KillPodSandboxError: "rpc error: code = Unknown desc = failed to destroy network for sandbox \"2fbbcef213b718e5d87922b787de72f4d0db4aaa7ffa801c5016c7927537b604\": plugin type=\"weave-net\" name=\"weave\" failed (delete): Delete \"http://127.0.0.1:6784/ip/2fbbcef213b718e5d87922b787de72f4d0db4aaa7ffa801c5016c7927537b604\": dial tcp 127.0.0.1:6784: connect: connection refused"
Thg 11 06 17:10:47 vupc kubelet[793002]: E1106 17:10:47.609220  793002 pod_workers.go:1300] "Error syncing pod, skipping" err="failed to \"KillPodSandbox\" for \"a186f989-a5df-4359-8f56-d306ac874a8b\" with KillPodSandboxError: \"rpc error: code = Unknown desc = failed to destroy network for sandbox \\\"2fbbcef213b718e5d87922b787de72f4d0db4aaa7ffa801c5016c7927537b604\\\": plugin type=\\\"weave-net\\\" name=\\\"weave\\\" failed (delete): Delete \\\"http://127.0.0.1:6784/ip/2fbbcef213b718e5d87922b787de72f4d0db4aaa7ffa801c5016c7927537b604\\\": dial tcp 127.0.0.1:6784: connect: connection refused\"" pod="calico-apiserver/calico-apiserver-7fcbc99644-mrm2g" podUID="a186f989-a5df-4359-8f56-d306ac874a8b"


-> apply lai weave thi lai dc 
2203  kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
