helm delete keycloak --namespace keycloak
kubectl delete pvc --all -n keycloak
kubectl delete -f 01-pv.yaml

