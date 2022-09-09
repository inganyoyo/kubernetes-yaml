helm repo add k8s-dashboard https://kubernetes.github.io/dashboard
kubectl apply -f 00-namespaces.yaml 
helm install kubernetes-dashboard k8s-dashboard/kubernetes-dashboard --version 5.10.0 --namespace kubernetes-dashboard -f 01-custom-values.yaml
kubectl apply -f 02-sa-token.yaml
kubectl -n kubernetes-dashboard describe secrets/admin-user-secret