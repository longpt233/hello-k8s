

For gitlab repos you have to pass the full repo name including .git. like https://gitlab.com/group/repo.git
https://gitlab.com/longpt233/devops-manifest-repo.git

Then, connect the repository using any non-empty string as username and the access token value as a password. 
non
token read là được

Luồng: commit vào repo manifest -> 
tạo app:
- tên app 
- project name: cái này phải tạo từ trước nhé
- sync manual
- source: repo -> tạo từ trước, nhánh, path tự nhảy
- des: tên cụm, tên ns, chú ý phải tạo trước
- helm: điền VALUES FILES 

sau đó ấn sync lại 

nếu rb gấp thì ấn luôn vì nó lưu rev 
còn k thì tiến hành rb trên git và sync lại

cái log lỗi phải vào trong event mới thấy rõ cay: như deploy cái ingress sau bị lỗi k có quyền -> phải cấp thêm

long@hello:~/Documents/devops-manifest-repo$ helm pull nginx-stable/nginx-ingress --version 0.13.0
long@hello:~/Documents/devops-manifest-repo$ tar -xzf nginx-ingress-0.13.0.tgz
long@hello:~/Documents/devops-manifest-repo$ cp nginx-ingress/values.yaml nginx-ingress/value-nginx-ingress-staging-k8s.yaml
long@hello:~/Documents/devops-manifest-repo$ rm nginx-ingress-0.13.0.tgz 


change type: LoadBalancer NodePort, nodePort: "" nodePort: "30080"  trong nginx-ingress/value-nginx-ingress-staging-k8s.yaml

kubectl create ns nginx-ingress
apply argo cd value file value-nginx-ingress-staging-k8s.yaml

cho quyen project -> nếu k sẽ k sync được
destination
https://kubernetes.default.svc in-cluster *
cluster resource allow list
* *
namespace resource allow list
* *

