echo "Preparation MetalLB"

kubectl get configmap kube-proxy -n kube-system -o yaml | \
grep strictARP

# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

echo "Install MetalLB"

MetalLB_RTAG=$(curl -s https://api.github.com/repos/metallb/metallb/releases/latest|grep tag_name|cut -d '"' -f 4|sed 's/v//')
echo $MetalLB_RTAG

mkdir ./metallb
cd ./metallb

cp ../config.yaml ./config.yaml

wget https://raw.githubusercontent.com/metallb/metallb/v$MetalLB_RTAG/config/manifests/metallb-native.yaml

kubectl apply -f metallb-native.yaml
kubectl apply -f config.yaml
