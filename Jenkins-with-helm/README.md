# Jenkins-with-helm

> You can install Jenkins via helm

---

#### git clone

```
git clone https://github.com/inganyoyo/kubernetes-yaml.git
cd ./kubernetes-yaml/Jenkins-with-helm
```

#### change chmod

```
sudo chmod +x ./*.sh
```

### Install Jenkins

```
kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-jenkins-pv.yaml
#kubectl apply -f 02-jenkins-pvc.yaml # 미사용
./03-install-jenkins-helm.sh
#kubectl apply -f 05-ingress.yaml # 미사용
```
