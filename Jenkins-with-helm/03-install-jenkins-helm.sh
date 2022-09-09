kubectl apply -f 01-jenkins-pv.yaml 
kubectl apply -f 02-jenkins-pvc.yaml
helm repo add jenkins https://charts.jenkins.io
helm install jenkins jenkins/jenkins --namespace=jenkins -f 04-custom-values.yaml

#
#helm uninstall jenkins --namespace=jenkins 
