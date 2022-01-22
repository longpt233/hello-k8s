# Update Deployment

- chạy lệnh đẻ set một cái image khác cho 
```
kubectl set image \
    -f deploy/go-demo-2-db.yml \
    db=mongo:3.4 \
    --record
```

- chạy này thì sẽ nâng cấp 3.3->3.4 . tuy nhiên vẫn giữ lại bản cũ  nhé ae 

```
NAME                                      DESIRED   CURRENT   READY   AGE     CONTAINERS   IMAGES      SELECTOR
replicaset.apps/go-demo-2-db-6b48fcbfcf   1         1         1       2m53s   db           mongo:3.4   
replicaset.apps/go-demo-2-db-76668544d4   0         0         0       6m13s   db           mongo:3.3  
```

- cách 2 (k tốt bằng cách 1)
```
kubectl edit -f deploy/go-demo-2-db.yml
```

- cách 3 : ```kubectl apply``` khoogn nên nếu file sửa liên tục 