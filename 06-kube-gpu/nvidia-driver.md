

toolkit

https://docs.nvidia.com/cuda/cuda-installation-guide-linux/
```
https://developer.nvidia.com/cuda-downloads
sudo apt-get --purge remove <package_name>  

where <distro>/<arch> should be replaced by one of the following:
    ubuntu2004/arm64
    ubuntu2004/sbsa
    ubuntu2004/x86_64
    ubuntu2204/sbsa
    ubuntu2204/x86_64
    ubuntu2404/sbsa
    ubuntu2404/x86_64

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo cp /var/cuda-repo-ubuntu2404-12-6-local/cuda-C2AA7D2F-keyring.gpg /usr/share/keyrings/
sudo dpkg --install cuda-repo-<distro>-<version>.<architecture>.deb   -> lay o link ben tren  https://developer.nvidia.com/cuda-downloads
sudo apt-key del 7fa2af80
wget https://developer.download.nvidia.com/compute/cuda/repos/<distro>/<arch>/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo add-apt-repository contrib
sudo apt-get update
sudo apt-get -y install cuda
```

contianer
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

```
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

kubespray@vu-b560maoruspro:~$ sudo nvidia-ctk runtime configure --runtime=docker
INFO[0000] Config file does not exist; using empty config 
INFO[0000] Wrote updated config to /etc/docker/daemon.json 
INFO[0000] It is recommended that docker daemon be restarted. 
kubespray@vu-b560maoruspro:~$ cat /etc/docker/daemon.json 
{
    "runtimes": {
        "nvidia": {
            "args": [],
            "path": "nvidia-container-runtime"
        }
    }

```



