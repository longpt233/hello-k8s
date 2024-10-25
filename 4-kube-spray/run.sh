apt-get update && sudo apt update
apt-get install -y docker.io
mkdir -p /etc/systemd/system/docker.service.d/

cat >>/etc/systemd/system/docker.service.d/http-proxy.conf <<EOF
[Service]
Environment="HTTP_PROXY=http://10.60.117.103:8085/"
Environment="HTTPS_PROXY=http://10.60.117.103:8085/"
EOF
systemctl daemon-reload
systemctl restart docker

sudo docker run --rm -it \
--mount type=bind,source=/root/kubespray/inventory/long-cluster,dst=/inventory \
--mount type=bind,source=/home/kubespray/.ssh/id_rsa,dst=/root/.ssh/id_rsa \
quay.io/kubespray/kubespray:v2.21.0 \
bash -c "pip3 install --proxy='http://10.60.117.103:8085/' jmespath && export ANSIBLE_HOST_KEY_CHECKING=False  && ansible-playbook -i /inventory/inventory.ini cluster.yml --user=kubespray --become"