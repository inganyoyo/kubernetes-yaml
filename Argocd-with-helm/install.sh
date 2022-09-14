kubectl apply -f 00-namespace.yaml

helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd --namespace=argocd --version 4.10.9

kubectl apply -f 01-argocd-server-ingress.yaml