
[root@bi-data1 ~]# vim  /etc/sysconfig/iptables
-A INPUT -s 192.168.cc.7 -m tcp -p tcp -m multiport --dports 5432 -m comment --comment "gpu ml flow" -j ACCEPT

gpu@dev-gpu2:/home/tungnt$ vim /etc/sysconfig/iptables 
iptables -A OUTPUT -m state --state NEW -d 192.168.cc.12 -m tcp -p tcp -m multiport --dports 5432 -m comment --comment "Connect to postgres"  -j ACCEPT



CREATE DATABASE mlflow_db;
CREATE USER mlflow_user WITH PASSWORD 'xxxxxxxxxxxx' ; 
ALTER DATABASE mlflow_db OWNER TO mlflow_user;

CREATE DATABASE mlflow_auth_db;
ALTER DATABASE mlflow_auth_db OWNER TO mlflow_user;


su -
groupadd mlflow
useradd -m -g mlflow mlflow
# sudo usermod -aG root mlflow
# id mlflow
# cat /etc/group
# userdel -r mlflow #-r : home remove
cd /opt  
mkdir mlflow && chown -R mlflow:mlflow mlflow 
vim /opt/mlflow/basic_auth.ini
cd /opt/mlflow
python3.10 -m venv mlflow-venv    
source mlflow-venv/bin/activate    
pip install mlflow[extras]==2.18.0 
pip install psycopg2-binary==2.9.9     
python3 -m pip install gevent 
# apt install python3-geventcd 
vim /etc/systemd/system/mlflow.service  
chown -R mlflow:mlflow /opt/mlflow/

ExecStart=/opt/mlflow/mlflow-venv/bin/mlflow server -w 4 --gunicorn-opts '-k gevent' --backend-store-uri postgresql://mlflow_user:*****@*****:5432/mlflow_db --artifacts-destination /opt/mlflow/artifacts --host 0.0.0.0 --port 5000 --app-name basic-auth --expose-prometheus /opt/mlflow/prometheus-storage
ExecStart=/opt/mlflow/mlflow-venv/bin/mlflow server -w 4 --gunicorn-opts '-k gevent' --backend-store-uri postgresql://mlflow_user:***@*****:5432/mlflow_db --artifacts-destination hdfs://0.0.0.0:9000/mlflow --host 0.0.0.0 --port 5000 --app-name basic-auth --expose-prometheus /opt/mlflow/metrics

systemctl daemon-reload  && systemctl enable mlflow.service  


systemctl start mlflow.service
systemctl status mlflow.service    
