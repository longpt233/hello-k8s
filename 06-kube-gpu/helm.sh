curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
   && chmod 700 get_helm.sh \
   && ./get_helm.sh


long@hello:~$ helm repo add  nginx-stable https://helm.nginx.com/stable
"nginx-stable" has been added to your repositories
long@hello:~$ helm search repo nginx
NAME                                        	CHART VERSION	APP VERSION         	DESCRIPTION                                      
nginx-stable/nginx-appprotect-dos-arbitrator	0.1.0        	1.1.0               	NGINX App Protect Dos arbitrator                 
nginx-stable/nginx-devportal                	1.7.2        	1.7.2               	A Helm chart for deploying ACM Developer Portal  
nginx-stable/nginx-ingress                  	1.4.1        	3.7.1               	NGINX Ingress Controller                         
nginx-stable/nginx-service-mesh             	2.0.0        	                    	NGINX Service Mesh                               
nginx-stable/nms                            	1.14.4       	NIM 2.17.4|ACM 1.9.3	A chart for installing the NGINX Management Suite
nginx-stable/nms-acm                        	1.9.3        	1.9.3               	A Helm chart for Kubernetes                      
nginx-stable/nms-adm                        	4.0.0        	4.0.0               	A Helm chart for ADM                             
nginx-stable/nms-hybrid                     	2.17.4       	2.17.4              	A Helm chart for Kubernetes                      
long@hello:~$ helm pull nginx-stable/nginx-ingress
long@hello:~$ tar -xzf nginx-ingress-1.4.1.tgz 
long@hello:~$ cp nginx-ingress/values.yaml value-nginx-ingress-dev.yaml
long@hello:~$ nano  value-nginx-ingress-dev.yaml
long@hello:~$ vim  value-nginx-ingress-dev.yaml
long@hello:~$ kubectl create ns nginx-ingress


long@hello:~$ helm install --wait --generate-name      -n gpu-operator --create-namespace      nvidia/gpu-operator
Error: INSTALLATION FAILED: 1 error occurred:
	* Internal error occurred: failed calling webhook "rancher.cattle.io.namespaces.create-non-kubesystem": failed to call webhook: Post "https://rancher-webhook.cattle-system.svc:443/v1/webhook/validation/namespaces?timeout=10s": Service Unavailable
long@hello:~$ telnet rancher-webhook.cattle-system.svc.cluster.local 443
Server lookup failure:  rancher-webhook.cattle-system.svc.cluster.local:443, Temporary failure in name resolution
long@hello:~$ telnet rancher-webhook.cattle-system.svc 443
^C
long@hello:~$ kubectl create ns nginx-ingress
Error from server (InternalError): Internal error occurred: failed calling webhook "rancher.cattle.io.namespaces.create-non-kubesystem": failed to call webhook: Post "https://rancher-webhook.cattle-system.svc:443/v1/webhook/validation/namespaces?timeout=10s": Service Unavailable

xoa cai hook nay di ngu qua 
https://github.com/rancher/rancher/issues/41826
https://ranchermanager.docs.rancher.com/reference-guides/rancher-webhook
cau hinh yaml co the xem tren rancher cho nhanh

kubectl get -n cattle-system MutatingWebhookConfiguration rancher.cattle.io
kubectl get -n cattle-system validatingwebhookconfigurations rancher.cattle.io
kubectl delete -n cattle-system MutatingWebhookConfiguration rancher.cattle.io

long@hello:~$  kubectl get -n cattle-system MutatingWebhookConfiguration rancher.cattle.io
NAME                WEBHOOKS   AGE
rancher.cattle.io   4          16h
long@hello:~$ kubectl delete -n cattle-system deployment.apps/rancher-webhook 
deployment.apps "rancher-webhook" deleted
long@hello:~$ kubectl get -n cattle-system MutatingWebhookConfiguration rancher.cattle.io
Error from server (NotFound): mutatingwebhookconfigurations.admissionregistration.k8s.io "rancher.cattle.io" not found
long@hello:~$ kubectl get -n cattle-system MutatingWebhookConfiguration
No resources found
long@hello:~$ kubectl delete -n cattle-system service/rancher-webhook
service "rancher-webhook" deleted
long@hello:~$ kubectl create ns nginx-ingress
namespace/nginx-ingress created






