# Ingress-nginx-with-helm

> You can install Ingress-nginx via helm

---

#### git clone

```
git clone https://github.com/inganyoyo/kubernetes-yaml.git
cd ./kubernetes-yaml/Ingress-nginx-with-helm
```


### Install Ingress-nginx

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
kubectl create namespace ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx
```
