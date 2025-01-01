

sh

```
mlflow models serve --model-uri runs:/ede4cc6ace71468ab2e881dc14d25f6b/models --port 5050
```

docker file 

```
FROM python:3.8.12-slim-buster

RUN pip install mlflow pandas flask cloudpickle==1.6.0 psutil==5.8.0 scikit-learn==0.24.1

WORKDIR /model 

COPY ./mlruns/1/ede4cc6ace71468ab2e881dc14d25f6b/artifacts/models/ .

CMD ["mlflow","models","serve","-m","./","-h","0.0.0.0","-p","5000","--no-conda"]
EXPOSE 5000

```