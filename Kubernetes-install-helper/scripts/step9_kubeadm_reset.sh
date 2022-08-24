  sudo apt-mark unhold kubelet kubeadm kubectl
  yes | sudo kubeadm reset
  sudo systemctl restart kubelet
  sudo apt purge kubeadm -y
  sudo apt purge kubelet -y
  sudo apt purge kubectl -y
  sudo rm -rf ~/.kube/
  sudo rm -rf /etc/kubernetes/ingan