# Argo-with-helm

- You can install ArgoCd via helm
- with ingress

---

#### git clone

```
git clone https://github.com/inganyoyo/kubernetes-yaml.git
cd ./kubernetes-yaml/Argocd-with-helm
```

### Install Jenkins

```
kubectl apply -f 00-namespace.yaml
helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd --namespace=argocd --version 4.10.9
kubectl apply -f 01-argocd-server-ingress.yaml
```

### reference
#### https://artifacthub.io/packages/helm/argo/argo-cd
#### https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/