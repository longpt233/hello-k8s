

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
