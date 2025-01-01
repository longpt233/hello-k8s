# Deployment Strategies

# Recreate Strategy

- cho những dịch vụ nhưu kiểu db(single - replica). tắt trước khi bật lại 
- chú ý nếu mà down time có thể mất dữ liệu update 

# RollingUpdate Strategy

- default 
- 0-downtime 
- tạo một replica set mới. rs cũ thì set dần hết về bằng 0 
- cứ thay dần thế cho tới khi một bên lên full một bền về  0 

- 2 tham số  ```maxSurge```. số pod sẽ k vượt quá số  này + số replica . ```maxUnavailable``` số  pod sẽ k thấm hơn số replica- số này 

# Command 

- chạy db, db-svd, api . nhớ create với ```--record``` để có his mà đọc (rollout history)
- đổi ver cho 3 pod api 
```
kubectl set image \
    -f deploy/go-demo-2-api.yml \
    api=vfarcic/go-demo-2:2.0 \
    --record
```

- check 
```
kubectl rollout status -w \
    -f deploy/go-demo-2-api.yml

kubectl describe \
    -f deploy/go-demo-2-api.yml

kubectl rollout history \
    -f deploy/go-demo-2-api.yml
```

- sẽ có lúc chạy song song 2 version, service luôn sống 

- minh họa quá trongh thay thế  theo rs 

![](.deploy-rs.png)


# Rollback 
- k thể vá kịp lỗi thì phải back lại thôi 

- lệnh undo 
```
kubectl rollout undo \
    -f deploy/go-demo-2-api.yml
```

- tới một bản nào đó thì chạy lệnh ```rollout history```, rồi tìm revisiton cần quay lại 

```
kubectl rollout undo \
    -f deploy/go-demo-2-api.yml \
    --to-revision=2
```

- có trường hợp phải roll lại một bản lỗi để xem tại sao lỗi (cayyyyyyyy) 