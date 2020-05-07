#!/bin/bash
sudo su 
# Create User chef-training
useradd chef-training
yum install expect -y
# Set password for user
SET_PASSWORD=$(expect -c "
set timeout 10
spawn passwd chef-training
expect \"New password:\"
send \"123Chef321\r\"
expect \"Retype new password:\"
send \"123Chef321\r\"
expect eof
")
echo "$SET_PASSWORD"
# Give user sudo access
usermod -aG wheel chef-training

# Modify box so that you can SSH without pem files
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/PasswordAuthentication no/ /g" /etc/ssh/sshd_config
systemctl restart sshd


# Setup class:
su - chef-training
sudo yum install wget -y
sudo yum install tree -y
sudo wget https://packages.chef.io/files/stable/chef-workstation/0.17.5/el/7/chef-workstation-0.17.5-1.el7.x86_64.rpm
sudo rpm -ivh chef-workstation-0.17.5-1.el7.x86_64.rpm
sudo yum check-update
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
