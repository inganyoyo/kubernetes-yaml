echo "ssh-keygen 생성 "
ssh-keygen -t rsa

echo "copy"
ssh-copy-id userid@ip

echo "##Install openssh-server##"
sudo apt update
sudo apt install openssh-server

echo "##Change root password##"
sudo passwd root

su - root
# See if swap is enabled
swapon --show
# Turn off swap
sudo swapoff -a
# Disable swap completely
sudo sed -i -e '/swap/d' /etc/fstab

reboot now

echo "##Change hostname##"
sudo hostnamectl set-hostname k8s-xxxxx
