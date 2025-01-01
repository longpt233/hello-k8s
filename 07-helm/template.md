https://viblo.asia/p/helm-la-gi-no-co-lien-quan-gi-den-series-nay-Do754oAQlM6

1. lệnh

```
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm version --short
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm search repo stable
helm repo update
helm search repo nginx
```

Install

```
helm install demo stable/nginx-ingress
helm uninstall demo
```

2. mặc định

Structure
```
helm create template-project

-> cấu trúc thư mục như sau
/template-project
    /Chart.yaml # mô tả của chart
    /values.yaml # các giá trị mặc định, chúng ta có thể thay đổi trong khi cài đặt hay nâng cấp project của chúng ta
    /charts/ # subcharts
    /templates/ # template file
```

full 

```
long@hello:~/Documents/hello-k8s/7-helm/template-project$ tree
.
├── charts
├── Chart.yaml
├── templates
│   ├── deployment.yaml
│   ├── _helpers.tpl
│   ├── hpa.yaml
│   ├── ingress.yaml
│   ├── NOTES.txt
│   ├── serviceaccount.yaml
│   ├── service.yaml
│   └── tests
│       └── test-connection.yaml
└── values.yaml

4 directories, 10 files
```
