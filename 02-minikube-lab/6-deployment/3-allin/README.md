# Note 
- update multiple obj

```
kubectl set image deployments \
    -l type=db,vendor=MongoLabs \
    db=mongo:3.4 --record
```

- replica: test sủa số rep từ 3-> 5 rồi apply 
```
kubectl apply \
    -f deploy/go-demo-2-scaled.yml
```

- câu lệnh trên sẽ báo lỗi nếu như bạn create mà k có option ```--save-config```

- ngoài ra có thể lựa chonj số để scale theo resorce(trinhf bày sau )

- cách khác để scale mà k sửa file 
```
kubectl scale deployment \
    go-demo-2-api --replicas 8 --record
```