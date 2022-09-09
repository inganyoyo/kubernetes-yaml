kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-pv.yaml
helm install keycloak bitnami/keycloak --namespace keycloak -f 02-custom-values.yaml
#kubectl logs -n keycloak pod/keycloak-postgresql-0
