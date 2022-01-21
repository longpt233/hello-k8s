## vagrant

```bash
sudo apt-get install vagrant
vagrant version
vagrant init
vagrant up
vagrant ssh
```

## componient 

- box 

```
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise32"
end
```

- provisioning : install on init 

```
config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get install git
SHELL
```

- networking : expose, ip 

```
config.vm.network :forwarded_port, host: 4567, guest: 80
```

- sync
```
config.vm.synced_folder '.', '/data/mydata/'
```

