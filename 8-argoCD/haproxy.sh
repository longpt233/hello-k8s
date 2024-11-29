

sudo apt install --no-install-recommends software-properties-common
sudo add-apt-repository ppa:vbernat/haproxy-2.4 -y
sudo apt install haproxy=2.4.\*

or
sudo apt install haproxy


sudo vim /etc/haproxy/haproxy.cfg

```
# Phần frontend (tiếp nhận yêu cầu từ client)
frontend http_front
    bind 0.0.0.0:8061
    mode http
    log global

    # Phân luồng theo `Host`
    acl host_app1 hdr(host) -i argocd.example.com

    # Định tuyến đến backend tương ứng
    use_backend app1_backend if host_app1

    # Nếu không khớp domain nào, trả lỗi 503
    default_backend error_backend

# Phần backend (các ứng dụng đích)
backend app1_backend
    mode http
    balance roundrobin
    server app1_server1 127.0.0.1:9091 check
    # server app1_server2 127.0.0.1:9091 check

# Backend mặc định (trường hợp không khớp domain)
backend error_backend
    mode http
    errorfile 503 /etc/haproxy/errors/503.http
```

long@hello:~$ sudo haproxy -f /etc/haproxy/haproxy.cfg -c
Configuration file is valid
long@hello:~$ sudo systemctl reload haproxy
long@hello:~$ sudo vim /etc/hosts
127.0.0.1 xuanthulab.test argocd.example.com
-> argocd.example.com vao day la thom (ignore proxy neu can)

