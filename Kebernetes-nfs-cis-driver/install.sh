# https://github.com/kubernetes-csi/csi-driver-nfs/blob/master/docs/install-csi-driver-v4.8.0.md


git clone https://github.com/kubernetes-csi/csi-driver-nfs.git
cd csi-driver-nfs
./deploy/install-driver.sh v4.8.0 local

kubectl -n kube-system get pod -o wide -l app=csi-nfs-controller
kubectl -n kube-system get pod -o wide -l app=csi-nfs-node

kubectl apply -f ./nfs-csi-sc.yaml
# Uninstall
# git clone https://github.com/kubernetes-csi/csi-driver-nfs.git
# cd csi-driver-nfs
# git checkout v4.8.0
# ./deploy/uninstall-driver.sh v4.8.0 local