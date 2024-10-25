


```
root@k8s-node1:~# ps aux | grep kube
root      7211  0.1  2.0 753720 41140 ?        Ssl  09:57   0:03 /usr/local/bin/kube-proxy --config=/var/lib/kube-proxy/config.conf --hostname-override=k8s-node1
root       544  1.5  4.9 1875956 99912 ?       Ssl  09:52   0:59 /usr/local/bin/kubelet --logtostderr=true --v=2 --node-ip=192.168.56.21 --hostname-override=k8s-node1 --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --config=/etc/kubernetes/kubelet-config.yaml --kubeconfig=/etc/kubernetes/kubelet.conf --container-runtime=remote --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock --runtime-cgroups=/kube.slice/containerd.service

```

```
root@k8s-master1:~# ps aux | grep kube
root      8420  2.2  3.9 1949944 80396 ?       Ssl  09:52   1:28 /usr/local/bin/kubelet --logtostderr=true --v=2 --node-ip=192.168.56.11 --hostname-override=k8s-master1 --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --config=/etc/kubernetes/kubelet-config.yaml --kubeconfig=/etc/kubernetes/kubelet.conf --container-runtime=remote --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock --runtime-cgroups=/kube.slice/containerd.service
root      8846  4.0 18.7 1251316 383344 ?      Ssl  09:52   2:41 kube-apiserver --advertise-address=192.168.56.11 --allow-privileged=true --anonymous-auth=True --apiserver-count=3 --authorization-mode=Node,RBAC --bind-address=0.0.0.0 --client-ca-file=/etc/kubernetes/ssl/ca.crt --default-not-ready-toleration-seconds=300 --default-unreachable-toleration-seconds=300 --enable-admission-plugins=NodeRestriction --enable-aggregator-routing=False --enable-bootstrap-token-auth=true --endpoint-reconciler-type=lease --etcd-cafile=/etc/ssl/etcd/ssl/ca.pem --etcd-certfile=/etc/ssl/etcd/ssl/node-k8s-master1.pem --etcd-keyfile=/etc/ssl/etcd/ssl/node-k8s-master1-key.pem --etcd-servers=https://192.168.56.11:2379,https://192.168.56.12:2379,https://192.168.56.13:2379 --event-ttl=1h0m0s --kubelet-client-certificate=/etc/kubernetes/ssl/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/ssl/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalDNS,InternalIP,Hostname,ExternalDNS,ExternalIP --profiling=False --proxy-client-cert-file=/etc/kubernetes/ssl/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/ssl/front-proxy-client.key --request-timeout=1m0s --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/ssl/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/ssl/sa.pub --service-account-lookup=True --service-account-signing-key-file=/etc/kubernetes/ssl/sa.key --service-cluster-ip-range=10.233.0.0/18 --service-node-port-range=30000-32767 --storage-backend=etcd3 --tls-cert-file=/etc/kubernetes/ssl/apiserver.crt --tls-private-key-file=/etc/kubernetes/ssl/apiserver.key
root     18931  0.0  1.9 753976 39780 ?        Ssl  09:56   0:03 /usr/local/bin/kube-proxy --config=/var/lib/kube-proxy/config.conf --hostname-override=k8s-master1
root     21253  0.0  0.0  14860  1028 pts/0    S+   10:58   0:00 grep --color=auto kube
root     29974  0.4  1.6 759900 34640 ?        Ssl  09:38   0:19 kube-scheduler --authentication-kubeconfig=/etc/kubernetes/scheduler.conf --authorization-kubeconfig=/etc/kubernetes/scheduler.conf --bind-address=0.0.0.0 --config=/etc/kubernetes/kubescheduler-config.yaml --kubeconfig=/etc/kubernetes/scheduler.conf --leader-elect=true
root     30052  1.5  3.6 826116 75112 ?        Ssl  09:38   1:12 kube-controller-manager --allocate-node-cidrs=true --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf --bind-address=0.0.0.0 --client-ca-file=/etc/kubernetes/ssl/ca.crt --cluster-cidr=10.233.64.0/18 --cluster-name=cluster.local --cluster-signing-cert-file=/etc/kubernetes/ssl/ca.crt --cluster-signing-key-file=/etc/kubernetes/ssl/ca.key --configure-cloud-routes=false --controllers=*,bootstrapsigner,tokencleaner --kubeconfig=/etc/kubernetes/controller-manager.conf --leader-elect=true --leader-elect-lease-duration=15s --leader-elect-renew-deadline=10s --node-cidr-mask-size=24 --node-monitor-grace-period=40s --node-monitor-period=5s --profiling=False --requestheader-client-ca-file=/etc/kubernetes/ssl/front-proxy-ca.crt --root-ca-file=/etc/kubernetes/ssl/ca.crt --service-account-private-key-file=/etc/kubernetes/ssl/sa.key --service-cluster-ip-range=10.233.0.0/18 --terminated-pod-gc-threshold=12500 --use-service-account-credentials=true

```

```
root     26420  3.8  4.7 11284032 96972 ?      Ssl  09:36   5:57 /usr/local/bin/etcd
```

```
root@k8s-master1:~# cat /etc/kubernetes/kubelet.conf 
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJME1UQXlOVEF5TXpjeU1Wb1hEVE0wTVRBeU16QXlNemN5TVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTWl0CkIvN2NTaHgzQS9kNmxqNGdrb2ZiWGFkcmhLS3lkdnN3K0dsQmZkVlhYeFlKWVdZc3N0RU52QUdqUzB4c1VMYUcKZEtrZDFPZ0ZzU3FGL1ZFZ1NUdzY1b2ljd01qN1hJWlBGVmJES0orZys2bVRkNU14UTJSWWpEWDNpWjhLNUJ4NQo1VkZjZHdSNGtYakVTSm9aeHljNG5NVnQ3bER1VVllYkU2eU5jRkNuaGhTZ1hsSXZ2YnpJUEJmcnl1c3B3QzI3CmFvWEtDSzJKb2RMVUJ5M1VVYm9aL1lWUmk2RWlHZktVRllpbXJHUUlRYXU5dWVDalljL2tDeHBPcEpQSHJZMlkKVm5DUTBzdTlOa0lpV0h4T0FMTWFYakRTZ3Q0cTNYYnM4T1RVTkdkZXpLcUMveHJZNkFwMVdUbmg2YU41eWpTbQpJRXQ1dXNlSXJzMDBDK3NxYmlzQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZEeVhMMWlCMWZ1Zzg3UTh4T3JBZnk1K0IxODRNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBRlRCVHV4RWNraFRlSXdJb2lvSgpFYUEyTUNzMHhTUzE3MXRKVnNSSHk5MUpnOWNPSUJrd0pjQVBRWWhzTnNnWXRLVlcwdFltTEhDOVhzVW85MjdECkRmbFNSTnhISE0yZ2ZIYUd2aFNsZTVQb0FUMDZBSFFXR1lLYXBuamhGQW1hTHFuaEo5Q3NUMG4vK05CUUZxcFAKZ2hHUWlGOEJEcVZRa3A5ZUJtVlVDT0V2MUpmb0JNRzFsQW1TQ0tDSTNPci85MHJzNTJzM21FU0NhMXJaOGhveQp5T2ZhNytsektEVzR3WVVaR0o4Uys1WjZ5TFdZV0w4SFVmV3VrRG9YTGpBdVBhRUQyMENMeUgxV093OHVGM1g1ClNrNEw3dFN3R1kwa3ZHVWZFQkdKM2xhQkpXVlRzY0FYV0tFQTNMWkl6TERxVnI5ZTBickpNdkpFaFdUVWZJUjUKRjkwPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://127.0.0.1:6443
  name: cluster.local
contexts:
- context:
    cluster: cluster.local
    user: system:node:k8s-master1
  name: system:node:k8s-master1@cluster.local
current-context: system:node:k8s-master1@cluster.local
kind: Config
preferences: {}
users:
- name: system:node:k8s-master1
  user:
    client-certificate: /var/lib/kubelet/pki/kubelet-client-current.pem
    client-key: /var/lib/kubelet/pki/kubelet-client-current.pem

```


```
root@k8s-kubespray:~# tree /root/kubespray/inventory/long-cluster/
/root/kubespray/inventory/long-cluster/
├── credentials
│   └── kubeadm_certificate_key.creds
├── group_vars
│   ├── all
│   │   ├── all.yml
│   │   ├── aws.yml
│   │   ├── azure.yml
│   │   ├── containerd.yml
│   │   ├── coreos.yml
│   │   ├── cri-o.yml
│   │   ├── docker.yml
│   │   ├── etcd.yml
│   │   ├── gcp.yml
│   │   ├── hcloud.yml
│   │   ├── oci.yml
│   │   ├── offline.yml
│   │   ├── openstack.yml
│   │   ├── upcloud.yml
│   │   └── vsphere.yml
│   ├── etcd.yml
│   └── k8s_cluster
│       ├── addons.yml
│       ├── k8s-cluster.yml
│       ├── k8s-net-calico.yml
│       ├── k8s-net-canal.yml
│       ├── k8s-net-cilium.yml
│       ├── k8s-net-flannel.yml
│       ├── k8s-net-kube-ovn.yml
│       ├── k8s-net-kube-router.yml
│       ├── k8s-net-macvlan.yml
│       └── k8s-net-weave.yml
├── inventory.ini
└── patches
    ├── kube-controller-manager+merge.yaml
    └── kube-scheduler+merge.yaml

5 directories, 30 files


```