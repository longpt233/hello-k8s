# cread product

- create 4 file nhes 

- nếu mà k chạy service  cho db (db-svc) thì chỗ còn lại bị lỗi hết  chắc là do k mở service cho db thì bọn kia k đọc dc đâu 

- kết quả chạy : 4 cái đầu là 4 pod, 3 cái sau 2.3 cái là service của mình, cuối cùng là 2 cái rs 
```
NAME                      READY   STATUS    RESTARTS        AGE     IP           NODE       NOMINATED NODE   READINESS GATES
pod/go-demo-2-api-2mswj   1/1     Running   3 (2m41s ago)   3m41s   172.17.0.7   minikube   <none>           <none>
pod/go-demo-2-api-5gwtx   1/1     Running   2 (2m59s ago)   3m41s   172.17.0.6   minikube   <none>           <none>
pod/go-demo-2-api-m5849   1/1     Running   2 (3m8s ago)    3m41s   172.17.0.5   minikube   <none>           <none>
pod/go-demo-2-db-4wzk8    1/1     Running   0               3m21s   172.17.0.8   minikube   <none>           <none>

NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE     SELECTOR
service/go-demo-2-api   NodePort    10.107.222.188   <none>        8080:30740/TCP   85s     service=go-demo-2,type=api
service/go-demo-2-db    ClusterIP   10.98.68.135     <none>        27017/TCP        8s      service=go-demo-2,type=db
service/kubernetes      ClusterIP   10.96.0.1        <none>        443/TCP          2d21h   <none>

NAME                            DESIRED   CURRENT   READY   AGE     CONTAINERS   IMAGES              SELECTOR
replicaset.apps/go-demo-2-api   3         3         3       3m41s   api          vfarcic/go-demo-2   service=go-demo-2,type=api
replicaset.apps/go-demo-2-db    1         1         1       3m21s   db           mongo:3.3           service=go-demo-2,type=db


```
- nếu mà tạo db rs mà k tạo svc thì api pod k kết nối tới dc hay sao ấy thì nó sẽ k lên 
- nếu mà k tạo svc cho api thì bên ngoài máy k curl tới dc 


- lấy ra ip minikube 
```
minikube ip 
```

- lấy ra node port

```
kubectl get svc go-demo-2-api \
    -o jsonpath="{.spec.ports[0].nodePort}"
```

- test curl tới 
```
curl -i "http://192.168.59.100:30740/demo/hello"
```