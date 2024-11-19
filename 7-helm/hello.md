https://viblo.asia/p/helm-la-gi-no-co-lien-quan-gi-den-series-nay-Do754oAQlM6


1. Tạo helm

```
helm create hello-project
cd hello-project
rm -rf templates/
rm -rf values.yaml
touch values.yaml
mkdir -p templates/deployment
touch templates/deployment/coffee-deployment.yaml
mkdir -p templates/service
touch templates/service/coffee-service.yaml
```


2. Chạy lên

```
long@hello:~/Documents/hello-k8s/7-helm/hello-project$ helm install --debug --dry-run hello-project .
helm install hello-project hello-project
kubectl get svc,po,deploy
kubectl describe svc coffee-svc
```

3. Vận hành 

```
helm upgrade hello-project hello-project
helm history hello-project
helm rollback hello-project 1
helm uninstall hello-project
```