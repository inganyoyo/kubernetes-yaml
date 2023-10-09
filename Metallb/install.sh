echo "Install MetalLB"

MetalLB_RTAG=$(curl -s https://api.github.com/repos/metallb/metallb/releases/latest|grep tag_name|cut -d '"' -f 4|sed 's/v//')
echo $MetalLB_RTAG

mkdir ~/metallb
cd ~/metallb

wget https://raw.githubusercontent.com/metallb/metallb/v$MetalLB_RTAG/config/manifests/metallb-native.yaml

kubectl apply -f metallb-native.yaml
kubectl apply -f config.yaml
