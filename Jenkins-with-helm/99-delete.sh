helm uninstall jenkins --namespace=jenkins 
kubectl delete pvc jenkins --namespace=jenkins
kubectl delete -f 02-jenkins-pvc.yaml 
kubectl delete -f 01-jenkins-pv.yaml