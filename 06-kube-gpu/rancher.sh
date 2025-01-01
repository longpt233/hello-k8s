https://viblo.asia/p/k8s-phan-2-cai-dat-kubernetes-cluster-va-rancher-m68Z0BL95kG
luc cai rancher no co sang 1 cum k3s roi -> sao de tat di

docker run --name rancher-server --restart=unless-stopped  -d  -p 443:443 -p 80:80 \
-v /opt/rancher:/var/lib/rancher \
-e NO_PROXY="127.0.0.1,10.208.164.167,localhost,10.208.164.173,localhost,127.0.0.1,0.0.0.0,10.0.0.0/8,cattle-system.svc,192.168.10.0/24,.svc,.cluster.local,example.com" \
-e CATTLE_BOOTSTRAP_PASSWORD=1234  \
--privileged rancher/rancher


-> -e CATTLE_BOOTSTRAP_PASSWORD=1234 co cai nay thi se khong sho pass nua 
long@hello:~$ docker logs rancher-server  2>&1 | grep "Bootstrap Password:"
2024/11/06 12:42:29 [INFO] Bootstrap Password: 46vxcj7z6n2qlld9547g74dpfctrsb5gx6kqv65qgmq6zm8fntf6ww


-v /opt/rancher:/var/lib/rancher  -> khi nao cai thanh cong thi hang cho -v, neu khong no cu bi loi do volume da dc mount vao


long@hello:~$ kubectl apply -f https://10.208.164.167/v3/import/vhv55z67fkj4bkjczd885swp2w7wxj42xnf7l75vgtdszmxtl8cls9_c-m-7xz6ctcs.yaml
Unable to connect to the server: tls: failed to verify certificate: x509: certificate signed by unknown authority

long@hello:~$ curl --insecure -sfL https://10.208.164.167/v3/import/vhv55z67fkj4bkjczd885swp2w7wxj42xnf7l75vgtdszmxtl8cls9_c-m-7xz6ctcs.yaml | kubectl apply -f -
clusterrole.rbac.authorization.k8s.io/proxy-clusterrole-kubeapiserver created
clusterrolebinding.rbac.authorization.k8s.io/proxy-role-binding-kubernetes-master created
namespace/cattle-system created
serviceaccount/cattle created
clusterrolebinding.rbac.authorization.k8s.io/cattle-admin-binding created
secret/cattle-credentials-08cf331 created
clusterrole.rbac.authorization.k8s.io/cattle-admin created
Warning: spec.template.spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].key: beta.kubernetes.io/os is deprecated since v1.14; use "kubernetes.io/os" instead
deployment.apps/cattle-cluster-agent created
service/cattle-cluster-agent created


