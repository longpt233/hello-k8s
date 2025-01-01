(base) admini@5002544:~$ nvidia-smi mig -lgipp
GPU  0 Profile ID 14 Placements: {0,1,2,3}:1
GPU  0 Profile ID 21 Placements: {0,1,2,3}:1
GPU  0 Profile ID  5 Placements: {0,2}:2       -> tạo được 2 instance profile id 5 theo cấu hình bên dưới
GPU  0 Profile ID  6 Placements: {0,2}:2       
GPU  0 Profile ID  0 Placement : {0}:4
(base) admini@5002544:~$ nvidia-smi mig -lgip
+-----------------------------------------------------------------------------+
| GPU instance profiles:                                                      |
| GPU   Name             ID    Instances   Memory     P2P    SM    DEC   ENC  |
|                              Free/Total   GiB              CE    JPEG  OFA  |
|=============================================================================|
|   0  MIG 1g.6gb        14     4/4        5.81       No     14     1     0   |
|                                                             1     0     0   |
+-----------------------------------------------------------------------------+
|   0  MIG 1g.6gb+me     21     1/1        5.81       No     14     1     0   |
|                                                             1     1     1   |
+-----------------------------------------------------------------------------+
|   0  MIG 2g.12gb        5     2/2        11.69      No     28     2     0   |
|                                                             2     0     0   |
+-----------------------------------------------------------------------------+
|   0  MIG 2g.12gb+me     6     1/1        11.69      No     28     2     0   |
|                                                             2     1     1   |
+-----------------------------------------------------------------------------+
|   0  MIG 4g.24gb        0     1/1        23.44      No     56     4     0   |
|                                                             4     1     1   |
+-----------------------------------------------------------------------------+

Trong đó p là profile -> đang list profile 
-> tạo GPU instance: sudo nvidia-smi mig -cgi 9,3g.20gb -C

-C: Compute Instances
9,3g.20gb  -> profile id 9, Short name 3g.20gb 

sudo nvidia-smi mig -cgi 14 -C


(base) admini@5002544:~$ nvidia-smi mig -lgi
No GPU instances found: Not Found
(base) admini@5002544:~$ sudo nvidia-smi mig -cgi 14 -C
[sudo] password for admini: 
Successfully created GPU instance ID  3 on GPU  0 using profile MIG 1g.6gb (ID 14)
Successfully created compute instance ID  0 on GPU  0 GPU instance ID  3 using profile MIG 1g.6gb (ID  0)
(base) admini@5002544:~$ sudo nvidia-smi mig -lgi
+-------------------------------------------------------+
| GPU instances:                                        |
| GPU   Name             Profile  Instance   Placement  |
|                          ID       ID       Start:Size |
|=======================================================|
|   0  MIG 1g.6gb          14        3          0:1     |
+-------------------------------------------------------+
(base) admini@5002544:~$ nvidia-smi -L
GPU 0: NVIDIA A30 (UUID: GPU-1e44b340-5807-0dbe-62e6-343a6b8b8bcd)
  MIG 1g.6gb      Device  0: (UUID: MIG-41b9eab5-8d48-5c52-9f07-82bc59af3901)
(base) admini@5002544:~$ sudo nvidia-smi mig -cgi 14 -C
Successfully created GPU instance ID  4 on GPU  0 using profile MIG 1g.6gb (ID 14)
Successfully created compute instance ID  0 on GPU  0 GPU instance ID  4 using profile MIG 1g.6gb (ID  0)
(base) admini@5002544:~$ nvidia-smi -L
GPU 0: NVIDIA A30 (UUID: GPU-1e44b340-5807-0dbe-62e6-343a6b8b8bcd)
  MIG 1g.6gb      Device  0: (UUID: MIG-41b9eab5-8d48-5c52-9f07-82bc59af3901)
  MIG 1g.6gb      Device  1: (UUID: MIG-55dcd9bd-e6b1-549a-bcb4-0b0496bfee9c)
(base) admini@5002544:~$ sudo nvidia-smi mig -lgi
+-------------------------------------------------------+
| GPU instances:                                        |
| GPU   Name             Profile  Instance   Placement  |
|                          ID       ID       Start:Size |
|=======================================================|
|   0  MIG 1g.6gb          14        3          0:1     |
+-------------------------------------------------------+
|   0  MIG 1g.6gb          14        4          1:1     |
+-------------------------------------------------------+
(base) admini@5002544:~$ sudo nvidia-smi mig -cgi 5 -C
Successfully created GPU instance ID  2 on GPU  0 using profile MIG 2g.12gb (ID  5)
Successfully created compute instance ID  0 on GPU  0 GPU instance ID  2 using profile MIG 2g.12gb (ID  1)
(base) admini@5002544:~$ sudo nvidia-smi mig -lgi
+-------------------------------------------------------+
| GPU instances:                                        |
| GPU   Name             Profile  Instance   Placement  |
|                          ID       ID       Start:Size |
|=======================================================|
|   0  MIG 1g.6gb          14        3          0:1     |
+-------------------------------------------------------+
|   0  MIG 1g.6gb          14        4          1:1     |
+-------------------------------------------------------+
|   0  MIG 2g.12gb          5        2          2:2     |
+-------------------------------------------------------+
(base) admini@5002544:~$ nvidia-smi
Thu Nov 21 07:12:15 2024       
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.183.01             Driver Version: 535.183.01   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  NVIDIA A30                     Off | 00000000:0B:00.0 Off |                   On |
| N/A   47C    P0              32W / 165W |     50MiB / 24576MiB |     N/A      Default |
|                                         |                      |              Enabled |
+-----------------------------------------+----------------------+----------------------+

+---------------------------------------------------------------------------------------+
| MIG devices:                                                                          |
+------------------+--------------------------------+-----------+-----------------------+
| GPU  GI  CI  MIG |                   Memory-Usage |        Vol|      Shared           |
|      ID  ID  Dev |                     BAR1-Usage | SM     Unc| CE ENC DEC OFA JPG    |
|                  |                                |        ECC|                       |
|==================+================================+===========+=======================|
|  0    2   0   0  |              25MiB / 11968MiB  | 28      0 |  2   0    2    0    0 |
|                  |               0MiB / 16383MiB  |           |                       |
+------------------+--------------------------------+-----------+-----------------------+
|  0    3   0   1  |              12MiB /  5952MiB  | 14      0 |  1   0    1    0    0 |
|                  |               0MiB /  8191MiB  |           |                       |
+------------------+--------------------------------+-----------+-----------------------+
|  0    4   0   2  |              12MiB /  5952MiB  | 14      0 |  1   0    1    0    0 |
|                  |               0MiB /  8191MiB  |           |                       |
+------------------+--------------------------------+-----------+-----------------------+
                                                                                         
+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|  No running processes found                                                           |
+---------------------------------------------------------------------------------------+

nvidia-smi mig -lcip -gi 1
-lcip List Compute Instance Profiles
-gi 1 GPU Instance ID 1


(base) admini@5002544:~$ sudo nvidia-smi mig -lcip -gi 2
+--------------------------------------------------------------------------------------+
| Compute instance profiles:                                                           |
| GPU     GPU       Name             Profile  Instances   Exclusive       Shared       |
|       Instance                       ID     Free/Total     SM       DEC   ENC   OFA  |
|         ID                                                          CE    JPEG       |
|======================================================================================|
|   0      2       MIG 1c.2g.12gb       0      0/2           14        2     0     0   |
|                                                                      2     0         |
+--------------------------------------------------------------------------------------+
|   0      2       MIG 2g.12gb          1*     0/1           28        2     0     0   |
|                                                                      2     0         |
+--------------------------------------------------------------------------------------+
(base) admini@5002544:~$ sudo nvidia-smi mig -lcip -gi 3
+--------------------------------------------------------------------------------------+
| Compute instance profiles:                                                           |
| GPU     GPU       Name             Profile  Instances   Exclusive       Shared       |
|       Instance                       ID     Free/Total     SM       DEC   ENC   OFA  |
|         ID                                                          CE    JPEG       |
|======================================================================================|
|   0      3       MIG 1g.6gb           0*     0/1           14        1     0     0   |
|                                                                      1     0         |
+--------------------------------------------------------------------------------------+


(base) admini@5002544:~$ nvidia-smi -L
GPU 0: NVIDIA A30 (UUID: GPU-1e44b340-5807-0dbe-62e6-343a6b8b8bcd)
  MIG 2g.12gb     Device  0: (UUID: MIG-1b8509c0-e60d-502d-8263-d434867998aa)
  MIG 1g.6gb      Device  1: (UUID: MIG-41b9eab5-8d48-5c52-9f07-82bc59af3901)
  MIG 1g.6gb      Device  2: (UUID: MIG-55dcd9bd-e6b1-549a-bcb4-0b0496bfee9c)
