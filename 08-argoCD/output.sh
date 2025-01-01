root@5002544:~# kubectl get node -o json | jq '.items[].metadata.labels'
{
  "beta.kubernetes.io/arch": "amd64",
  "beta.kubernetes.io/instance-type": "k3s",
  "beta.kubernetes.io/os": "linux",
  "feature.node.kubernetes.io/cpu-cpuid.ADX": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AESNI": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX2": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512BW": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512CD": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512DQ": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512F": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512VL": "true",
  "feature.node.kubernetes.io/cpu-cpuid.CMPXCHG8": "true",
  "feature.node.kubernetes.io/cpu-cpuid.FLUSH_L1D": "true",
  "feature.node.kubernetes.io/cpu-cpuid.FMA3": "true",
  "feature.node.kubernetes.io/cpu-cpuid.FXSR": "true",
  "feature.node.kubernetes.io/cpu-cpuid.FXSROPT": "true",
  "feature.node.kubernetes.io/cpu-cpuid.HYPERVISOR": "true",
  "feature.node.kubernetes.io/cpu-cpuid.IA32_ARCH_CAP": "true",
  "feature.node.kubernetes.io/cpu-cpuid.IBPB": "true",
  "feature.node.kubernetes.io/cpu-cpuid.LAHF": "true",
  "feature.node.kubernetes.io/cpu-cpuid.MD_CLEAR": "true",
  "feature.node.kubernetes.io/cpu-cpuid.MOVBE": "true",
  "feature.node.kubernetes.io/cpu-cpuid.OSXSAVE": "true",
  "feature.node.kubernetes.io/cpu-cpuid.SHA": "true",
  "feature.node.kubernetes.io/cpu-cpuid.SPEC_CTRL_SSBD": "true",
  "feature.node.kubernetes.io/cpu-cpuid.STIBP": "true",
  "feature.node.kubernetes.io/cpu-cpuid.SYSCALL": "true",
  "feature.node.kubernetes.io/cpu-cpuid.SYSEE": "true",
  "feature.node.kubernetes.io/cpu-cpuid.X87": "true",
  "feature.node.kubernetes.io/cpu-cpuid.XSAVE": "true",
  "feature.node.kubernetes.io/cpu-cpuid.XSAVEC": "true",
  "feature.node.kubernetes.io/cpu-cpuid.XSAVEOPT": "true",
  "feature.node.kubernetes.io/cpu-cpuid.XSAVES": "true",
  "feature.node.kubernetes.io/cpu-hardware_multithreading": "false",
  "feature.node.kubernetes.io/cpu-model.family": "6",
  "feature.node.kubernetes.io/cpu-model.id": "143",
  "feature.node.kubernetes.io/cpu-model.vendor_id": "Intel",
  "feature.node.kubernetes.io/kernel-config.NO_HZ": "true",
  "feature.node.kubernetes.io/kernel-config.NO_HZ_IDLE": "true",
  "feature.node.kubernetes.io/kernel-version.full": "5.15.0-124-generic",
  "feature.node.kubernetes.io/kernel-version.major": "5",
  "feature.node.kubernetes.io/kernel-version.minor": "15",
  "feature.node.kubernetes.io/kernel-version.revision": "0",
  "feature.node.kubernetes.io/memory-swap": "true",
  "feature.node.kubernetes.io/pci-10de.present": "true",
  "feature.node.kubernetes.io/pci-15ad.present": "true",
  "feature.node.kubernetes.io/system-os_release.ID": "ubuntu",
  "feature.node.kubernetes.io/system-os_release.VERSION_ID": "22.04",
  "feature.node.kubernetes.io/system-os_release.VERSION_ID.major": "22",
  "feature.node.kubernetes.io/system-os_release.VERSION_ID.minor": "04",
  "kubernetes.io/arch": "amd64",
  "kubernetes.io/hostname": "5002544",
  "kubernetes.io/os": "linux",
  "node-role.kubernetes.io/control-plane": "true",
  "node-role.kubernetes.io/master": "true",
  "node.kubernetes.io/instance-type": "k3s",
  "nvidia.com/cuda.driver-version.full": "535.183.01",
  "nvidia.com/cuda.driver-version.major": "535",
  "nvidia.com/cuda.driver-version.minor": "183",
  "nvidia.com/cuda.driver-version.revision": "01",
  "nvidia.com/cuda.driver.major": "535",
  "nvidia.com/cuda.driver.minor": "183",
  "nvidia.com/cuda.driver.rev": "01",
  "nvidia.com/cuda.runtime-version.full": "12.2",
  "nvidia.com/cuda.runtime-version.major": "12",
  "nvidia.com/cuda.runtime-version.minor": "2",
  "nvidia.com/cuda.runtime.major": "12",
  "nvidia.com/cuda.runtime.minor": "2",
  "nvidia.com/gfd.timestamp": "1733536424",
  "nvidia.com/gpu.compute.major": "8",
  "nvidia.com/gpu.compute.minor": "0",
  "nvidia.com/gpu.count": "1",
  "nvidia.com/gpu.deploy.container-toolkit": "true",
  "nvidia.com/gpu.deploy.dcgm": "true",
  "nvidia.com/gpu.deploy.dcgm-exporter": "true",
  "nvidia.com/gpu.deploy.device-plugin": "true",
  "nvidia.com/gpu.deploy.driver": "true",
  "nvidia.com/gpu.deploy.gpu-feature-discovery": "true",
  "nvidia.com/gpu.deploy.mig-manager": "true",
  "nvidia.com/gpu.deploy.node-status-exporter": "true",
  "nvidia.com/gpu.deploy.operator-validator": "true",
  "nvidia.com/gpu.family": "ampere",
  "nvidia.com/gpu.machine": "VMware71",
  "nvidia.com/gpu.memory": "24576",
  "nvidia.com/gpu.mode": "compute",
  "nvidia.com/gpu.present": "true",
  "nvidia.com/gpu.product": "NVIDIA-A30",
  "nvidia.com/gpu.replicas": "1",
  "nvidia.com/gpu.sharing-strategy": "none",
  "nvidia.com/mig.capable": "true",
  "nvidia.com/mig.config": "all-disabled",
  "nvidia.com/mig.config.state": "success",
  "nvidia.com/mig.strategy": "single",
  "nvidia.com/mps.capable": "false",
  "nvidia.com/vgpu.present": "false"
}

root@5002544:~# kubectl get node 5002544 -o=jsonpath='{.metadata.labels}' | jq .
{
  "beta.kubernetes.io/arch": "amd64",
  "beta.kubernetes.io/instance-type": "k3s",
  "beta.kubernetes.io/os": "linux",
  "feature.node.kubernetes.io/cpu-cpuid.ADX": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AESNI": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX2": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512BW": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512CD": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512DQ": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512F": "true",
  "feature.node.kubernetes.io/cpu-cpuid.AVX512VL": "true",
  "feature.node.kubernetes.io/cpu-cpuid.CMPXCHG8": "true",
  "feature.node.kubernetes.io/cpu-cpuid.FLUSH_L1D": "true",
  "feature.node.kubernetes.io/cpu-cpuid.FMA3": "true",
  "feature.node.kubernetes.io/cpu-cpuid.FXSR": "true",
  "feature.node.kubernetes.io/cpu-cpuid.FXSROPT": "true",
  "feature.node.kubernetes.io/cpu-cpuid.HYPERVISOR": "true",
  "feature.node.kubernetes.io/cpu-cpuid.IA32_ARCH_CAP": "true",
  "feature.node.kubernetes.io/cpu-cpuid.IBPB": "true",
  "feature.node.kubernetes.io/cpu-cpuid.LAHF": "true",
  "feature.node.kubernetes.io/cpu-cpuid.MD_CLEAR": "true",
  "feature.node.kubernetes.io/cpu-cpuid.MOVBE": "true",
  "feature.node.kubernetes.io/cpu-cpuid.OSXSAVE": "true",
  "feature.node.kubernetes.io/cpu-cpuid.SHA": "true",
  "feature.node.kubernetes.io/cpu-cpuid.SPEC_CTRL_SSBD": "true",
  "feature.node.kubernetes.io/cpu-cpuid.STIBP": "true",
  "feature.node.kubernetes.io/cpu-cpuid.SYSCALL": "true",
  "feature.node.kubernetes.io/cpu-cpuid.SYSEE": "true",
  "feature.node.kubernetes.io/cpu-cpuid.X87": "true",
  "feature.node.kubernetes.io/cpu-cpuid.XSAVE": "true",
  "feature.node.kubernetes.io/cpu-cpuid.XSAVEC": "true",
  "feature.node.kubernetes.io/cpu-cpuid.XSAVEOPT": "true",
  "feature.node.kubernetes.io/cpu-cpuid.XSAVES": "true",
  "feature.node.kubernetes.io/cpu-hardware_multithreading": "false",
  "feature.node.kubernetes.io/cpu-model.family": "6",
  "feature.node.kubernetes.io/cpu-model.id": "143",
  "feature.node.kubernetes.io/cpu-model.vendor_id": "Intel",
  "feature.node.kubernetes.io/kernel-config.NO_HZ": "true",
  "feature.node.kubernetes.io/kernel-config.NO_HZ_IDLE": "true",
  "feature.node.kubernetes.io/kernel-version.full": "5.15.0-124-generic",
  "feature.node.kubernetes.io/kernel-version.major": "5",
  "feature.node.kubernetes.io/kernel-version.minor": "15",
  "feature.node.kubernetes.io/kernel-version.revision": "0",
  "feature.node.kubernetes.io/memory-swap": "true",
  "feature.node.kubernetes.io/pci-10de.present": "true",
  "feature.node.kubernetes.io/pci-15ad.present": "true",
  "feature.node.kubernetes.io/system-os_release.ID": "ubuntu",
  "feature.node.kubernetes.io/system-os_release.VERSION_ID": "22.04",
  "feature.node.kubernetes.io/system-os_release.VERSION_ID.major": "22",
  "feature.node.kubernetes.io/system-os_release.VERSION_ID.minor": "04",
  "kubernetes.io/arch": "amd64",
  "kubernetes.io/hostname": "5002544",
  "kubernetes.io/os": "linux",
  "node-role.kubernetes.io/control-plane": "true",
  "node-role.kubernetes.io/master": "true",
  "node.kubernetes.io/instance-type": "k3s",
  "nvidia.com/gpu.deploy.container-toolkit": "true",
  "nvidia.com/gpu.deploy.dcgm": "true",
  "nvidia.com/gpu.deploy.dcgm-exporter": "true",
  "nvidia.com/gpu.deploy.device-plugin": "true",
  "nvidia.com/gpu.deploy.driver": "true",
  "nvidia.com/gpu.deploy.gpu-feature-discovery": "true",
  "nvidia.com/gpu.deploy.mig-manager": "true",
  "nvidia.com/gpu.deploy.node-status-exporter": "true",
  "nvidia.com/gpu.deploy.nvsm": "true",
  "nvidia.com/gpu.deploy.operator-validator": "true",
  "nvidia.com/gpu.present": "true",
  "nvidia.com/mig.config": "all-1g.10gb",
  "nvidia.com/mig.config.state": "success"
}


root@5002544:~# kubectl logs pod/nvidia-container-toolkit-daemonset-j9gsn   -n gpu-operator
Using config:
accept-nvidia-visible-devices-as-volume-mounts = false
accept-nvidia-visible-devices-envvar-when-unprivileged = true
disable-require = false
supported-driver-capabilities = "compat32,compute,display,graphics,ngx,utility,video"

[nvidia-container-cli]
  environment = []
  ldconfig = "@/sbin/ldconfig.real"
  load-kmods = true
  path = "/usr/local/nvidia/toolkit/nvidia-container-cli"
  root = "/"

[nvidia-container-runtime]
  log-level = "info"
  mode = "auto"
  runtimes = ["docker-runc", "runc", "crun"]

  [nvidia-container-runtime.modes]

    [nvidia-container-runtime.modes.cdi]
time="2024-12-07T03:35:24Z" level=info msg="Starting 'setup' for nvidia-toolkit"
      annotation-prefixes = ["cdi.k8s.io/"]
      default-kind = "management.nvidia.com/gpu"
      spec-dirs = ["/etc/cdi", "/var/run/cdi"]

    [nvidia-container-runtime.modes.csv]
      mount-spec-path = "/etc/nvidia-container-runtime/host-files-for-container.d"

[nvidia-container-runtime-hook]
  path = "/usr/local/nvidia/toolkit/nvidia-container-runtime-hook"
  skip-mode-detection = true

[nvidia-ctk]
  path = "/usr/local/nvidia/toolkit/nvidia-ctk"
time="2024-12-07T03:35:24Z" level=info msg="Flushing config to /runtime/config-dir/config.toml"
time="2024-12-07T03:35:24Z" level=info msg="Sending SIGHUP signal to containerd"
time="2024-12-07T03:35:24Z" level=warning msg="Error signaling containerd, attempt 1/6: unable to dial: dial unix /runtime/sock-dir/containerd.sock: connect: connection refused"
time="2024-12-07T03:35:29Z" level=warning msg="Error signaling containerd, attempt 2/6: unable to dial: dial unix /runtime/sock-dir/containerd.sock: connect: connection refused"
time="2024-12-07T03:35:34Z" level=warning msg="Error signaling containerd, attempt 3/6: unable to dial: dial unix /runtime/sock-dir/containerd.sock: connect: connection refused"
time="2024-12-07T03:35:39Z" level=warning msg="Error signaling containerd, attempt 4/6: unable to dial: dial unix /runtime/sock-dir/containerd.sock: connect: connection refused"
time="2024-12-07T03:35:44Z" level=warning msg="Error signaling containerd, attempt 5/6: unable to dial: dial unix /runtime/sock-dir/containerd.sock: connect: connection refused"
time="2024-12-07T03:35:49Z" level=warning msg="Max retries reached 6/6, aborting"
time="2024-12-07T03:35:49Z" level=info msg="Shutting Down"
time="2024-12-07T03:35:49Z" level=error msg="error running nvidia-toolkit: unable to setup runtime: unable to restart containerd: unable to dial: dial unix /runtime/sock-dir/containerd.sock: connect: connection refused"


root@5002544:~# kubectl get all -owide -n gpu-operator
NAME                                                                  READY   STATUS      RESTARTS        AGE     IP            NODE      NOMINATED NODE   READINESS GATES
pod/gpu-feature-discovery-w7wh5                                       1/1     Running     0               4m32s   10.42.0.104   5002544   <none>           <none>
pod/gpu-operator-1733542989-node-feature-discovery-gc-7758f84bfvxjb   1/1     Running     1 (4m50s ago)   10m     10.42.0.97    5002544   <none>           <none>
pod/gpu-operator-1733542989-node-feature-discovery-master-ffd5wdnzp   1/1     Running     1 (4m50s ago)   10m     10.42.0.94    5002544   <none>           <none>
pod/gpu-operator-1733542989-node-feature-discovery-worker-rwzdw       1/1     Running     1 (4m50s ago)   10m     10.42.0.98    5002544   <none>           <none>
pod/gpu-operator-69544cb756-c2flw                                     1/1     Running     1 (4m50s ago)   10m     10.42.0.95    5002544   <none>           <none>
pod/nvidia-cuda-validator-7b5rz                                       0/1     Completed   0               4m30s   10.42.0.106   5002544   <none>           <none>
pod/nvidia-dcgm-exporter-f7q62                                        1/1     Running     0               4m32s   10.42.0.103   5002544   <none>           <none>
pod/nvidia-device-plugin-daemonset-6pcmf                              1/1     Running     0               4m32s   10.42.0.105   5002544   <none>           <none>
pod/nvidia-mig-manager-jlhmv                                          1/1     Running     1 (4m50s ago)   10m     10.42.0.100   5002544   <none>           <none>
pod/nvidia-operator-validator-zb454                                   1/1     Running     0               4m33s   10.42.0.102   5002544   <none>           <none>

NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE   SELECTOR
service/gpu-operator           ClusterIP   10.43.165.255   <none>        8080/TCP   10m   app=gpu-operator
service/nvidia-dcgm-exporter   ClusterIP   10.43.71.137    <none>        9400/TCP   10m   app=nvidia-dcgm-exporter

NAME                                                                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                                                          AGE   CONTAINERS                  IMAGES                                                            SELECTOR
daemonset.apps/gpu-feature-discovery                                   1         1         1       1            1           nvidia.com/gpu.deploy.gpu-feature-discovery=true                       10m   gpu-feature-discovery       nvcr.io/nvidia/k8s-device-plugin:v0.17.0                          app=gpu-feature-discovery,app.kubernetes.io/part-of=nvidia-gpu
daemonset.apps/gpu-operator-1733542989-node-feature-discovery-worker   1         1         1       1            1           <none>                                                                 10m   worker                      registry.k8s.io/nfd/node-feature-discovery:v0.16.6                app.kubernetes.io/instance=gpu-operator-1733542989,app.kubernetes.io/name=node-feature-discovery,role=worker
daemonset.apps/nvidia-dcgm-exporter                                    1         1         1       1            1           nvidia.com/gpu.deploy.dcgm-exporter=true                               10m   nvidia-dcgm-exporter        nvcr.io/nvidia/k8s/dcgm-exporter:3.3.9-3.6.1-ubuntu22.04          app=nvidia-dcgm-exporter
daemonset.apps/nvidia-device-plugin-daemonset                          1         1         1       1            1           nvidia.com/gpu.deploy.device-plugin=true                               10m   nvidia-device-plugin        nvcr.io/nvidia/k8s-device-plugin:v0.17.0                          app=nvidia-device-plugin-daemonset
daemonset.apps/nvidia-device-plugin-mps-control-daemon                 0         0         0       0            0           nvidia.com/gpu.deploy.device-plugin=true,nvidia.com/mps.capable=true   10m   mps-control-daemon-ctr      nvcr.io/nvidia/k8s-device-plugin:v0.17.0                          app=nvidia-device-plugin-mps-control-daemon
daemonset.apps/nvidia-mig-manager                                      1         1         1       1            1           nvidia.com/gpu.deploy.mig-manager=true                                 10m   nvidia-mig-manager          nvcr.io/nvidia/cloud-native/k8s-mig-manager:v0.10.0-ubuntu20.04   app=nvidia-mig-manager
daemonset.apps/nvidia-operator-validator                               1         1         1       1            1           nvidia.com/gpu.deploy.operator-validator=true                          10m   nvidia-operator-validator   nvcr.io/nvidia/cloud-native/gpu-operator-validator:v24.9.1        app=nvidia-operator-validator,app.kubernetes.io/part-of=gpu-operator

NAME                                                                    READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS     IMAGES                                               SELECTOR
deployment.apps/gpu-operator                                            1/1     1            1           10m   gpu-operator   nvcr.io/nvidia/gpu-operator:v24.9.1                  app=gpu-operator,app.kubernetes.io/component=gpu-operator
deployment.apps/gpu-operator-1733542989-node-feature-discovery-gc       1/1     1            1           10m   gc             registry.k8s.io/nfd/node-feature-discovery:v0.16.6   app.kubernetes.io/instance=gpu-operator-1733542989,app.kubernetes.io/name=node-feature-discovery,role=gc
deployment.apps/gpu-operator-1733542989-node-feature-discovery-master   1/1     1            1           10m   master         registry.k8s.io/nfd/node-feature-discovery:v0.16.6   app.kubernetes.io/instance=gpu-operator-1733542989,app.kubernetes.io/name=node-feature-discovery,role=master

NAME                                                                              DESIRED   CURRENT   READY   AGE   CONTAINERS     IMAGES                                               SELECTOR
replicaset.apps/gpu-operator-1733542989-node-feature-discovery-gc-7758f84bfd      1         1         1       10m   gc             registry.k8s.io/nfd/node-feature-discovery:v0.16.6   app.kubernetes.io/instance=gpu-operator-1733542989,app.kubernetes.io/name=node-feature-discovery,pod-template-hash=7758f84bfd,role=gc
replicaset.apps/gpu-operator-1733542989-node-feature-discovery-master-ffd5bdf86   1         1         1       10m   master         registry.k8s.io/nfd/node-feature-discovery:v0.16.6   app.kubernetes.io/instance=gpu-operator-1733542989,app.kubernetes.io/name=node-feature-discovery,pod-template-hash=ffd5bdf86,role=master
replicaset.apps/gpu-operator-69544cb756                                           1         1         1       10m   gpu-operator   nvcr.io/nvidia/gpu-operator:v24.9.1                  app=gpu-operator,app.kubernetes.io/component=gpu-operator,pod-template-hash=69544cb756

