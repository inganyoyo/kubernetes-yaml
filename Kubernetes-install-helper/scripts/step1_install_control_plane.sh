echo "https://blog.radwell.codes/2022/07/single-node-kubernetes-cluster-via-kubeadm-on-ubuntu-22-04/"
echo "##Install general dependencies##"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl


echo "##Install containerd##"
curl -fsSLo containerd-config.toml \
  https://gist.githubusercontent.com/oradwell/31ef858de3ca43addef68ff971f459c2/raw/5099df007eb717a11825c3890a0517892fa12dbf/containerd-config.toml
sudo mkdir /etc/containerd
sudo mv containerd-config.toml /etc/containerd/config.toml

curl -fsSLo containerd-1.5.13-linux-amd64.tar.gz \
  https://github.com/containerd/containerd/releases/download/v1.5.13/containerd-1.5.13-linux-amd64.tar.gz

# Extract the binaries
sudo tar Cxzvf /usr/local containerd-1.5.13-linux-amd64.tar.gz

# Install containerd as a service
sudo curl -fsSLo /etc/systemd/system/containerd.service \
  https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

sudo systemctl daemon-reload
sudo systemctl enable --now containerd

echo "##Install runc##"
curl -fsSLo runc.amd64 \
  https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

echo "##Install CNI network plugins##"
curl -fsSLo cni-plugins-linux-amd64-v1.1.1.tgz \
  https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz

echo "##Forward IPv4 and let iptables see bridged network traffic##"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe -a overlay br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

echo "##Install kubeadm, kubelet & kubectl"
# Add Kubernetes GPG key
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg \
  https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Add Kubernetes apt repository
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Fetch package list
sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

# Prevent them from being updated automatically
sudo apt-mark hold kubelet kubeadm kubectl

echo "##Ensure swap is disabled##"
# See if swap is enabled
swapon --show

# Turn off swap
sudo swapoff -a

# Disable swap completely
sudo sed -i -e '/swap/d' /etc/fstab

echo "##Create the cluster using kubeadm##"
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

echo "##Configure kubectl##"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc

echo "##Untaint node##"
#kubectl taint nodes --all node-role.kubernetes.io/master-
#kubectl taint nodes --all node-role.kubernetes.io/control-plane-
#kubectl taint nodes k8s-control-plane node-role.kubernetes.io=master:NoSchedule

echo "##Install a CNI plugin##"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
