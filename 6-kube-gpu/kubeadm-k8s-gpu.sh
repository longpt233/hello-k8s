https://viblo.asia/p/cau-hinh-cum-kubernetes-de-su-dung-nvidia-gpu-PwlVmyaEV5Z  -> link co ve ngon
https://github.com/thangtq710/gpu-k8s

doc
https://github.com/NVIDIA/k8s-device-plugin
https://github.com/NVIDIA/k8s-device-plugin#quick-start
https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html


long@hello:~$ helm repo add nvidia https://helm.ngc.nvidia.com/nvidia \
   && helm repo update
"nvidia" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "nvidia" chart repository
Update Complete. ⎈Happy Helming!⎈
long@hello:~$ helm install --wait --generate-name      -n gpu-operator --create-namespace      nvidia/gpu-operator --debug


taoj config map  thoe phan manifest/gpu-time-slicing-configmap.yaml


long@hello:~$ kubectl patch clusterpolicy/cluster-policy \
   -n gpu-operator --type merge \
   -p '{"spec": {"devicePlugin": {"config": {"name": "gpu-time-slicing-configmap", "default": "1060ti-6gb"}}}}'
clusterpolicy.nvidia.com/cluster-policy patched

long@hello:~$ kubectl describe node | grep nvidia.com
                    nvidia.com/cuda.driver-version.full=560.35.03
                    nvidia.com/cuda.driver-version.major=560
                    nvidia.com/cuda.driver-version.minor=35
                    nvidia.com/cuda.driver-version.revision=03
                    nvidia.com/cuda.driver.major=560
                    nvidia.com/cuda.driver.minor=35
                    nvidia.com/cuda.driver.rev=03
                    nvidia.com/cuda.runtime-version.full=12.6
                    nvidia.com/cuda.runtime-version.major=12
                    nvidia.com/cuda.runtime-version.minor=6
                    nvidia.com/cuda.runtime.major=12
                    nvidia.com/cuda.runtime.minor=6
                    nvidia.com/gfd.timestamp=1730962533
                    nvidia.com/gpu-driver-upgrade-state=upgrade-done
                    nvidia.com/gpu.compute.major=7
                    nvidia.com/gpu.compute.minor=5
                    nvidia.com/gpu.count=1
                    nvidia.com/gpu.deploy.container-toolkit=true
                    nvidia.com/gpu.deploy.dcgm=true
                    nvidia.com/gpu.deploy.dcgm-exporter=true
                    nvidia.com/gpu.deploy.device-plugin=true
                    nvidia.com/gpu.deploy.driver=pre-installed
                    nvidia.com/gpu.deploy.gpu-feature-discovery=true
                    nvidia.com/gpu.deploy.node-status-exporter=true
                    nvidia.com/gpu.deploy.operator-validator=true
                    nvidia.com/gpu.family=turing
                    nvidia.com/gpu.machine=B560M-AORUS-PRO
                    nvidia.com/gpu.memory=6144
                    nvidia.com/gpu.mode=graphics
                    nvidia.com/gpu.present=true
                    nvidia.com/gpu.product=NVIDIA-GeForce-GTX-1660-Ti-SHARED    -> check SHARE
                    nvidia.com/gpu.replicas=6
                    nvidia.com/gpu.sharing-strategy=time-slicing
                    nvidia.com/mig.capable=false
                    nvidia.com/mig.strategy=single
                    nvidia.com/mps.capable=false
                    nvidia.com/vgpu.present=false
                    management.cattle.io/pod-limits: {"memory":"1536Mi","nvidia.com/gpu":"1"}
                    management.cattle.io/pod-requests: {"cpu":"215m","memory":"320Mi","nvidia.com/gpu":"1","pods":"14"}
                    nvidia.com/gpu-driver-upgrade-enabled: true
  nvidia.com/gpu:     6
  nvidia.com/gpu:     6     ->> check 
  nvidia.com/gpu     1   


long@hello:~$ kubectl apply -f ~/Documents/hello-k8s/6-kube-gpu/manifest/gpu-share-deployment.yaml 
deployment.apps/nvidia-plugin-test-2 created

