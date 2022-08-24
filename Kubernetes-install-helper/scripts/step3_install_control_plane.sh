echo "##Install helm##"
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo "##Install a CSI driver##"
# Add openebs repo to helm
helm repo add openebs https://openebs.github.io/charts

echo "##Install a test##"
# Add bitnami repo to helm
helm repo add bitnami https://charts.bitnami.com/bitnami 
helm install wordpress bitnami/wordpress \  --set=global.storageClass=openebs-hostpath

echo "##print result##"
kubectl get pods --all-namespaces
