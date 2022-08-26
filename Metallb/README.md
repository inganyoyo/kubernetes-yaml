# Metallb

> You can install Metallb

---

#### git clone

```
git clone https://github.com/inganyoyo/kubernetes-yaml.git
cd ./kubernetes-yaml/Metallb
```

### Install Jenkins
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
```
kubectl apply -f config.yaml
kubectl apply -f 02-jenkins-pvc.yaml
```
