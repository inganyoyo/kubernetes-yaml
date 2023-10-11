# Step 1: Helm3 설치
cd ~/
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

#Step 2: Nginx Ingress Controller 설치
controller_tag=$(curl -s https://api.github.com/repos/kubernetes/ingress-nginx/releases/latest | grep tag_name | cut -d '"' -f 4)
wget https://github.com/kubernetes/ingress-nginx/archive/refs/tags/${controller_tag}.tar.gz

tar xvf ${controller_tag}.tar.gz
cd ingress-nginx-${controller_tag}
cd charts/ingress-nginx/
kubectl create namespace ingress-nginx

helm install -n ingress-nginx ingress-nginx  -f values.yaml .

#Step 3: ingress-nginx 설치 확인 및 hosts 수정
kubectl get all -n ingress-nginx
# NAME                                            READY   STATUS    RESTARTS      AGE
# pod/ingress-nginx-controller-6884c69657-5z7vz   1/1     Running   0             11m
# pod/ingress-nginx-controller-6884c69657-h46xr   1/1     Running   1 (25h ago)   25h

# NAME                                         TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)                      AGE
# service/ingress-nginx-controller             LoadBalancer   10.100.239.79    192.168.1.30   80:31822/TCP,443:31814/TCP   26h
# service/ingress-nginx-controller-admission   ClusterIP      10.100.230.130   <none>         443/TCP                      26h

#/etc/hosts 추가
192.168.1.30 ingress.test.com

#Step 4: ingress 테스트
#1. Setting Nginx Ingress to use MetalLB
#Check Nginx Ingress service.

kubectl apply -f 00-deployment.yaml
kubectl apply -f 01-service.yaml
kubectl apply -f 02-config.yaml