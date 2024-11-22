
export http_proxy=http://10.208.164.185:9999/
export https_proxy=$http_proxy
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=h$http_proxy
export no_proxy=10.208.164.167,10.208.164.173,208.164.177,localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.49.0/24,192.168.39.0/24
export NO_PROXY=$no_proxy


https://minikube.sigs.k8s.io/docs/handbook/vpn_and_proxy/

minikube start --driver=docker \
--docker-env http_proxy=$http_proxy \
--docker-env https_proxy=$https_proxy \
--docker-env no_proxy=$no_proxy \
--kubernetes-version=v1.29.0 \
--listen-address='0.0.0.0' \
--static-ip='192.168.49.10' \
--apiserver-ips='10.208.164.177' \
--memory='6000m' \
--cpus='6' \
--apiserver-port=8443 


or --driver=virtualbox

export no_proxy=$no_proxy,$(minikube ip)
export NO_PROXY=$no_proxy,$(minikube ip)


dungvm2@dungvm2-MS-7B48:~$ minikube kubectl get nodes
Error caching kubectl: download failed: https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl?checksum=file:https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl.sha256: getter: &{Ctx:context.Background Src:https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl?checksum=file:https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl.sha256 Dst:/home/dungvm2/.minikube/cache/linux/amd64/v1.31.0/kubectl.download Pwd: Mode:2 Umask:---------- Detectors:[0x4eb7820 0x4eb7820 0x4eb7820 0x4eb7820 0x4eb7820 0x4eb7820 0x4eb7820] Decompressors:map[bz2:0xc000989880 gz:0xc000989888 tar:0xc000989830 tar.bz2:0xc000989840 tar.gz:0xc000989850 tar.xz:0xc000989860 tar.zst:0xc000989870 tbz2:0xc000989840 tgz:0xc000989850 txz:0xc000989860 tzst:0xc000989870 xz:0xc000989890 zip:0xc0009898a0 zst:0xc000989898] Getters:map[file:0xc000d07520 http:0xc000657900 https:0xc000657950] Dir:false ProgressListener:0x4e44750 Insecure:false DisableSymlinks:false Options:[0x12e5e60]}: invalid checksum: Error downloading checksum file: Get "https://cdn.dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl.sha256": Gateway Time-out

thôi k cần kubectl từ xa đâu (crt mất time). cài rancher cho nó connect đến xong chạy shell cho lành



