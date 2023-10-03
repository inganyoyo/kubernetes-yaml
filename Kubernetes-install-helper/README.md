# Kubernetes-install-helper

> You can install docker, kubectl, kubelet and kubeadm. <br> K8s will be installed via containerd by kubeadm

---

#### OS

-   Ubuntu 20.04

#### Kuberbetes
- version: 1.24.4-00
- Container Runtime: containerd
- CNI: flannel

#### git clone

```
git clone https://github.com/inganyoyo/kubernetes-yaml.git
cd ./kubernetes-yaml/Kubernetes_install_helper
```

#### change chmod

```
sudo chmod +x ./scripts/*.sh
```

### Install Kubernetes

```
./scripts/step0_install_common.sh
./scripts/step1_install_control_plane.sh
./scripts/step2_install_worker_node.sh
./scripts/step9_kubeadm_reset.sh
```

#### Reset kubeadm
```
./scripts/step9_kubeadm_reset.sh #control-planel, worker-node
```
