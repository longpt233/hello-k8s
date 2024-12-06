helm repo add nvidia https://nvidia.github.io/gpu-operator \
   && helm repo update
helm install gpu-operator \
    -n gpu-operator --create-namespace \
    nvidia/gpu-operator \
    --version=v24.9.0 \
    --set driver.enabled=false

(base) admini@5002544:~$ kubectl get pods -owide -n gpu-operator
NAME                                                         READY   STATUS             RESTARTS       AGE     IP            NODE       NOMINATED NODE   READINESS GATES
gpu-feature-discovery-ckssr                                  0/1     CrashLoopBackOff   5 (103s ago)   5m30s   10.244.0.66   minikube   <none>           <none>
gpu-operator-5b6b99f58-zbk66                                 1/1     Running            0              6m6s    10.244.0.59   minikube   <none>           <none>
gpu-operator-node-feature-discovery-gc-75ddf784b-xjwwh       1/1     Running            0              6m6s    10.244.0.61   minikube   <none>           <none>
gpu-operator-node-feature-discovery-master-f8c54b974-62vsg   1/1     Running            0              6m6s    10.244.0.60   minikube   <none>           <none>
gpu-operator-node-feature-discovery-worker-5724f             1/1     Running            0              6m6s    10.244.0.58   minikube   <none>           <none>
nvidia-container-toolkit-daemonset-s2bl4                     1/1     Running            0              5m24s   10.244.0.67   minikube   <none>           <none>
nvidia-cuda-validator-mxjbh                                  0/1     Completed          0              5m21s   10.244.0.68   minikube   <none>           <none>
nvidia-dcgm-exporter-drqh7                                   1/1     Running            0              5m30s   10.244.0.65   minikube   <none>           <none>
nvidia-device-plugin-daemonset-s48d4                         0/1     CrashLoopBackOff   5 (118s ago)   5m30s   10.244.0.64   minikube   <none>           <none>
nvidia-operator-validator-9sppd                              1/1     Running            0              5m30s   10.244.0.63   minikube   <none>           <none>


(base) admini@5002544:~$ helm list -A
NAME                  	NAMESPACE          	REVISION	UPDATED                                	STATUS  	CHART                                                                                        	APP VERSION
fleet-agent-local-mini	cattle-fleet-system	1       	2024-11-21 09:40:06.206965001 +0000 UTC	deployed	fleet-agent-local-mini-v0.0.0+s-fb08a70a3d3042040ae8c5c15d5cdb4bd39684de27038ff3b13941a046544	           
gpu-operator          	gpu-operator       	1       	2024-11-27 01:55:00.541233538 +0000 UTC	deployed	gpu-operator-v24.9.0                                                                         	v24.9.0    
nginx-ingress         	nginx-ingress      	1       	2024-11-21 10:12:44.636854461 +0000 UTC	deployed	nginx-ingress-0.13.0                                                                         	2.2.0      
rancher-webhook       	cattle-system      	2       	2024-11-21 09:40:33.173724742 +0000 UTC	deployed	rancher-webhook-105.0.0+up0.6.1                                                              	0.6.1  

(base) admini@5002544:~$ helm uninstall gpu-operator
Error: uninstall: Release not loaded: gpu-operator: release: not found
(base) admini@5002544:~$ helm uninstall gpu-operator -n gpu-operator
release "gpu-operator" uninstalled

helm install --wait --generate-name \
    -n gpu-operator --create-namespace \
    nvidia/gpu-operator \
    --version=v24.9.0 \
    --set mig.strategy=single