# Pod 

pod nhé ae 

# Command

- hello (thực tế k ai khai báo như này cả )
```
kubectl run db --image mongo  
```

- với một file yml 

```
kubectl create -f pod/db.yml
kubectl delete -f pod/db.yml
kubectl describe -f pod/db.yml
kubectl get -f db.yml  
```

- với một pod tên là db-pod:
```
kubectl exec db-pod ps aux  # gửi lệnh vô trong pod
kubectl exec -it db-pod sh  # vào trong pod
kubectl logs db-pod 

kubectl delete pod db-pod
```

- nếu trong bash của 1 pod thực hiện kill, ví dụ ```pkill mongod``` -> sẽ tự động chạy lại container trong pod đó 
- nếu có 2 container trong 1 pod thì cần thêm tham số  ```-c``` để chỉ định đúng container gửi lệnh, xem log, ... **tuy nhiên không nên để 2 container trong 1 pod (scale ...)**

- check pod 

```
kubectl get pods
kubectl get pods -o wide
kubectl get pods -o json
kubectl get pods -o yaml
kubectl describe pod db 
kubectl get pods --show-labels

```

# Monitor 
- có 2 loại là liveness and readiness probes(dùng cho Service - trình bày chương 5)

- livenessProbe: check -> kill -> restart 

```
spec:
  containers:
  - name: db
    image: mongo:3.3
  - name: api
    image: vfarcic/go-demo-2
    env:
    - name: DB
      value: localhost
    livenessProbe:
      httpGet:
        path: /this/path/does/not/exist
        port: 8080
      initialDelaySeconds: 5
      timeoutSeconds: 2 # Defaults to 1
      periodSeconds: 5 # Defaults to 10
      failureThreshold: 1 # Defaults to 3
```

# Note 

- một pod không thể chia nhỏ chạy trên nhiều node 
- tất cả container trong pod chung localhost, chung volume 
-  Do not create Pods by themselves. Let one of the controllers create Pods for you.
- vì pod là đơn chức năng, nên đứng một mình vô dụng -> cần Controllers 
- Kubelet đảm bảo chắc chắn pod đang chạy (không phải là API server hay là Scheduler)