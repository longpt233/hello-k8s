cat >>/home/long/Documents/k8s-lab/kubespray/inventory/mycluster/inventory.ini<<EOF
[all]
vupc  ansible_host=10.208.164.173   ip=10.208.164.173

[kube_control_plane]
vupc

[kube_node]
vupc

[etcd]
vupc

[k8s_cluster:children]
kube_node
kube_control_plane

[calico_rr]

[vault]
vupc
EOF


sudo docker run --rm -it \
--mount type=bind,source=/home/long/Documents/k8s-lab/kubespray/inventory/mycluster,dst=/inventory \
--mount type=bind,source=/home/long/.ssh/id_rsa,dst=/root/.ssh/id_rsa \
quay.io/kubespray/kubespray:v2.21.0 \
bash -c "pip3 install --proxy='http://10.60.117.103:8085/' jmespath && export ANSIBLE_HOST_KEY_CHECKING=False  && ansible-playbook -i /inventory/inventory.ini cluster.yml --user=kubespray --become"



--proxy http://10.60.117.103:8085