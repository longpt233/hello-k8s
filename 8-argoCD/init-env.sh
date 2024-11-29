rancher

```
docker run --name rancher-server --restart=unless-stopped  -d  -p 443:443 -p 80:80 \
-v /opt/rancher:/var/lib/rancher \
-e NO_PROXY="127.0.0.1,localhost,localhost,127.0.0.1,0.0.0.0,10.0.0.0/8,cattle-system.svc,192.168.10.0/24,.svc,.cluster.local,example.com" \
--privileged rancher/rancher
docker logs rancher-server  2>&1 | grep "Bootstrap Password:"
docker exec -ti <container_id> reset-password
```

https://minikube.sigs.k8s.io/docs/tutorials/nvidia/

```
sudo apt install virtualbox virtualbox-ext-pack
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod 755 /usr/local/bin/minikube


minikube start --driver docker \
--kubernetes-version=v1.29.0 \
--listen-address='0.0.0.0' \
--memory='6000m' \
--cpus='6' \
--container-runtime docker --gpus all
```



trên rancher shell có rồi
wget https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz && \ tar xvf helm-v3.7.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/bin
helm version

# add nginx

helm repo add  nginx-stable https://helm.nginx.com/stable
helm repo update
helm search repo nginx
helm pull nginx-stable/nginx-ingress --version 0.13.0
tar -xzf nginx-ingress-0.13.0.tgz
cp nginx-ingress/values.yaml value-nginx-ingress-staging-k8s.yaml
vim value-nginx-ingress-staging-k8s.yaml
kubectl create ns nginx-ingress
helm -n nginx-ingress install nginx-ingress -f value-nginx-ingress-staging-k8s.yaml nginx-ingress
helm -n nginx-ingress uninstall nginx-ingress  nginx-ingress

-> phải sửa value các giá trị tương ứng nodePort các  vì nó k phải config map -> k đổi lúc runtime được


