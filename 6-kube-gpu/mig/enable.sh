(base) admini@5002544:~$ nvidia-smi
Thu Nov 21 06:48:37 2024       
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.183.01             Driver Version: 535.183.01   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  NVIDIA A30                     Off | 00000000:0B:00.0 Off |                    0 |
| N/A   49C    P0              43W / 165W |      0MiB / 24576MiB |      0%      Default |
|                                         |                      |             Enabled* |
+-----------------------------------------+----------------------+----------------------+
                                                                                         
+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|  No running processes found                                                           |
+---------------------------------------------------------------------------------------+
(base) admini@5002544:~$ sudo nvidia-smi -i 0 -mig 1
[sudo] password for admini: 
Warning: MIG mode is in pending enable state for GPU 00000000:0B:00.0:In use by another client
00000000:0B:00.0 is currently being used by one or more other processes (e.g. CUDA application or a monitoring application such as another instance of nvidia-smi). Please first kill all processes using the device and retry the command or reboot the system to make MIG mode effective.
All done.
(base) admini@5002544:~$ sudo reboot
(base) admini@5002544:~$ nvidia-smi -i 0 --query-gpu=pci.bus_id,mig.mode.current --format=csv
pci.bus_id, mig.mode.current
00000000:0B:00.0, Enabled
(base) admini@5002544:~$ nvidia-smi 
Thu Nov 21 06:50:36 2024       
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.183.01             Driver Version: 535.183.01   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  NVIDIA A30                     Off | 00000000:0B:00.0 Off |                   On |
| N/A   48C    P0              33W / 165W |      0MiB / 24576MiB |     N/A      Default |
|                                         |                      |              Enabled |
+-----------------------------------------+----------------------+----------------------+

+---------------------------------------------------------------------------------------+
| MIG devices:                                                                          |
+------------------+--------------------------------+-----------+-----------------------+
| GPU  GI  CI  MIG |                   Memory-Usage |        Vol|      Shared           |
|      ID  ID  Dev |                     BAR1-Usage | SM     Unc| CE ENC DEC OFA JPG    |
|                  |                                |        ECC|                       |
|==================+================================+===========+=======================|
|  No MIG devices found                                                                 |
+---------------------------------------------------------------------------------------+
                                                                                         
+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|  No running processes found                                                           |
+---------------------------------------------------------------------------------------+




clean up 
sudo nvidia-smi mig -dci && sudo nvidia-smi mig -dgi
Bạn không thể xóa GPU Instance (GI) nếu vẫn còn Compute Instance (CI) tồn tại trên đó. Vì vậy, cần thực hiện -dci trước -dgi
docker: MIG-<GPU-UUID>/<GPU instance ID>/<compute instance ID>
root@my-h100-instance:~# nvidia-smi -mig 0
Disabled MIG Mode for GPU 00000000:01:00.0
All done.
