# Init cluster k8s 
- centos 

# How to run master

- go vagrantfile/master : ```vagrant up```
- config cluster :chay lenh nay o master trong do ```--apiserver-advertise-address``` la dia chi api-server(master) 
```
kubeadm init --apiserver-advertise-address=172.16.10.100 --pod-network-cidr=192.168.0.0/16
```

- ```kubeadm``` là trình quản lí cho cluster k8s

- ```--pod-network-cidr``` cau hinh mang cho cluster (co nhieu cach https://kubernetes.io/docs/concepts/cluster-administration/addons/ - o day chon **calico** )

- result

```
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.16.10.100:6443 --token 0t9z6b.ylaf6q13ucce1mqi \
        --discovery-token-ca-cert-hash sha256:1edb7b4c802192f7511c091c9136a34bfe3df5052c956ea41266b898efa23ef8
```

- chay 3 lenh theo yeu cau(nho phai du dung quyen root). Trong do, chay lenh ```sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config```  de giup **kubectl** connect dc toi master node nay 

- cuoi cung, addon network cho cluster ```kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml```

- ket qua 

```
[root@master vagrant]# kubectl get pod -A
NAMESPACE     NAME                                       READY   STATUS             ... 
kube-system   calico-kube-controllers-57b8db5f9c-74vp7   0/1     ContainerCreating   
kube-system   calico-node-pkpb9                          0/1     Init:2/3            
kube-system   coredns-64897985d-8h8p4                    0/1     ContainerCreating  
kube-system   coredns-64897985d-pv5k6                    0/1     ContainerCreating   
kube-system   etcd-master.xtl                            1/1     Running            
kube-system   kube-apiserver-master.xtl                  1/1     Running             
kube-system   kube-controller-manager-master.xtl         1/1     Running            
kube-system   kube-proxy-fk5xr                           1/1     Running            
kube-system   kube-scheduler-master.xtl                  1/1     Running             
```

# Run cluster

- ```kubectl``` la mot CLI tuong tac, tuc la no co the chay o mot may khong docker, khong k8s. 

- Khi thi hành kubectl, thì nó đọc file cấu hình ở đường dẫn ```$HOME/.kube/config``` để biết các thông số để kết nối đến Cluster. ($HOME là thư mục gốc dành cho user đang chạy, để biết chính xác gõ lệnh echo $HOME) - tài khoản root thì đó là /root/.kube/config

- để biết đang ở context nào :```kubectl config get-contexts``` 

- để lấy thông tin context hiệt tại ```kubectl config view``` 

```json
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://172.16.10.100:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
```

- trong node 1, node 2 thì ta chỉ chỉnh mỗi name, ip, giảm resource trong vagrantfile 

- trong lúc tạo đã master thì nó đã cho link để thêm các node, nếu muốn lấy lại ```kubeadm token create --print-join-command```

- sau đó dùng link nó đưa cho qua máy worker join, ví dụ 
```
kubeadm join 172.16.10.100:6443 --token 171l5u.8e2a2cw1h2e23cnt --discovery-token-ca-cert-hash sha256:1edb7b4c802192f7511c091c9136a34bfe3df5052c956ea41266b898efa23ef8 
```

- check lại trên master, lưu ý lúc này trên worker có kubectl tuy nhiên nó chưa đựoc chỉ định nên k chạy ```kubectl get nodes``` đựoc 

# summary 

- 

# ref 

- https://xuanthulab.net/gioi-thieu-va-cai-dat-kubernetes-cluster.html