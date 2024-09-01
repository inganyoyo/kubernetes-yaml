#install nfs 
yum install nfs-utils bind bind-chroot bind-utils

# export setting
vim /etc/exports
/share/k8s-nfs  *(rw,async,no_root_squash,no_all_squash,no_subtree_check)

# restart
systemctl enable --now nfs-server
systemctl status nfs-server
