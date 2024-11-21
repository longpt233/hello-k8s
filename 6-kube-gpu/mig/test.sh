
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get install -y nvidia-docker2 \
    && sudo systemctl restart docker


chỗ này -> train ở con 0:1 luôn cx dc k cần theo thứ tự
sudo docker run --gpus '"device=0:1"' \
    nvcr.io/nvidia/pytorch:24.01-py3 \
    /bin/bash -c 'cd /opt/pytorch/examples/upstream/mnist && python main.py'

(base) admini@5002544:~$ nvidia-smi -L
GPU 0: NVIDIA A30 (UUID: GPU-1e44b340-5807-0dbe-62e6-343a6b8b8bcd)
  MIG 2g.12gb     Device  0: (UUID: MIG-1b8509c0-e60d-502d-8263-d434867998aa)
  MIG 1g.6gb      Device  1: (UUID: MIG-41b9eab5-8d48-5c52-9f07-82bc59af3901)
  MIG 1g.6gb      Device  2: (UUID: MIG-55dcd9bd-e6b1-549a-bcb4-0b0496bfee9c)

dpkg -l | grep -E '(nvidia|docker)' -> thấy thiếu nvidia-container-runtime  
sudo apt-get install -y nvidia-container-toolkit
sudo apt install nvidia-cuda-toolkit


# lenh nay loi lol 
sudo docker run --runtime=nvidia \
    -e NVIDIA_VISIBLE_DEVICES=MIG-1b8509c0-e60d-502d-8263-d434867998aa \
    nvidia/cuda nvidia-smi

# IMPORTEANCE
# For Docker versions >= 19.03
(base) admini@5002544:~$ docker run --gpus '"device=0:0"'   nvidia/cuda:12.2.0-base-ubuntu22.04 nvidia-smi -L
GPU 0: NVIDIA A30 (UUID: GPU-1e44b340-5807-0dbe-62e6-343a6b8b8bcd)
  MIG 2g.12gb     Device  0: (UUID: MIG-1b8509c0-e60d-502d-8263-d434867998aa)



(base) admini@5002544:~$ sudo apt remove --purge containerd.io 
(base) admini@5002544:~$ sudo apt  install docker.io

